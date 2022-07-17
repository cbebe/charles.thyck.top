import { PROFILES, WORK } from "@site/config/url";
import { EmailSvg, LinkedinSvg } from "@site/src/svg";
import Layout from "@theme/Layout";
import React from "react";
import { ExtLink } from "../../basics/ExtLink";
import { HeaderSection } from "../../basics/HeaderSection";
import { make as ResumeButton } from "./ResumeButton.bs";
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
