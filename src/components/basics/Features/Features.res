@module("./styles.module.css")
external styles: {"features": string, "featureSvg": string} = "default"

module Feature = {
  type elem = Img({img: string, alt?: string}) | Svg(SVG.t)
  type title = Raw(React.element) | Heading(string)
  type description = Raw(React.element) | Paragraph(string)
  type t = {elem: elem, title: title, description: description, link: option<string>}

  @react.component
  let make = (
    ~title: title,
    ~elem,
    ~description: description,
    ~link: option<string>=?,
    ~col: int,
  ) => {
    let element = switch elem {
    | Img({img, alt}) => <img src={img} alt={alt} />
    | Svg(component) =>
      React.createElement(component, {SVG.role: #img, className: styles["featureSvg"]})
    }
    <div className={CLSX.clsx("col", "col--" ++ Belt.Int.toString(col))}>
      <div className="text--center">
        {switch link {
        | Some(link) => <Docusaurus.Link to={link}> {element} </Docusaurus.Link>
        | None => element
        }}
        <div className="text--center padding-horiz--md">
          {switch title {
          | Raw(jsx) => jsx
          | Heading(t) => <h3> {React.string(t)} </h3>
          }}
          {switch description {
          | Raw(jsx) => jsx
          | Paragraph(d) => <p> {React.string(d)} </p>
          }}
        </div>
      </div>
    </div>
  }
}

@react.component
let make = (~list: array<Feature.t>) => {
  let remainder = mod(list->Js.Array2.length, 3)
  let rows = Js.Math.ceil_int(list->Js.Array2.length->Belt.Int.toFloat /. 3.)
  let calculateRow = switch remainder {
  | 0 => _ => 3
  | _ => col => col / 3 === rows - 1 ? remainder : 3
  }
  <section className={styles["features"]}>
    <div className="container">
      <div className="row">
        {list
        ->Js.Array2.mapi(({description, title, elem, link}, idx) => {
          <Feature
            key={Belt.Int.toString(idx)} col={12 / calculateRow(idx)} description title elem ?link
          />
        })
        ->React.array}
      </div>
    </div>
  </section>
}
