open Monad
@module("predictor")
external predict: (. int, string, int) => array<float> = "predict"

type prediction = {pattern: Pattern.t, probability: float, prices: array<int>}
type t = {predictions: array<prediction>, time: float, fudge: int}

let sendPredictions = (res, len, time) => {
  open Belt.Array
  let fudge = Belt.Int.fromFloat(res[0])
  let (predictions, res) = ([], res->sliceToEnd(1))
  for i in 0 to (len - 1) / 26 - 1 {
    let (j, pattern) = (i * 26, Pattern.fromInt(res[i * 26]->Belt.Float.toInt))
    let prices = res->slice(~offset=j + 2, ~len=24)->map(Belt.Int.fromFloat)
    predictions->push({probability: res[j + 1], pattern, prices})->ignore
  }
  {predictions, time, fudge}
}

// used for the wasm errors that throw strings instead of actual Error objects
external castToString: Js.Exn.t => string = "%identity"

let predict = (buyPrice: int, sellPrices: array<option<int>>, patternInt: int) => {
  let start = Js.Date.now()
  let res: result<array<float>, string> = {
    try {
      Ok(predict(. buyPrice, sellPrices->Js.Array2.joinWith(","), patternInt))
    } catch {
    | Js.Exn.Error(obj) => Error(obj->castToString)
    }
  }
  let time = Js.Date.now() -. start

  res->then(arr => {
    switch arr->Js.Array2.length {
    | len if mod(len, 26) == 1 => Ok((buyPrice, sendPredictions(arr, len, time)))
    | len => Error(`bad buffer length: ${Belt.Int.toString(len)}`)
    }
  })
}
