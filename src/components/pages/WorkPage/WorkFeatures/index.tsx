import Link from "@docusaurus/Link";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import { IsaicSvg } from "@site/src/svg";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: (
      // <Link to="/work/isaic">
      <h1>Industry Sandbox and AI Computing (ISAIC)</h1>
      // </Link>
    ),
    svg: IsaicSvg,
    description: (
      <div>
        <h2>January 2021 - Present</h2>
        <h2>Full Stack Web Development</h2>
        <h3>TypeScript, React, NestJS, Linux</h3>
        <Link to="https://isaic.ca">
          <h3>Website Link</h3>
        </Link>
      </div>
    ),
  },
];

export const WorkFeatures = () => <Features list={FeatureList} />;

export default WorkFeatures;
