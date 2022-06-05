import Layout from "@theme/Layout";
import React from "react";
import { ProjectHeaderSection } from "./ProjectHeaderSection";
import { ThyckCorgisSection } from "./ThyckCorgisSection";

export function Projects(): JSX.Element {
  return (
    <Layout title="Projects" description="Charles Ancheta's Projects">
      <ProjectHeaderSection />
      <main>
        <ThyckCorgisSection />
      </main>
    </Layout>
  );
}
