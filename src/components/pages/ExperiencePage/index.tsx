import Layout from "@theme/Layout";
import React from "react";
import { HeaderSection } from "../../basics/HeaderSection";
import ExperienceFeatures from "./ExperienceFeatures";

export function Experience() {
  return (
    <Layout title="Experience" description="Charles Ancheta's Professional Experience">
      <HeaderSection title="My Experience"></HeaderSection>
      <main>
        <ExperienceFeatures />
      </main>
    </Layout>
  );
}
