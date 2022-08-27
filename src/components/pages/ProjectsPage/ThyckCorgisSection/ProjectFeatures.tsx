import Link from "@docusaurus/Link";
import { thyck } from "@site/src/bindings/URL.bs";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import { H2HSvg, WappSvg } from "@site/src/svg";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: "WApp",
    link: thyck.wapp.devpostUrl,
    type: "svg",
    svg: WappSvg,
    description: (
      <div>
        <p>February 2021</p>
        Are you thirsty?! Well urine luck! ComPEEte with friends to rank #1 in the litreboard using our award winning
        WApp! <Link to={thyck.wapp.ytUrl}>Demo Video</Link>
      </div>
    ),
  },
  {
    title: "Heart 2 Heart Confessations",
    link: thyck.h2h.devpostUrl,
    type: "svg",
    svg: H2HSvg,
    description: (
      <div>
        <p>January 2021</p>A mobile application that tackles the fear of initiating difficult conversations with
        friends, family, or significant others.
      </div>
    ),
  },
];

export const ProjectFeatures = () => <Features list={FeatureList} />;

export default ProjectFeatures;
