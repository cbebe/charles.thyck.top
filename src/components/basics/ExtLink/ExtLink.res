@module("./styles.module.css")
external styles: {"withSvg": string, "buttonSvg": string, "buttonSpaced": string} = "default"

@react.component
let make = (~svg: option<'a>=?, ~label, ~to) => {
  <a className={CLSX.clsx("button button--secondary button--lg", styles["buttonSpaced"])} href={to}>
    {switch svg {
    | Some(component) =>
      <span className={styles["withSvg"]}>
        {React.createElement(component, {SVG.role: #img, className: styles["buttonSvg"]})}
        {React.string(" " ++ label)}
      </span>
    | None => React.string(label)
    }}
  </a>
}
