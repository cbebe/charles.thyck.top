type styles = {withSvg: string, buttonSvg: string, buttonSpaced: string}
@module("./styles.module.css")
external styles: styles = "default"

type svgComp = React.component<SVG.props>

@genType @react.component
let make = (~svg: option<'a>=?, ~label, ~to) => {
  <a className={CLSX.clsx("button button--secondary button--lg", styles.buttonSpaced)} href={to}>
    {switch svg {
    | Some(component) =>
      <span className={styles.withSvg}>
        {React.createElement(component, {SVG.role: #img, className: styles.buttonSvg})}
        {(" " ++ label)->React.string}
      </span>
    | None => label->React.string
    }}
  </a>
}
