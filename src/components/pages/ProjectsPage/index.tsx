import Link from "@docusaurus/Link";
import { ExtLink } from "@site/src/components/basics/ExtLink";
import { HeaderSection } from "@site/src/components/basics/HeaderSection";
import { DevpostSvg, GiteaSvg, GithubSvg, ThyckCorgiSvg } from "@site/src/svg";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React from "react";
import ProjectFeatures from "./ProjectFeatures";
import styles from "./projects.module.css";

export function Projects(): JSX.Element {
  return (
    <Layout title="Projects" description="Charles Ancheta's Projects">
      <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
        <div className={clsx("centre-content", styles.buttons)}>
          <ExtLink to="https://github.com/cbebe" svg={GithubSvg} label="GitHub" />
          <ExtLink to="https://devpost.com/charlesancheta" svg={DevpostSvg} label="Devpost" />
          <ExtLink to="https://git.thyck.top" svg={GiteaSvg} label="Gitea" />
        </div>
      </HeaderSection>
      <main>
        <section id="thyck-corgis">
          <div className="text--center padding-horiz--md">
            <Link to="https://thyck.top">
              <ThyckCorgiSvg role="img" />
            </Link>
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
