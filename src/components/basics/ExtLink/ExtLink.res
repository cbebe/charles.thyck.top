type styles = {withSvg: string, buttonSvg: string, buttonSpaced: string}
@module("./styles.module.css")
external styles: styles = "default"

type svgComp = React.component<SVG.props>

@genType @react.component
let make = (~svg: 'a=?, ~label, ~to) => {
  open React
  open SVG
  <a className={CLSX.clsx("button button--secondary button--lg", styles.buttonSpaced)} href={to}>
    {switch svg {
    | Some(component) =>
      <span className={styles.withSvg}>
        {createElement(component, {role: #img, className: styles.buttonSvg})}
        {(" " ++ label)->string}
      </span>

    | None => label->string
    }}
  </a>
}
