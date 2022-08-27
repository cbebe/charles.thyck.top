type package = {name: string, url: string, description: string}

let usePackages = () => {
  let {siteConfig: {customFields: {packages}}} = Docusaurus.useDocusaurusContext()
  React.useMemo1(() => {
    packages->Js.Array2.map(p => {
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
  let packages = usePackages()
  <section id="packages">
    <div className="text--center">
      <h1 className="hero__title"> {"NPM Packages"->React.string} </h1>
      {packages
      ->Js.Array2.map(p =>
        <div key={p.name}>
          <h1>
            <a href={p.url}> {p.name->React.string} </a>
          </h1>
          <p> {p.description->React.string} </p>
        </div>
      )
      ->React.array}
    </div>
  </section>
}
