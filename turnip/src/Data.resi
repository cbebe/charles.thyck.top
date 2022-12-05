type t = {
  price: int,
  priceList: array<option<int>>,
  predictions: array<Predictor.Prediction.t>,
  categories: array<float>,
  pattern: int,
}

let save: t => result<unit, string>

let load: unit => result<t, string>
