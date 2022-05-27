import Link from "@docusaurus/Link";
import ThyckCorgiSvg from "@site/static/img/thyck/logo.svg";
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
      <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
        <div className={clsx("centre-content", styles.buttons)}>
          <ExtLink to="https://github.com/cbebe" label="GitHub" />
          <ExtLink to="https://devpost.com/charlesancheta" label="Devpost" />
          <ExtLink to="https://git.thyck.top" label="Gitea" />
        </div>
      </HeaderSection>
      <main>
        <section id="thyck-corgis">
          <div className="text--center padding-horiz--md">
            <ThyckCorgiSvg role="img" />
            <h1 className={clsx("hero__title", styles.sectionHead)}>Thyck Corgis</h1>
            <p>Started October 2020</p>
            <p>
              Formed for University of Alberta Engineering Competition, we went on to participate in a couple more
              hackathons as a team. Check out our <Link to="https://github.com/thyckcorgis">GitHub</Link>!
            </p>
          </div>
          <ProjectFeatures />
        </section>
      </main>
    </Layout>
  );
}
