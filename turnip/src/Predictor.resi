type prediction = {pattern: Pattern.t, probability: float, prices: array<int>}

type t = {predictions: array<prediction>, time: float, fudge: int}

let predict: (int, array<option<int>>, int) => Belt.Result.t<(int, t), string>
