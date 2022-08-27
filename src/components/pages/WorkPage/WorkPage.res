%%raw(`
import { EmailSvg, LinkedinSvg } from "@site/src/svg";
`)

@var external linkedinSvg: React.component<SVG.props> = "LinkedinSvg"
@var external emailSvg: React.component<SVG.props> = "EmailSvg"

module WorkFeatures = {
  @react.component @module("./WorkFeatures")
  external make: unit => React.element = "default"
}

@genType @react.component
let make = () => {
  <Docusaurus.Layout title="Work" description="Charles Ancheta's Professional Experience">
    <HeaderSection title="Work" subtitle="My Professional Experience">
      <ResumeButton />
      <ExtLink svg={linkedinSvg} label="Linkedin" to={URL.profiles["linkedin"]} />
      <ExtLink svg={emailSvg} label="Email" to={URL.work["email"]} />
    </HeaderSection>
    <main>
      <WorkFeatures />
    </main>
  </Docusaurus.Layout>
}
