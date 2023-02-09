#![no_std]

mod pattern;
mod pdf;
mod possibilities;
mod price;

#[macro_use]
extern crate alloc;

use alloc::vec::Vec;
use core::convert::TryInto;
use js_sys::Float32Array;
use pattern::Pattern;
use price::Prices;
use wasm_bindgen::prelude::wasm_bindgen;
use wasm_bindgen::JsValue;

#[derive(Debug, PartialEq, Eq)]
pub enum PredictorError {
    BadBuyPrice,
    BadPriceList,
    ImpossibleValues,
}

const BAD_BUY_PRICE: &str = "bad buy price";
const BAD_PRICE_LIST: &str = "bad price list";
const IMPOSSIBLE_VALUES: &str = "impossible values";

impl From<PredictorError> for JsValue {
    fn from(p: PredictorError) -> Self {
        match p {
            PredictorError::BadBuyPrice => Self::from_str(BAD_BUY_PRICE),
            PredictorError::BadPriceList => Self::from_str(BAD_PRICE_LIST),
            PredictorError::ImpossibleValues => Self::from_str(IMPOSSIBLE_VALUES),
        }
    }
}

fn conv<T, const N: usize>(v: Vec<T>) -> Option<[T; N]> {
    v.try_into().ok()
}

fn get_prices(prices: &str) -> Option<Prices> {
    conv(prices.split(',').map(|x| x.parse::<u16>().ok()).collect())
}

fn _predict(
    buy_price: u16,
    prices: &str,
    previous_pattern: Pattern,
) -> Result<Vec<f32>, PredictorError> {
    let possibilities = {
        if !(90..=110).contains(&buy_price) {
            return Err(PredictorError::BadBuyPrice);
        }
        let prices = match get_prices(prices) {
            Some(arr) => arr,
            None => return Err(PredictorError::BadPriceList),
        };
        match possibilities::generate(buy_price, prices, previous_pattern) {
            Some(p) => p,
            None => return Err(PredictorError::ImpossibleValues),
        }
    };

    let total_probability = possibilities
        .0
        .iter()
        .fold(0., |acc, it| acc + it.probability);
    let mut floats: Vec<f32> = possibilities
        .0
        .into_iter()
        .flat_map(|mut it| {
            it.probability /= total_probability;
            let mut floats: Vec<f32> = vec![it.pattern as i32 as f32, it.probability];
            let mut prices = it
                .prices
                .map(|x| vec![f32::from(x.min()), f32::from(x.max())])
                .concat();
            floats.append(&mut prices);
            floats
        })
        .collect();

    let mut result: Vec<f32> = vec![f32::from(possibilities.1)];
    result.append(&mut floats);
    Ok(result)
}

/// # Errors
///
/// Will return `Err` if given a bad `buy_price`, a bad `price_list`,
/// or if the prediction yields impossible values.
#[wasm_bindgen]
pub fn predict(
    buy_price: u16,
    prices: &str,
    previous_pattern: i8,
) -> Result<Float32Array, PredictorError> {
    // utils::set_panic_hook();
    let previous_pattern = Pattern::from_int(previous_pattern);
    match _predict(buy_price, prices, previous_pattern) {
        Ok(val) => Ok(Float32Array::from(&val[..])),
        Err(err) => Err(err),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const FLUCTUATING: &str = "105,99,115,58,51,117,121,124,109,71,65,60";
    const LARGE_SPIKE: &str = "91,87,83,79,74,71,100,192,415,158,143,69";
    const SMALL_SPIKE: &str = "93,134,173,63,55,47,121,169,166,60,50,42";
    const DECREASING: &str = "82,78,75,71,68,64,60,56,,,,";

    #[test]
    fn test_decreasing() {
        assert_eq!(
            _predict(100, DECREASING, Pattern::Decreasing),
            Ok(vec![
                3., // Fudge factor of 3
                2., 1., 82., 82., 78., 78., 75., 75., 71., 71., 68., 68., 64., 64., 60., 60., 56.,
                56., 50., 54., 45., 51., 40., 48., 35., 45.,
            ])
        );
    }

    #[test]
    fn test_fluctuating() {
        let sure: &'static str = "120,120,120,120,120,120,,,,,,";
        assert_eq!(
            _predict(100, sure, Pattern::Decreasing),
            Ok(vec![
                0., // Fudge factor of 0
                0., 0.5, 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120.,
                60., 80., 50., 76., 90., 140., 60., 80., 50., 76., 40., 72., // Pattern 1
                0., 0.5, 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120.,
                60., 80., 50., 76., 40., 72., 90., 140., 60., 80., 50., 76., // Pattern 2
            ])
        );
    }

    #[test]
    fn test_large_spike() {
        let sure: &'static str = "91,87,83,79,74,71,100,192,,,,";
        assert_eq!(
            _predict(100, sure, Pattern::Unsure),
            Ok(vec![
                1., // Fudge factor of 1
                1., 1., 91., 91., 87., 87., 83., 83., 79., 79., 74., 74., 71., 71., 100., 100.,
                192., 192., 200., 600., 140., 200., 90., 140., 40., 90.
            ])
        );
    }

    #[test]
    fn test_predict_bad_buy_price() {
        use Pattern::{Decreasing, Fluctuating, LargeSpike, SmallSpike};
        assert_eq!(
            _predict(0, FLUCTUATING, SmallSpike),
            Err(PredictorError::BadBuyPrice)
        );
        assert_eq!(
            _predict(120, LARGE_SPIKE, Decreasing),
            Err(PredictorError::BadBuyPrice)
        );
        assert_eq!(
            _predict(80, SMALL_SPIKE, LargeSpike),
            Err(PredictorError::BadBuyPrice)
        );
        assert_ne!(
            _predict(100, DECREASING, Fluctuating),
            Err(PredictorError::BadBuyPrice)
        );
    }

    #[test]
    fn test_predict_bad_price_list() {
        let bad_price: &'static str = "105,10,123,";
        assert_eq!(
            _predict(100, bad_price, Pattern::Unsure),
            Err(PredictorError::BadPriceList)
        );
    }

    #[test]
    fn test_impossible_values() {
        let impossible: &'static str = "90,150,,,,,,,,,,";
        assert_eq!(
            _predict(100, impossible, Pattern::Unsure),
            Err(PredictorError::ImpossibleValues)
        );
    }
}
