module Prediction: {
  type t = {pattern: Pattern.t, probability: float, prices: array<int>}
}

type t = {predictions: array<Prediction.t>, time: float}

let predict: (int, array<option<int>>, int) => Belt.Result.t<t, string>
