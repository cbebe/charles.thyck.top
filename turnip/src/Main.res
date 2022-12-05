open Webapi.Dom

@module("predictor") external init: _ => Promise.t<unit> = "default"

@inline
let select = query => document->Document.querySelector(query)->Belt.Option.getUnsafe

@inline
let then = (res: result<'a, 'b>, cb: 'a => result<'c, 'b>) => {
  switch res {
  | Ok(r) => cb(r)
  | Error(err) => Error(err)
  }
}

@inline
let catch = (res: result<'a, 'b>, cb: 'b => unit) => {
  switch res {
  | Ok(_) => ()
  | Error(err) => cb(err)
  }
}

@inline
let getResults = _ => {
  let (buyPrice, priceList, pattern) = Fields.get()
  buyPrice
  ->then(price => Predictor.predict(price, priceList, pattern))
  ->then(((price, res)) => {
    let res = Writer.parsePredictions(res)
    Writer.showResults(res)
    let (predictions, categories) = res
    Data.save({price, priceList, predictions, categories, pattern})
  })
  ->catch(err => Writer.writeError(err))
}

window->Window.addEventListener("load", _ => {
  Data.load()
  ->then(({price, priceList, predictions, categories, pattern}) => {
    Writer.showResults((predictions, categories))
    Fields.set(price, priceList, pattern)
    Ok()
  })
  ->catch(_ => ())
  init()
  ->Promise.thenResolve(_ => {
    select("#predict")->Element.addEventListener("click", getResults)
    select("#clear")->Element.addEventListener("click", Fields.clear)
  })
  ->ignore
})
