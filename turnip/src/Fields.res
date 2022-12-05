open Webapi.Dom

let select = query => document->Document.querySelector(query)->Belt.Option.getUnsafe

let getInt = e => e->HtmlInputElement.value->Belt.Int.fromString

let getDays = (): array<HtmlInputElement.t> =>
  document->Document.querySelectorAll("[data-time]")->Obj.magic->Js.Array2.from

external toInput: Dom.element => HtmlInputElement.t = "%identity"

let set = (buyPrice, days, previousPattern) => {
  open Belt.Int
  select("#buy-price")->toInput->HtmlInputElement.setValue(buyPrice->toString)
  select("#previous-pattern")->toInput->HtmlInputElement.setValue(previousPattern->toString)
  getDays()->Js.Array2.forEachi((e, i) => {
    switch days[i] {
    | Some(value) => e->HtmlInputElement.setValue(value->toString)
    | None => e->HtmlInputElement.setValue("")
    }
  })
}

let get = _ => {
  let buyPrice = switch select("#buy-price")->toInput->getInt {
  | Some(price) => Ok(price)
  | None => Error("buy price not specified")
  }
  // This will always have a value since it's from the dropdown
  let previousPattern = select("#previous-pattern")->toInput->getInt->Belt.Option.getUnsafe
  let days = getDays()->Js.Array2.map(e => e->getInt)

  (buyPrice, days, previousPattern)
}

let clearMessage = "Are you sure you want to reset all fields?\n\nThis cannot be undone!"

let clear = _ => {
  if window->Window.confirm(clearMessage) {
    select("#buy-price")->toInput->HtmlInputElement.setValue("")
    select("#previous-pattern")->toInput->HtmlInputElement.setValue("-1")
    getDays()->Js.Array2.forEach(e => e->HtmlInputElement.setValue(""))
    select("#result")->Element.setTextContent("")
  }
}
