pub type Prices = [Option<u16>; 12];
pub type PossiblePrices = [MinMax<u16>; 12];

#[derive(Debug, Clone, Copy)]
pub struct MinMax<T>(T, T)
where
    T: Copy;

impl<T> MinMax<T>
where
    T: Copy,
{
    pub const fn new(min: T, max: T) -> Self {
        Self(min, max)
    }

    pub const fn new_val(val: T) -> Self {
        Self(val, val)
    }

    pub const fn min(&self) -> T {
        self.0
    }

    pub const fn max(&self) -> T {
        self.1
    }
}

pub const RATE_MULTIPLIER: f32 = 10000.;

pub fn get(rate: f32, base_price: u16) -> u16 {
    (rate * f32::from(base_price) / RATE_MULTIPLIER).ceil() as u16
}
