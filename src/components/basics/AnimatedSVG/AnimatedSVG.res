type styles = {svg: string}
@module("./styles.module.css")
external styles: styles = "default"

@genType @react.component
let make = (~strokeWidth="5", ~stroke="white", ~viewBox, ~pathDs) => {
  <svg className={styles.svg} viewBox fill="none" xmlns="http://www.w3.org/2000/svg">
    {pathDs
    ->Js.Array2.mapi((d, idx) => <path key={idx->Belt.Int.toString} d stroke strokeWidth />)
    ->React.array}
  </svg>
}
