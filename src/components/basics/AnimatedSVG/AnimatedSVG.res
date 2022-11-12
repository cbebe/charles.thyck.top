@module("./styles.module.css")
external styles: {"svg": string} = "default"

@react.component
let make = (~svgTitle: option<string>=?, ~strokeWidth="5", ~stroke="white", ~viewBox, ~pathDs) => {
  <svg className={styles["svg"]} viewBox fill="none" xmlns="http://www.w3.org/2000/svg">
    {switch svgTitle {
    | Some(t) => <title> {React.string(t)} </title>
    | None => React.null
    }}
    {pathDs
    ->Js.Array2.mapi((d, idx) => <path key={Belt.Int.toString(idx)} d stroke strokeWidth />)
    ->React.array}
  </svg>
}

let elem =
  <svg
    id="svg"
    width="201"
    height="100"
    viewBox="0 0 201 100"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
  />

let useSvg = () => {
  React.useEffect(() => {
    open Webapi.Dom
    let paths: Js.Array2.t<string> = {
      open Js.Array2
      open Element
      document
      ->Document.querySelectorAll("#svg path")
      ->NodeList.toArray
      ->map(x => Js.Option.map((. e) => Obj.magic(e->getAttribute("d")), ofNode(x)))
      ->filter(Js.Option.isSome)
      ->Obj.magic
    }

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
