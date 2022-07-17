import { PROFILES } from "@site/config/url";
import { ExtLink } from "@site/src/components/basics/ExtLink";
import { make as HeaderSection } from "@site/src/components/basics/HeaderSection/HeaderSection.gen";
import { DevpostSvg, GiteaSvg, GithubSvg, NPMSvg } from "@site/src/svg";
import clsx from "clsx";
import React from "react";
import styles from "./projects.module.css";

export function ProjectHeaderSection(): JSX.Element {
  return (
    <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
      <div className={clsx("centre-content", styles.buttons)}>
        <ExtLink to={PROFILES.GITHUB} svg={GithubSvg} label="GitHub" />
        <ExtLink to={PROFILES.DEVPOST} svg={DevpostSvg} label="Devpost" />
        <ExtLink to={PROFILES.NPM} svg={NPMSvg} label="NPM" />
        <ExtLink to={PROFILES.GITEA} svg={GiteaSvg} label="Gitea" />
      </div>
    </HeaderSection>
  );
}
