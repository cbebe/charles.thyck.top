use crate::pattern::{Pattern, PatternGen};
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

impl Possibility {
    fn multiply_probability(&mut self, probability: f32) {
        self.probability = self.probability * probability;
    }
}

pub fn generate_possibilities(
    buy_price: u16,
    prices: Prices,
    previous_pattern: Pattern,
) -> Option<Possibilities> {
    for i in 0..6 {
        if let Some(possibility) =
            generate_possibilities_with_fudge(buy_price, prices, previous_pattern, i)
        {
            return Some(possibility);
        }
    }
    None
}

macro_rules! add_len {
    ($start:ident, $length: ident, $new_len: expr) => {
        $start = $start + $length;
        $length = $new_len;
    };
}

fn generate_fluctuating(
    buy_price: u16,
    given_prices: Prices,
    lengths: &PhaseLengths,
    fudge_factor: u16,
) -> Option<Possibility> {
    let high_rate = MinMax::new(0.9, 1.4);
    let mut gen = PatternGen::new(
        buy_price,
        given_prices,
        fudge_factor,
        MinMax::new(0.6, 0.8),
        MinMax::new(0.04, 0.1),
    );
    let mut start = 0;
    let mut length = lengths.high_1;
    // High 1
    let mut probability = gen.individual_random_price(start, length, high_rate)?;
    // Low 1
    add_len!(start, length, lengths.low_1);
    probability = probability * gen.decreasing_random_price(start, length)?;
    // High 2
    add_len!(start, length, lengths.high_2);
    probability = probability * gen.individual_random_price(start, length, high_rate)?;
    // Low 2
    add_len!(start, length, lengths.low_2);
    probability = probability * gen.decreasing_random_price(start, length)?;
    // High 3
    add_len!(start, length, lengths.high_3);
    probability = probability * gen.individual_random_price(start, length, high_rate)?;
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
    let mut gen = PatternGen::new(
        buy_price,
        given_prices,
        fudge_factor,
        MinMax::new(0.85, 0.9),
        MinMax::new(0.03, 0.05),
    );
    let mut probability = gen.decreasing_random_price(0, peak_start)?;
    let min_randoms = [0.9, 1.4, 2.0, 1.4, 0.9, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4];
    let max_randoms = [1.4, 2.0, 6.0, 2.0, 1.4, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9];
    for i in peak_start..12 {
        let rate = MinMax::new(min_randoms[i - peak_start], max_randoms[i - peak_start]);
        probability = probability * gen.individual_random_price(i, 1, rate)?;
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
    let mut gen = PatternGen::new(
        buy_price,
        given_prices,
        fudge_factor,
        MinMax::new(0.4, 0.9),
        MinMax::new(0.03, 0.05),
    );

    let mut probability = gen.decreasing_random_price(0, peak_start)?;

    let rate = MinMax::new(0.9, 1.4);
    probability = probability * gen.individual_random_price(peak_start, 2, rate)?;

    let rate = MinMax::new(1.4, 2.0);
    probability = probability * gen.peak_price(peak_start + 2, rate)?;

    probability =
        probability * gen.decreasing_random_price(peak_start + 5, 12 - (peak_start + 5))?;

    Some(Possibility {
        pattern: Pattern::SmallSpike,
        prices: gen.prices(),
        probability,
    })
}

fn get_array<F>(mut f: F) -> Option<Possibilities>
where
    F: FnMut(&mut Possibilities) -> (),
{
    let mut possibilities = vec![];

    f(&mut possibilities);

    (!possibilities.is_empty()).then(|| possibilities)
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
        for low_phase_1_len in 2..4 {
            for high_phase_1_len in 0..7 {
                for high_phase_3_len in 0..(7 - high_phase_1_len) {
                    let lengths = PhaseLengths {
                        high_1: high_phase_1_len,
                        low_1: low_phase_1_len,
                        high_2: 7 - high_phase_1_len - high_phase_3_len,
                        low_2: 5 - low_phase_1_len,
                        high_3: high_phase_3_len,
                    };
                    let generated = generate_fluctuating(buy_price, prices, &lengths, fudge_factor);
                    if let Some(mut p) = generated {
                        p.multiply_probability(
                            1. / (4. - 2.) / 7. / (7. - (high_phase_1_len as f32)),
                        );
                        possibilities.push(p);
                    }
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
    let mut gen = PatternGen::new(
        buy_price,
        given_prices,
        fudge_factor,
        MinMax::new(0.85, 0.9),
        MinMax::new(0.03, 0.05),
    );
    let probability = gen.decreasing_random_price(0, 12)?;
    Some(vec![Possibility {
        pattern: Pattern::Decreasing,
        prices: gen.prices(),
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
    fn new(buy_price: u16, prices: Prices, fudge_factor: u16) -> Self {
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

fn generate_possibilities_with_fudge(
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
    (!gen.possibilities.is_empty()).then(|| gen.possibilities)
}
