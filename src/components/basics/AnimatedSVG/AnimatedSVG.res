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
    ->Js.Array2.mapi((d, idx) => <path key={idx->Belt.Int.toString} d stroke strokeWidth />)
    ->React.array}
  </svg>
}
