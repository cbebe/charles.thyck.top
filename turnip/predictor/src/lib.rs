mod pattern;
mod pdf;
mod possibilities;
mod price;
mod utils;

use js_sys::Float32Array;
use pattern::Pattern;
use possibilities::generate_possibilities;
use price::Prices;
use std::convert::TryInto;
use wasm_bindgen::prelude::wasm_bindgen;
use wasm_bindgen::JsValue;

// When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
// allocator.
#[cfg(feature = "wee_alloc")]
#[global_allocator]
static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;

#[derive(Debug, PartialEq)]
pub enum PredictorError {
    BadBuyPrice,
    BadPriceList,
    ImpossibleValues,
}

const BAD_BUY_PRICE: &'static str = "bad buy price";
const BAD_PRICE_LIST: &'static str = "bad price list";
const IMPOSSIBLE_VALUES: &'static str = "impossible values";

impl Into<JsValue> for PredictorError {
    fn into(self) -> JsValue {
        match self {
            Self::BadBuyPrice => JsValue::from_str(BAD_BUY_PRICE),
            Self::BadPriceList => JsValue::from_str(BAD_PRICE_LIST),
            Self::ImpossibleValues => JsValue::from_str(IMPOSSIBLE_VALUES),
        }
    }
}

fn conv<T, const N: usize>(v: Vec<T>) -> Option<[T; N]> {
    v.try_into().ok()
}

fn get_prices(prices: &str) -> Option<Prices> {
    conv(prices.split(",").map(|x| x.parse::<u16>().ok()).collect())
}

fn _predict(
    buy_price: u16,
    prices: &str,
    previous_pattern: Pattern,
) -> Result<Vec<f32>, PredictorError> {
    let possibilities = {
        if buy_price < 90 || buy_price > 110 {
            return Err(PredictorError::BadBuyPrice);
        }
        let prices = match get_prices(prices) {
            Some(arr) => arr,
            None => return Err(PredictorError::BadPriceList),
        };
        match generate_possibilities(buy_price, prices, previous_pattern) {
            Some(p) => p,
            None => return Err(PredictorError::ImpossibleValues),
        }
    };

    let total_probability = possibilities
        .iter()
        .fold(0., |acc, it| acc + it.probability);
    let floats: Vec<f32> = possibilities
        .into_iter()
        .map(|mut it| {
            it.probability = it.probability / total_probability;
            let mut floats: Vec<f32> = vec![it.pattern as i32 as f32, it.probability];
            let mut prices = it
                .prices
                .map(|x| vec![x.min() as f32, x.max() as f32])
                .concat();
            floats.append(&mut prices);
            floats
        })
        .flatten()
        .collect();

    Ok(floats)
}

#[wasm_bindgen]
pub fn predict(
    buy_price: u16,
    prices: &str,
    previous_pattern: i8,
) -> Result<Float32Array, PredictorError> {
    utils::set_panic_hook();
    let previous_pattern = Pattern::from_int(previous_pattern);
    match _predict(buy_price, prices, previous_pattern) {
        Ok(val) => Ok(Float32Array::from(&val[..])),
        Err(err) => Err(err),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const FLUCTUATING: &'static str = "105,99,115,58,51,117,121,124,109,71,65,60";
    const LARGE_SPIKE: &'static str = "91,87,83,79,74,71,100,192,415,158,143,69";
    const SMALL_SPIKE: &'static str = "93,134,173,63,55,47,121,169,166,60,50,42";
    const DECREASING: &'static str = "82,78,75,71,68,64,60,56,52,49,45,41";

    #[test]
    fn test_fluctuating() {
        let sure: &'static str = "120,120,120,120,120,120,,,,,,";
        assert_eq!(
            _predict(100, sure, Pattern::Decreasing),
            Ok(vec![
                0., 0.5, 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120.,
                60., 80., 50., 76., 90., 140., 60., 80., 50., 76., 40., 72., // Pattern 1
                0., 0.5, 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120., 120.,
                60., 80., 50., 76., 40., 72., 90., 140., 60., 80., 50., 76., // Pattern 2
            ])
        )
    }

    #[test]
    fn test_large_spike() {
        let sure: &'static str = "91,87,83,79,74,71,100,192,,,,";
        assert_eq!(
            _predict(100, sure, Pattern::Unsure),
            Ok(vec![
                1., 1., 91., 91., 87., 87., 83., 83., 79., 79., 74., 74., 71., 71., 100., 100.,
                192., 192., 200., 600., 140., 200., 90., 140., 40., 90.
            ])
        )
    }

    #[test]
    fn test_predict_bad_buy_price() {
        use Pattern::*;
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
        )
    }

    #[test]
    fn test_impossible_values() {
        let impossible: &'static str = "90,150,,,,,,,,,,";
        assert_eq!(
            _predict(100, impossible, Pattern::Unsure),
            Err(PredictorError::ImpossibleValues)
        )
    }
}
