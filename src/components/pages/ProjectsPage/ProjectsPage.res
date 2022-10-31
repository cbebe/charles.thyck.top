@module("./styles.module.css")
external styles: {"buttons": string, "sectionHead": string} = "default"

module ThyckCorgisSection = {
  let list: array<Features.Feature.t> = [
    {
      title: Heading("Wapp"),
      link: Some(URL.thyck["wapp"]["devpostUrl"]),
      elem: Svg(SVG.h2h),
      description: Raw(
        <div>
          <p> {React.string("February 2021")} </p>
          {"Are you thirsty?! Well urine luck! ComPEEte with friends to rank #1 in the litreboard using our award winning WApp! "->React.string}
          <Docusaurus.Link to={URL.thyck["wapp"]["ytUrl"]}>
            {React.string("Demo Video")}
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
          <p> {React.string("January 2021")} </p>
          {"A mobile application that tackles the fear of initiating difficult conversations with friends, family, or significant others."->React.string}
        </div>,
      ),
    },
  ]

  @react.component
  let make = () => {
    <section id="thyck-corgis">
      <div className="text--center padding-horiz--md">
        <Docusaurus.Link to={URL.thyck["websiteUrl"]}>
          {React.createElement(SVG.thyck, {SVG.role: #img})}
        </Docusaurus.Link>
        <h1 className={CLSX.clsx("hero__title", styles["sectionHead"])}>
          {React.string("Thyck Corgis")}
        </h1>
        <p> {React.string("Started October 2020")} </p>
        <p>
          {"Formed for University of Alberta Engineering Competition, we went on to participate in a couple more
          hackathons as a team. Check out our "->React.string}
          <Docusaurus.Link to={URL.thyck["githubUrl"]}> {React.string("GitHub")} </Docusaurus.Link>
          {React.string("!")}
        </p>
      </div>
      <Features list />
    </section>
  }
}

module PackagesSection = {
  type package = {name: string, url: string, description: string}

  let usePackages = () => {
    let {siteConfig: {customFields: {packages}}} = Docusaurus.useDocusaurusContext()
    React.useMemo1(() => {
      packages->Js.Array2.map(p => {
        {name: p.package.name, url: p.package.links.npm, description: p.package.description}
      })
    }, [packages])
  }

  @react.component
  let make = () => {
    let packages = usePackages()
    <section id="packages">
      <div className="text--center">
        <h1 className="hero__title"> {React.string("NPM Packages")} </h1>
        {packages
        ->Js.Array2.map(p =>
          <div key={p.name}>
            <h1>
              <a href={p.url}> {React.string(p.name)} </a>
            </h1>
            <p> {React.string(p.description)} </p>
          </div>
        )
        ->React.array}
      </div>
    </section>
  }
}

module ProjectHeaderSection = {
  @react.component
  let make = () => {
    <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
      <div className={CLSX.clsx("centre-content", styles["buttons"])}>
        <ExtLink to={URL.profiles["github"]} svg={SVG.github} label="GitHub" />
        <ExtLink to={URL.profiles["devpost"]} svg={SVG.devpost} label="Devpost" />
        <ExtLink to={URL.profiles["npm"]} svg={SVG.npm} label="NPM" />
        <ExtLink to={URL.profiles["gitea"]} svg={SVG.gitea} label="Gitea" />
      </div>
    </HeaderSection>
  }
}

@react.component
let make = () => {
  <Docusaurus.Layout title="Projects" description="Charles Ancheta's Projects">
    <ProjectHeaderSection />
    <main>
      <ThyckCorgisSection />
      <PackagesSection />
    </main>
  </Docusaurus.Layout>
}
