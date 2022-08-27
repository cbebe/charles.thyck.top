@module("./styles.module.css")
external styles: {"sectionHead": string} = "default"

let list: array<Features.Feature.t> = [
  {
    title: Heading("Wapp"),
    link: Some(URL.thyck["wapp"]["devpostUrl"]),
    elem: Svg(SVG.h2h),
    description: Raw(
      <div>
        <p> {"February 2021"->React.string} </p>
        {"Are you thirsty?! Well urine luck! ComPEEte with friends to rank #1 in the litreboard using our award winning WApp! "->React.string}
        <Docusaurus.Link to={URL.thyck["wapp"]["ytUrl"]}>
          {"Demo Video"->React.string}
        </Docusaurus.Link>
      </div>,
    ),
  },
  {
    title: Heading("Heart 2 Heart Confessations"),
    link: Some(URL.thyck["h2h"]["devpostUrl"]),
    elem: Svg(SVG.wapp),
    description: Raw(
      <div>
        <p> {"January 2021"->React.string} </p>
        {"A mobile application that tackles the fear of initiating difficult conversations with friends, family, or significant others."->React.string}
      </div>,
    ),
  },
]

@genType @react.component
let make = () => {
  <section id="thyck-corgis">
    <div className="text--center padding-horiz--md">
      <Docusaurus.Link to={URL.thyck["websiteUrl"]}>
        {React.createElement(SVG.thyck, {SVG.role: #img})}
      </Docusaurus.Link>
      <h1 className={CLSX.clsx("hero__title", styles["sectionHead"])}>
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
    <Features list />
  </section>
}
