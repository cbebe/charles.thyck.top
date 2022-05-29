import Link from "@docusaurus/Link";
import { ISAIC_URL } from "@site/config/url";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: <h1>Industry Sandbox and AI Computing (ISAIC)</h1>,
    type: "img",
    img: require("@site/static/img/isaic-logo.png").default,
    alt: "ISAIC Logo",
    link: ISAIC_URL,
    description: (
      <div>
        <h2>January 2021 - Present</h2>
        <h2>Full Stack Web Development</h2>
        <h3>TypeScript, React, NestJS, Linux</h3>
        <Link to={ISAIC_URL}>
          <h3>Website Link</h3>
        </Link>
      </div>
    ),
  },
];

export const WorkFeatures = () => <Features list={FeatureList} />;

export default WorkFeatures;
