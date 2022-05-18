import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React, { useMemo } from "react";
import styles from "./home.module.css";
import HomepageFeatures from "./HomepageFeatures";

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  const lastResumeUpdate = useMemo(() => {
    const lastUpdate = new Date(
      siteConfig.customFields.lastResumeUpdate as string
    );
    const [, month, date, year] = lastUpdate.toDateString().split(" ");
    return `${month} ${date} ${year}`;
  }, [siteConfig.customFields.lastResumeUpdate]);

  return (
    <header className={clsx("hero hero--primary", styles.heroBanner)}>
      <div className="container">
        <h1 className="hero__title">Hi, I'm Charles!</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <a className="button button--secondary button--lg" href="/Resume.pdf">
            Resume - Last Updated {lastResumeUpdate}
          </a>
        </div>
      </div>
    </header>
  );
}

export function Home(): JSX.Element {
  return (
    <Layout
      title={`Hello!`}
      description="Description will go into a meta tag in <head />"
    >
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
