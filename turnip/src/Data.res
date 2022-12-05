open Dom
type t = {
  price: int,
  priceList: array<option<int>>,
  predictions: array<Predictor.Prediction.t>,
  categories: array<float>,
  pattern: int,
}

@inline
let islandKey = "island"

let save = data => {
  switch Js.Json.stringifyAny(data) {
  | Some(str) => {
      Storage2.localStorage->Storage2.setItem(islandKey, str)
      Ok()
    }

  | None => Error("failed to stringify data")
  }
}

let load = () => {
  switch Storage2.localStorage->Storage2.getItem(islandKey) {
  | Some(str) =>
    try {
      let results = Js.Json.parseExn(str)->Obj.magic
      let priceList = results.priceList->Js.Array2.map(e => Js.Nullable.toOption(e->Obj.magic))
      Ok({...results, priceList})
    } catch {
    | _ => Error("failed to parse json")
    }

  | None => Error("key not found")
  }
}
