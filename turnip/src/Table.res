open Webapi.Dom

@inline
let getPriceCell = (a, b) => {
  open Belt.Int
  if a == b {
    a->toString
  } else {
    `(${a->toString},${b->toString})`
  }
}

let getPriceRow = prices =>
  prices->Js.Array2.mapi(((a, b), _) => `<td>${getPriceCell(a, b)}</td>`)->Js.Array2.joinWith("\n")

@inline
let createHead = () => {
  let head = document->Document.createElement("thead")
  head->Element.setInnerHTML(`<tr><th>Pattern</th><th colspan="6">Prices</th></tr><tr><th>%</th><th>M</th><th>T</th><th>W</th><th>R</th><th>F</th><th>S</th></tr>`)
  head
}

@val external epsilon: float = "Number.EPSILON"

let formatPercent = n => {
  let pc = n *. 100.
  if pc < 0.01 {
    "<0.01"
  } else {
    (Js.Math.round((pc +. epsilon) *. 100.) /. 100.)->Belt.Float.toString
  }
}

@inline
let createRows = (p: Predictor.prediction) => {
  let percent = formatPercent(p.probability)
  let (ams, pms) = {
    let (a, b) = ([], [])
    for i in 0 to 5 {
      a->Js.Array2.push((p.prices[i * 4], p.prices[i * 4 + 1]))->ignore
      b->Js.Array2.push((p.prices[i * 4 + 2], p.prices[i * 4 + 3]))->ignore
    }
    (a, b)
  }

  let (amPrices, pmPrices) = (getPriceRow(ams), getPriceRow(pms))

  let amRow = document->Document.createElement("tr")
  amRow->Element.setInnerHTML(`<td>${p.pattern->Pattern.toShortString}</td>${amPrices}`)
  let pmRow = document->Document.createElement("tr")
  pmRow->Element.setInnerHTML(`<td>${percent}%</td>${pmPrices}`)

  (amRow, pmRow)
}

@inline
let id = "results-table"

let remove = () => {
  switch document->Document.getElementById(id) {
  | Some(e) =>
    switch e->Element.parentElement {
    | Some(p) => p->Element.removeChild(~child=e)->ignore
    | None => ()
    }
  | None => ()
  }
}

let make = (predictions: array<Predictor.prediction>) => {
  open Document
  let thead = createHead()
  let tbody = {
    let body = document->createElement("tbody")
    predictions->Js.Array2.forEach(p => {
      let (amTr, pmTr) = createRows(p)
      body->Element.appendChild(~child=amTr)
      body->Element.appendChild(~child=pmTr)
    })

    body
  }

  let div = document->createElement("div")
  div->Element.setId(id)

  let t = document->createElement("table")
  t->Element.appendChild(~child=thead)
  t->Element.appendChild(~child=tbody)

  div->Element.appendChild(~child=t)
  div
}
