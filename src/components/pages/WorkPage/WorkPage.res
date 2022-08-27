module WorkFeatures = {
  @react.component @module("./WorkFeatures")
  external make: unit => React.element = "default"
}

@genType @react.component
let make = () => {
  <Docusaurus.Layout title="Work" description="Charles Ancheta's Professional Experience">
    <HeaderSection title="Work" subtitle="My Professional Experience">
      <ResumeButton />
      <ExtLink svg={SVG.linkedin} label="Linkedin" to={URL.profiles["linkedin"]} />
      <ExtLink svg={SVG.email} label="Email" to={URL.work["email"]} />
    </HeaderSection>
    <main>
      <WorkFeatures />
    </main>
  </Docusaurus.Layout>
}
