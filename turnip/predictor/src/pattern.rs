use crate::{
    pdf::{range_intersect, range_intersect_length, IUniform, Uniform},
    price::{self, MinMax, PossiblePrices, Prices, RATE_MULTIPLIER},
};

#[derive(Debug, Clone, Copy)]
pub enum Pattern {
    Fluctuating = 0,
    LargeSpike = 1,
    Decreasing = 2,
    SmallSpike = 3,
    Unsure = 4,
}

pub struct Transition<T> {
    pub fluctuating: T,
    pub large_spike: T,
    pub decreasing: T,
    pub small_spike: T,
}

impl<T> Transition<T> {
    pub const fn new(fluctuating: T, large_spike: T, decreasing: T, small_spike: T) -> Self {
        Self {
            fluctuating,
            large_spike,
            decreasing,
            small_spike,
        }
    }
}

const FLUCTUATING: Transition<f32> = Transition::new(0.20, 0.30, 0.15, 0.35);
const LARGE_SPIKE: Transition<f32> = Transition::new(0.5, 0.05, 0.2, 0.25);
const DECREASING: Transition<f32> = Transition::new(0.25, 0.45, 0.05, 0.25);
const SMALL_SPIKE: Transition<f32> = Transition::new(0.45, 0.25, 0.15, 0.15);
const UNSURE: Transition<f32> = Transition::new(
    4530. / 13082.,
    3236. / 13082.,
    1931. / 13082.,
    3385. / 13082.,
);

impl Pattern {
    pub fn from_int(i: i8) -> Pattern {
        use Pattern::*;
        match i {
            0 => Fluctuating,
            1 => LargeSpike,
            2 => Decreasing,
            3 => SmallSpike,
            _ => Unsure,
        }
    }

    pub fn get_transition_probabilities(self) -> Transition<f32> {
        match self {
            Self::Fluctuating => FLUCTUATING,
            Self::LargeSpike => LARGE_SPIKE,
            Self::Decreasing => DECREASING,
            Self::SmallSpike => SMALL_SPIKE,
            Self::Unsure => UNSURE,
        }
    }
}

pub struct PatternGen {
    buy_price: u16,
    given_prices: Prices,
    predicted_prices: PossiblePrices,
    fudge_factor: u16,
    start_rate: MinMax<f32>,
    decay_rate: MinMax<f32>,
}

pub trait NewPrice {
    fn new(buy_price: u16) -> Self;
}

impl NewPrice for PossiblePrices {
    fn new(buy_price: u16) -> Self {
        let mut predicted_prices = [MinMax::new_val(0); 12];
        predicted_prices[0] = MinMax::new_val(buy_price);
        predicted_prices[1] = MinMax::new_val(buy_price);
        predicted_prices
    }
}

impl PatternGen {
    pub fn new(
        buy_price: u16,
        given_prices: Prices,
        fudge_factor: u16,
        start_rate: MinMax<f32>,
        decay_rate: MinMax<f32>,
    ) -> Self {
        Self {
            buy_price,
            given_prices,
            fudge_factor,
            start_rate,
            decay_rate,
            predicted_prices: PossiblePrices::new(buy_price),
        }
    }

    pub fn prices(&self) -> PossiblePrices {
        self.predicted_prices
    }

    pub fn individual_random_price(
        &mut self,
        start: usize,
        length: usize,
        rate: MinMax<f32>,
    ) -> Option<f32> {
        let rate_min = rate.min() * RATE_MULTIPLIER;
        let rate_max = rate.max() * RATE_MULTIPLIER;

        let rate_range = (rate_min, rate_max);

        let mut prob = 1.;
        for i in start..(start + length) {
            let mut min_pred = price::get(rate_min, self.buy_price);
            let mut max_pred = price::get(rate_max, self.buy_price);
            if let Some(price) = self.given_prices[i] {
                self.check_bounds(price, min_pred, max_pred)?;
                let real_rate_range = rate_range_from_given_and_base(
                    clamp(price, min_pred, max_pred),
                    self.buy_price,
                );
                prob = prob * range_intersect_length(rate_range, real_rate_range)
                    / (real_rate_range.1 - real_rate_range.0);
                min_pred = price;
                max_pred = price;
            }
            self.predicted_prices[i] = MinMax::new(min_pred, max_pred);
        }

        (prob != 0.).then(|| prob)
    }

    fn check_bounds(&self, price: u16, min_pred: u16, max_pred: u16) -> Option<()> {
        (!(price < min_pred - self.fudge_factor || price > max_pred + self.fudge_factor))
            .then(|| {})
    }

