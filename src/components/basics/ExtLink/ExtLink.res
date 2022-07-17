type styles = {
  withSvg: string,
  buttonSvg: string,
  buttonSpaced: string,
}
@module("./styles.module.css")
external styles: styles = "default"

// export interface ExtLinkProps {
//   label?: JSX.Element | string;
//   to: string;
//   svg?: ComponentType<ComponentProps<"svg">>;
// }

// export const ExtLink = ({ label, to, svg: Svg }: ExtLinkProps) => (
//   <a className={clsx("button button--secondary button--lg", styles.buttonSpaced)} href={to}>
//     {Svg ? (
//       <span className={styles.withSvg}>
//         <Svg role="img" className={styles.buttonSvg} /> {label}
//       </span>
//     ) : (
//       label
//     )}
//   </a>
// );

@genType
let make = (~label, ~to, ~svg: option<React.component<string>>=?) => {
  <a className={CLSX.clsx("button button--secondary button--lg", styles.buttonSpaced)} href={to}>
    {switch svg {
    | Some(component) =>
      <span className={styles.withSvg}>
        <component role="img" className={styles.buttonSvg} />
        {label->React.string}
      </span>

    | None => label->React.string
    }}
  </a>
}
