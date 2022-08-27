@module("@site/static/img/isaic-logo.png") external isaicLogo: string = "default"

let list: array<Features.Feature.t> = [
  {
    title: Raw(<h1> {"Industry Sandbox and AI Computing (ISAIC)"->React.string} </h1>),
    elem: Img({
      img: isaicLogo,
      alt: "ISAIC Logo",
    }),
    link: Some(URL.work["isaicUrl"]),
    description: Raw(
      <div>
        <h2> {"January 2021 - Present"->React.string} </h2>
        <h2> {"Full Stack Web Development"->React.string} </h2>
        <h3> {"TypeScript, React, NestJS, Linux"->React.string} </h3>
        <Docusaurus.Link to={URL.work["isaicUrl"]}>
          <h3> {"Website Link"->React.string} </h3>
        </Docusaurus.Link>
      </div>,
    ),
  },
]

@genType @react.component
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
