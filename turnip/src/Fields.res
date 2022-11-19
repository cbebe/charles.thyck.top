open Webapi.Dom

let select = query => document->Document.querySelector(query)->Belt.Option.getUnsafe

let getInt = e => e->HtmlInputElement.value->Belt.Int.fromString

let getDays = (): array<HtmlInputElement.t> =>
  document->Document.querySelectorAll("[data-time]")->Obj.magic->Js.Array2.from

external toInput: Dom.element => HtmlInputElement.t = "%identity"

let get = _ => {
  let buyPrice = select("#buy-price")->toInput->getInt
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
