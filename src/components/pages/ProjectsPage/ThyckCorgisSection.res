module ProjectFeatures = {
  @module("./ThyckCorgisSection/ProjectFeatures") @react.component
  external make: unit => React.element = "default"
}

type styles = {sectionHead: string}
@module("./ThyckCorgisSection/styles.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  <section id="thyck-corgis">
    <div className="text--center padding-horiz--md">
      <Docusaurus.Link to={URL.thyck["websiteUrl"]}>
        {React.createElement(SVG.thyck, {SVG.role: #img})}
      </Docusaurus.Link>
      <h1 className={CLSX.clsx("hero__title", styles.sectionHead)}>
        {"Thyck Corgis"->React.string}
      </h1>
      <p> {"Started October 2020"->React.string} </p>
      <p>
        {"Formed for University of Alberta Engineering Competition, we went on to participate in a couple more
          hackathons as a team. Check out our "->React.string}
        <Docusaurus.Link to={URL.thyck["githubUrl"]}> {"GitHub"->React.string} </Docusaurus.Link>
        {"!"->React.string}
      </p>
    </div>
    <ProjectFeatures />
  </section>
}
