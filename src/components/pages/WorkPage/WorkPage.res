@module("@site/static/img/isaic-logo.png") external isaicLogo: string = "default"

@module("./styles.module.css")
external styles: {"resumeButton": string} = "default"

module ResumeButton = {
  let useLastResumeUpdate = () => {
    let {siteConfig} = Docusaurus.useDocusaurusContext()
    React.useMemo1(() => {
      let lastUpdate = Js.Date.fromString(siteConfig.customFields.lastResumeUpdate)
      switch lastUpdate->Js.Date.toDateString->Js.String2.split(" ") {
      | [_, month, date, year] => Some(`${month} ${date} ${year}`)
      | _ => None
      }
    }, [siteConfig.customFields.lastResumeUpdate])
  }

  @react.component
  let make = () => {
    let lastResumeUpdate = useLastResumeUpdate()
    <div className="centre-content">
      <a
        className={CLSX.clsx("button button--secondary button--lg", styles["resumeButton"])}
        href="/Resume.pdf">
        {switch lastResumeUpdate {
        | Some(d) => "Resume - Last Updated " ++ d
        | None => "Resume"
        }->React.string}
      </a>
    </div>
  }
}

let list: array<Features.Feature.t> = [
  {
    title: Raw(<h1> {React.string("Industry Sandbox and AI Computing (ISAIC)")} </h1>),
    elem: Img({
      img: isaicLogo,
      alt: "ISAIC Logo",
    }),
    link: Some(URL.work["isaicUrl"]),
    description: Raw(
      <div>
        <h2> {React.string("January 2021 - Present")} </h2>
        <h2> {React.string("Full Stack Web Development")} </h2>
        <h3> {React.string("TypeScript, React, NestJS, Linux")} </h3>
        <Docusaurus.Link to={URL.work["isaicUrl"]}>
          <h3> {React.string("Website Link")} </h3>
        </Docusaurus.Link>
      </div>,
    ),
  },
]

@react.component
let make = () => {
  <Docusaurus.Layout title="Work" description="Charles Ancheta's Professional Experience">
    <HeaderSection title="Work" subtitle="My Professional Experience">
      <ResumeButton />
      <ExtLink svg={SVG.linkedin} label="Linkedin" to={URL.profiles["linkedin"]} />
      <ExtLink svg={SVG.email} label="Email" to={URL.work["email"]} />
    </HeaderSection>
    <main>
      <Features list />
    </main>
  </Docusaurus.Layout>
}
