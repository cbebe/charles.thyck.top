import Layout from "@theme/Layout";
import React from "react";
import { HeaderSection } from "../../basics/HeaderSection";
import WorkFeatures from "./WorkFeatures";

export function Work() {
  return (
    <Layout title="Work" description="Charles Ancheta's Professional Experience">
      <HeaderSection title="Work"></HeaderSection>
      <main>
        <WorkFeatures />
      </main>
    </Layout>
  );
}
