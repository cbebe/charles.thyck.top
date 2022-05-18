import Link from "@docusaurus/Link";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React from "react";
import { HeaderSection } from "../../basics/HeaderSection";
import ProjectFeatures from "./ProjectFeatures";
import styles from "./projects.module.css";

const ExtLink = ({ label, to }: { label: string; to: string }) => (
  <Link className={clsx("button button--secondary button--lg", styles.buttonSpaced)} to={to}>
    {label}
  </Link>
);

export function Projects(): JSX.Element {
  return (
    <Layout title="Projects" description="Charles Ancheta's Projects">
      <HeaderSection title="My Projects" subtitle="Both personal and with ✨ friends ✨">
        <div className={clsx("centre-content", styles.buttons)}>
          <ExtLink to="https://github.com/cbebe" label="GitHub" />
          <ExtLink to="https://devpost.com/charlesancheta" label="Devpost" />
          <ExtLink to="https://git.thyck.top" label="Gitea" />
        </div>
      </HeaderSection>
      <main>
        <ProjectFeatures />
      </main>
    </Layout>
  );
}
