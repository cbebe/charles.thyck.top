type package = {name: string, url: string, description: string}

let usePackages = () => {
  let {siteConfig: {customFields: {packages}}} = Docusaurus.useDocusaurusContext()
  React.useMemo1(() => {
    open Js.Array2
    packages->map(p => {
      {
        name: p.package.name,
        url: p.package.links.npm,
        description: p.package.description,
      }
    })
  }, [packages])
}

@genType @react.component
let make = () => {
  open React
  let packages = usePackages()
  <section id="packages">
    <div className="text--center">
      <h1 className="hero__title"> {"NPM Packages"->string} </h1>
      {packages
      ->Js.Array2.map(p =>
        <div key={p.name}>
          <h1>
            <a href={p.url}> {p.name->string} </a>
          </h1>
          <p> {p.description->string} </p>
        </div>
      )
      ->array}
    </div>
  </section>
}
