use alloc::vec::Vec;

use crate::pattern::{self, Pattern};
use crate::price::{MinMax, PossiblePrices, Prices};

pub struct PhaseLengths {
    high_1: usize,
    low_1: usize,
    high_2: usize,
    low_2: usize,
    high_3: usize,
}

#[derive(Debug)]
pub struct Possibility {
    pub pattern: Pattern,
    pub prices: PossiblePrices,
    pub probability: f32,
}

pub type Possibilities = Vec<Possibility>;

pub struct WithFudge(pub Possibilities, pub u16);

impl Possibility {
    fn multiply_probability(&mut self, probability: f32) {
        self.probability *= probability;
    }
}

const DEFAULT_DECAY_RATE: MinMax<f32> = MinMax::new(0.03, 0.05);
const FIRST_HIGH_RATE: MinMax<f32> = MinMax::new(0.9, 1.4);
const LOW_START_RATE: MinMax<f32> = MinMax::new(0.85, 0.9);

pub fn generate(buy_price: u16, prices: Prices, previous_pattern: Pattern) -> Option<WithFudge> {
    for i in 0..6 {
        if let Some(possibility) = generate_with_fudge(buy_price, prices, previous_pattern, i) {
            return Some(WithFudge(possibility, i));
        }
    }
    None
}

macro_rules! add_len {
    ($start:ident, $length: ident, $new_len: expr) => {
        $start += $length;
        $length = $new_len;
    };
}

fn generate_fluctuating(
    buy_price: u16,
    given_prices: Prices,
    lengths: &PhaseLengths,
    fudge_factor: u16,
) -> Option<Possibility> {
    const START_RATE: MinMax<f32> = MinMax::new(0.6, 0.8);
    const DECAY_RATE: MinMax<f32> = MinMax::new(0.04, 0.1);
    let mut gen = pattern::Generator::new(
        buy_price,
        given_prices,
        fudge_factor,
        START_RATE,
        DECAY_RATE,
    );
    let mut start = 0;
    let mut length = lengths.high_1;
    // High 1
    let mut probability = gen.individual_random_price(start, length, FIRST_HIGH_RATE)?;
    // Low 1
    add_len!(start, length, lengths.low_1);
    probability *= gen.decreasing_random_price(start, length)?;
    // High 2
    add_len!(start, length, lengths.high_2);
    probability *= gen.individual_random_price(start, length, FIRST_HIGH_RATE)?;
    // Low 2
    add_len!(start, length, lengths.low_2);
    probability *= gen.decreasing_random_price(start, length)?;
    // High 3
    add_len!(start, length, lengths.high_3);
    probability *= gen.individual_random_price(start, length, FIRST_HIGH_RATE)?;
    Some(Possibility {
        pattern: Pattern::Fluctuating,
        prices: gen.prices(),
        probability,
    })
}

fn generate_large_spike(
    buy_price: u16,
    given_prices: Prices,
    peak_start: usize,
    fudge_factor: u16,
) -> Option<Possibility> {
    const MIN_RANDOMS: [f32; 11] = [0.9, 1.4, 2.0, 1.4, 0.9, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4];
    const MAX_RANDOMS: [f32; 11] = [1.4, 2.0, 6.0, 2.0, 1.4, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9];
    let mut gen = pattern::Generator::new(
        buy_price,
        given_prices,
        fudge_factor,
        LOW_START_RATE,
        DEFAULT_DECAY_RATE,
    );
    let mut probability = gen.decreasing_random_price(0, peak_start)?;
    for i in peak_start..12 {
        let rate = MinMax::new(MIN_RANDOMS[i - peak_start], MAX_RANDOMS[i - peak_start]);
        probability *= gen.individual_random_price(i, 1, rate)?;
    }
    Some(Possibility {
        pattern: Pattern::LargeSpike,
        prices: gen.prices(),
        probability,
    })
}

fn generate_small_spike(
    buy_price: u16,
    given_prices: Prices,
    peak_start: usize,
    fudge_factor: u16,
) -> Option<Possibility> {
    const START_RATE: MinMax<f32> = MinMax::new(0.4, 0.9);
    const SPIKE_RATE: MinMax<f32> = MinMax::new(1.4, 2.0);

    let mut gen = pattern::Generator::new(
        buy_price,
        given_prices,
        fudge_factor,
        START_RATE,
        DEFAULT_DECAY_RATE,
    );

    let mut probability = gen.decreasing_random_price(0, peak_start)?;

    probability *= gen.individual_random_price(peak_start, 2, FIRST_HIGH_RATE)?;

    probability *= gen.peak_price(peak_start + 2, SPIKE_RATE)?;

    probability *= gen.decreasing_random_price(peak_start + 5, 12 - (peak_start + 5))?;

    Some(Possibility {
        pattern: Pattern::SmallSpike,
        prices: gen.prices(),
        probability,
    })
}

