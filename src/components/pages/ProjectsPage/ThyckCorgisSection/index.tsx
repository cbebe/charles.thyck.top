import Link from "@docusaurus/Link";
import { THYCK } from "@site/config/url";
import { ThyckCorgiSvg } from "@site/src/svg";
import clsx from "clsx";
import React from "react";
import ProjectFeatures from "./ProjectFeatures";
import styles from "./styles.module.css";

export function ThyckCorgisSection() {
  return (
    <section id="thyck-corgis">
      <div className="text--center padding-horiz--md">
        <Link to={THYCK.WEBSITE_URL}>
          <ThyckCorgiSvg role="img" />
        </Link>
        <h1 className={clsx("hero__title", styles.sectionHead)}>Thyck Corgis</h1>
        <p>Started October 2020</p>
        <p>
          Formed for University of Alberta Engineering Competition, we went on to participate in a couple more
          hackathons as a team. Check out our <Link to={THYCK.GITHUB_URL}>GitHub</Link>!
        </p>
      </div>
      <ProjectFeatures />
    </section>
  );
}
