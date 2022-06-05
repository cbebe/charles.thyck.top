import { PROFILES, WORK } from "@site/config/url";
import { EmailSvg, LinkedinSvg } from "@site/src/svg";
import { useLastResumeUpdate } from "@site/src/util/useLastResumeUpdate";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React from "react";
import { ExtLink } from "../../basics/ExtLink";
import { HeaderSection } from "../../basics/HeaderSection";
import styles from "./styles.module.css";
import WorkFeatures from "./WorkFeatures";

function ResumeButton() {
  const lastResumeUpdate = useLastResumeUpdate();
  return (
    <div className="centre-content">
      <a className={clsx("button button--secondary button--lg", styles.resumeButton)} href="/Resume.pdf">
        Resume - Last Updated {lastResumeUpdate}
      </a>
    </div>
  );
}

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
