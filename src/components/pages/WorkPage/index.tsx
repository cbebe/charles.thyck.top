import { PROFILES, WORK } from "@site/config/url";
import { make as HeaderSection } from "@site/src/components/basics/HeaderSection/HeaderSection.gen";
import { EmailSvg, LinkedinSvg } from "@site/src/svg";
import Layout from "@theme/Layout";
import React from "react";
import { ExtLink } from "../../basics/ExtLink";
import { make as ResumeButton } from "./ResumeButton.gen";
import WorkFeatures from "./WorkFeatures";

export function Work() {
  return (
    <Layout title="Work" description="Charles Ancheta's Professional Experience">
      <HeaderSection title="Work" subtitle="My Professional Experience">
        <ResumeButton />
        <ExtLink svg={LinkedinSvg} label="Linkedin" to={PROFILES.LINKEDIN} />
        <ExtLink svg={EmailSvg} label="Email" to={WORK.EMAIL} />
      </HeaderSection>
      <main>
        <WorkFeatures />
      </main>
    </Layout>
  );
}
