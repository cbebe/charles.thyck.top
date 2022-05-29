import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import React from "react";
import { HeaderSection } from "../../basics/HeaderSection";

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  return <HeaderSection title="Hi, I'm Charles!" subtitle={siteConfig.tagline}></HeaderSection>;
}

export function Home(): JSX.Element {
  return (
    <Layout title="Hello!" description="Charles Ancheta's Personal Website">
      <HomepageHeader />
      {/* <main><HomepageFeatures /></main> */}
    </Layout>
  );
}