fn get_array<F>(mut f: F) -> Option<Possibilities>
where
    F: FnMut(&mut Possibilities),
{
    let mut possibilities = vec![];

    f(&mut possibilities);

    (!possibilities.is_empty()).then_some(possibilities)
}

fn get_large_spike_patterns(
    buy_price: u16,
    prices: Prices,
    fudge_factor: u16,
) -> Option<Possibilities> {
    get_array(|possibilities| {
        for peak_start in 1..8 {
            let generated = generate_large_spike(buy_price, prices, peak_start, fudge_factor);
            if let Some(mut p) = generated {
                p.multiply_probability(1. / (10. - 3.));
                possibilities.push(p);
            }
        }
    })
}

fn get_small_spike_patterns(
    buy_price: u16,
    prices: Prices,
    fudge_factor: u16,
) -> Option<Possibilities> {
    get_array(|possibilities| {
        for peak_start in 0..8 {
            let generated = generate_small_spike(buy_price, prices, peak_start, fudge_factor);
            if let Some(mut p) = generated {
                p.multiply_probability(1. / 8.);
                possibilities.push(p);
            }
        }
    })
}

fn get_fluctuating_patterns(
    buy_price: u16,
    prices: Prices,
    fudge_factor: u16,
) -> Option<Possibilities> {
    get_array(|possibilities| {
        let mut generate = |lp1: usize, hp1: usize, hp3: usize| {
            let lengths = PhaseLengths {
                high_1: hp1,
                low_1: lp1,
                high_2: 7 - hp1 - hp3,
                low_2: 5 - lp1,
                high_3: hp3,
            };
            let generated = generate_fluctuating(buy_price, prices, &lengths, fudge_factor);
            if let Some(mut p) = generated {
                p.multiply_probability(1. / (4. - 2.) / 7. / (7. - (hp1 as f32)));
                possibilities.push(p);
            }
        };
        for low_phase_1_len in 2..4 {
            for high_phase_1_len in 0..7 {
                for high_phase_3_len in 0..(7 - high_phase_1_len) {
                    generate(low_phase_1_len, high_phase_1_len, high_phase_3_len);
                }
            }
        }
    })
}

fn get_decreasing_patterns(
    buy_price: u16,
    given_prices: Prices,
    fudge_factor: u16,
) -> Option<Possibilities> {
    let mut gen = pattern::Generator::new(
        buy_price,
        given_prices,
        fudge_factor,
        LOW_START_RATE,
        DEFAULT_DECAY_RATE,
    );
    let probability = gen.decreasing_random_price(0, 12)?;
    let prices = gen.prices();
    Some(vec![Possibility {
        pattern: Pattern::Decreasing,
        prices,
        probability,
    }])
}

fn multiply_probabilities(
    possibilities: &mut Possibilities,
    results: Possibilities,
    probability: f32,
) {
    let mut multiplied = results
        .into_iter()
        .map(|mut f| {
            f.multiply_probability(probability);
            f
        })
        .collect();
    possibilities.append(&mut multiplied);
}

struct Generator {
    buy_price: u16,
    prices: Prices,
    fudge_factor: u16,
    possibilities: Possibilities,
}

impl Generator {
    const fn new(buy_price: u16, prices: Prices, fudge_factor: u16) -> Self {
        Self {
            buy_price,
            prices,
            fudge_factor,
            possibilities: vec![],
        }
    }

    fn add_possibility<F>(&mut self, f: F, probability: f32)
    where
        F: Fn(u16, Prices, u16) -> Option<Possibilities>,
    {
        if let Some(results) = f(self.buy_price, self.prices, self.fudge_factor) {
            multiply_probabilities(&mut self.possibilities, results, probability);
        }
    }
}

fn generate_with_fudge(
    buy_price: u16,
    prices: Prices,
    previous_pattern: Pattern,
    fudge_factor: u16,
) -> Option<Vec<Possibility>> {
    let transition = previous_pattern.get_transition_probabilities();
    let mut gen = Generator::new(buy_price, prices, fudge_factor);
    gen.add_possibility(get_fluctuating_patterns, transition.fluctuating);
    gen.add_possibility(get_large_spike_patterns, transition.large_spike);
    gen.add_possibility(get_small_spike_patterns, transition.small_spike);
    gen.add_possibility(get_decreasing_patterns, transition.decreasing);
    (!gen.possibilities.is_empty()).then_some(gen.possibilities)
}
