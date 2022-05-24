import Link from "@docusaurus/Link";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: (
      <Link to="/experience/isaic">
        <h3>Industry Sandbox and AI Computing (ISAIC)</h3>
      </Link>
    ),
    svg: require("@site/static/img/isaic.svg").default,
    description: (
      <div>
        <h2>January 2021 - Present</h2>
        <h3>TypeScript, React, NestJS, Linux</h3>
        <Link to="https://isaic.ca">
          <h4>Website Link</h4>
        </Link>
      </div>
    ),
  },
];

export const ExperienceFeatures = () => <Features list={FeatureList} />;

export default ExperienceFeatures;
