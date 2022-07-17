let elem = {
  <svg
    id="svg"
    width="201"
    height="100"
    viewBox="0 0 201 100"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
  />
}

@val external d: Webapi.Dom.Document.t = "document"

external unwrap: option<'a> => 'a = "%identity"
external unwrapList: Js.Array2.t<option<'a>> => Js.Array2.t<'a> = "%identity"

let flatten = (arr: Js.Array2.t<option<'a>>) => {
  arr->Js.Array2.filter(Js.Option.isSome)->unwrapList
}

type logObj = {viewBox: option<string>, pathDs: array<string>}

type displayStyle = {display: [#none]}
let useSvg = () => {
  React.useEffect(() => {
    open Webapi.Dom
    let paths = Document.querySelectorAll(d, "#svg path")
    let pathDs = {
      open Js.Array2
      paths
      ->NodeList.toArray
      ->map(x =>
        Js.Option.map(
          (. e) => {
            Element.getAttribute(e, "d")->unwrap
          },
          Element.ofNode(x),
        )
      )
      ->flatten
    }
    let svg = Document.querySelector(d, "#svg")
    switch (svg, pathDs) {
    | (Some(svg), pathDs) =>
      Js.log2(
        "Copy this object to use as an AnimatedSVG component",
        {
          viewBox: Element.getAttribute(svg, "viewBox"),
          pathDs,
        },
      )
    | _ => ()
    }
    None
  })
  <div style={ReactDOM.Style.make(~display="none", ())}> {elem} </div>
}
