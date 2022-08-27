%%raw(`
import { PROFILES, WORK } from "@site/config/url";
import { EmailSvg, LinkedinSvg } from "@site/src/svg";
`)

@var external linkedinSvg: React.component<SVG.props> = "LinkedinSvg"
@var external emailSvg: React.component<SVG.props> = "EmailSvg"

@var external profiles: {"LINKEDIN": string} = "PROFILES"
@var external work: {"EMAIL": string} = "WORK"

module WorkFeatures = {
  @react.component @module("./WorkFeatures")
  external make: unit => React.element = "default"
}

@genType @react.component
let make = () => {
  <Docusaurus.Layout title="Work" description="Charles Ancheta's Professional Experience">
    <HeaderSection title="Work" subtitle="My Professional Experience">
      <ResumeButton />
      <ExtLink svg={linkedinSvg} label="Linkedin" to={profiles["LINKEDIN"]} />
      <ExtLink svg={emailSvg} label="Email" to={work["EMAIL"]} />
    </HeaderSection>
    <main> <WorkFeatures /> </main>
  </Docusaurus.Layout>
}
