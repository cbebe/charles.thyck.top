open Webapi.Dom

@module("predictor") external init: _ => Promise.t<unit> = "default"

@inline
let select = query => document->Document.querySelector(query)->Belt.Option.getUnsafe

let getResults = _ => {
  let (buyPrice, priceList, pattern) = Fields.get()
  switch buyPrice {
  | Some(price) =>
    switch Predictor.predict(price, priceList, pattern) {
    | Ok(res) => Writer.displayResults(res)
    | Error(err) => Writer.writeError(err)
    }
  | None => Writer.writeError("buy price not specified")
  }
}

window->Window.addEventListener("load", _ => {
  init()
  ->Promise.thenResolve(_ => {
    select("#predict")->Element.addEventListener("click", getResults)
    select("#clear")->Element.addEventListener("click", Fields.clear)
  })
  ->ignore
})
