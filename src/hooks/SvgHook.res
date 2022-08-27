let elem =
  <svg
    id="svg"
    width="201"
    height="100"
    viewBox="0 0 201 100"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
  />

external unwrap: option<'a> => 'a = "%identity"
external unwrapList: Js.Array2.t<option<'a>> => Js.Array2.t<'a> = "%identity"

let flatten = (arr: Js.Array2.t<option<'a>>) => arr->Js.Array2.filter(Js.Option.isSome)->unwrapList

@genType
let useSvg = () => {
  React.useEffect(() => {
    open Webapi.Dom
    let paths =
      document
      ->Document.querySelectorAll("#svg path")
      ->NodeList.toArray
      ->Js.Array2.map(x =>
        Js.Option.map((. e) => e->Element.getAttribute("d")->unwrap, Element.ofNode(x))
      )
      ->flatten

    switch (document->Document.querySelector("#svg"), paths) {
    | (Some(svg), paths) =>
      Js.log2(
        "Copy this object to use as an AnimatedSVG component",
        {"viewBox": svg->Element.getAttribute("viewBox"), "paths": paths},
      )
    | _ => ()
    }
    None
  })
  <div style={ReactDOM.Style.make(~display="none", ())}> {elem} </div>
}
