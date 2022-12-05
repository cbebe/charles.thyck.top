module Prediction: {
  type t = {pattern: Pattern.t, probability: float, prices: array<int>}
}

type t = {predictions: array<Prediction.t>, time: float, fudge: int}

let predict: (int, array<option<int>>, int) => Belt.Result.t<(int, t), string>
