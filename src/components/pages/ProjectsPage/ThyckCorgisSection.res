module ProjectFeatures = {
  @module("./ThyckCorgisSection/ProjectFeatures") @react.component
  external make: unit => React.element = "default"
}

type styles = {sectionHead: string}
@module("./ThyckCorgisSection/styles.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  open Docusaurus
  <section id="thyck-corgis">
    <div className="text--center padding-horiz--md">
      <Link to={URL.thyck["websiteUrl"]}>
        <SVG.ThyckCorgiSvg role="img" />
      </Link>
      <h1 className={CLSX.clsx("hero__title", styles.sectionHead)}>
        {"Thyck Corgis"->React.string}
      </h1>
      <p> {"Started October 2020"->React.string} </p>
      <p>
        {"Formed for University of Alberta Engineering Competition, we went on to participate in a couple more
          hackathons as a team. Check out our "->React.string}
        <Link to={URL.thyck["githubUrl"]}> {"GitHub"->React.string} </Link>
        {"!"->React.string}
      </p>
    </div>
    <ProjectFeatures />
  </section>
}