    pub fn peak_price(&mut self, start: usize, rate: MinMax<f32>) -> Option<f32> {
        let rate_min = rate.min() * RATE_MULTIPLIER;
        let rate_max = rate.max() * RATE_MULTIPLIER;

        let mut rate_range = (rate_min, rate_max);

        let mut prob = 1.;
        if let Some(price) = self.given_prices[start + 1] {
            let min_pred = price::get(rate_min, self.buy_price);
            let max_pred = price::get(rate_max, self.buy_price);
            self.check_bounds(price, min_pred, max_pred)?;
            let real_rate_range =
                rate_range_from_given_and_base(clamp(price, min_pred, max_pred), self.buy_price);
            prob = prob * range_intersect_length(rate_range, real_rate_range)
                / (rate_range.1 - rate_range.0);
            (prob != 0.).then(|| {})?;
            rate_range = range_intersect(rate_range, real_rate_range)?;
        }

        let left_price = self.given_prices[start];
        let right_price = self.given_prices[start + 2];
        for i in vec![left_price, right_price] {
            if let Some(price) = i {
                let min_pred = price::get(rate_min, self.buy_price) - 1;
                let max_pred = price::get(rate_max, self.buy_price) - 1;
                self.check_bounds(price, min_pred, max_pred)?;
                let rate2_range = rate_range_from_given_and_base(
                    clamp(price, min_pred, max_pred) + 1,
                    self.buy_price,
                );
                let f = |t: f32, zz: f32| {
                    if t <= 0. {
                        return 0.;
                    }
                    if zz < t {
                        zz
                    } else {
                        t - t * (t.ln() - zz.ln())
                    }
                };
                let (a, b) = rate_range;
                let c = rate_min;
                let z1 = a - c;
                let z2 = b - c;
                let py = |t: f32| f(t - c, z2) - f(t - c, z1) / (z2 - z1);
                prob = prob * (py(rate2_range.1) - py(rate2_range.0));
                (prob != 0.).then(|| {})?;
            }
        }

        // Main Spike 1
        self.predicted_prices[start] = if let Some(price) = self.given_prices[start] {
            MinMax::new_val(price)
        } else {
            let min_pred = price::get(rate_min, self.buy_price) - 1;
            let max_pred = price::get(rate_max, self.buy_price) - 1;
            MinMax::new(min_pred, max_pred)
        };
        // Main Spike 2
        self.predicted_prices[start + 1] = if let Some(price) = self.given_prices[start + 1] {
            MinMax::new_val(price)
        } else {
            let min_pred = self.predicted_prices[start].min();
            let max_pred = price::get(rate_max, self.buy_price);
            MinMax::new(min_pred, max_pred)
        };
        // Main Spike 3
        self.predicted_prices[start + 2] = if let Some(price) = self.given_prices[start + 2] {
            MinMax::new_val(price)
        } else {
            let min_pred = price::get(rate_min, self.buy_price) - 1;
            let max_pred = self.predicted_prices[start + 1].max() - 1;
            MinMax::new(min_pred, max_pred)
        };
        // Prob isn't modified in the above code, and we already did early returns everywhere
        Some(prob)
    }

    pub fn decreasing_random_price(&mut self, start: usize, length: usize) -> Option<f32> {
        let start_rate_min = self.start_rate.min() * RATE_MULTIPLIER;
        let start_rate_max = self.start_rate.max() * RATE_MULTIPLIER;
        let rate_decay_min = self.decay_rate.min() * RATE_MULTIPLIER;
        let rate_decay_max = self.decay_rate.max() * RATE_MULTIPLIER;

        let mut pdf = Uniform::new(start_rate_min, start_rate_max);
        let mut prob = 1.;
        for i in start..(start + length) {
            let mut min_pred = price::get(pdf.a(), self.buy_price);
            let mut max_pred = price::get(pdf.b(), self.buy_price);
            if let Some(price) = self.given_prices[i] {
                self.check_bounds(price, min_pred, max_pred)?;
                let real_rate_range = rate_range_from_given_and_base(
                    clamp(price, min_pred, max_pred),
                    self.buy_price,
                );
                prob = prob * pdf.range_limit(real_rate_range);
                (prob != 0.).then(|| prob)?;
                min_pred = price;
                max_pred = price;
            }
            self.predicted_prices[i] = MinMax::new(min_pred, max_pred);
            pdf.decay(rate_decay_min, rate_decay_max);
        }

        (prob != 0.).then(|| prob)
    }
}

fn rate_range_from_given_and_base(given_price: u16, buy_price: u16) -> (f32, f32) {
    (
        RATE_MULTIPLIER * (given_price as f32 - 0.99999) / buy_price as f32,
        RATE_MULTIPLIER * (given_price as f32 + 0.00001) / buy_price as f32,
    )
}

fn clamp<T>(x: T, min: T, max: T) -> T
where
    T: Ord,
{
    max.min(x.max(min))
}
