import Link from "@docusaurus/Link";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import { H2HSvg, WappSvg } from "@site/src/svg";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: "WApp",
    link: "https://devpost.com/software/wapp",
    type: "svg",
    svg: WappSvg,
    description: (
      <div>
        <p>February 2021</p>
        Are you thirsty?! Well urine luck! ComPEEte with friends to rank #1 in the litreboard using our award winning
        WApp! <Link to="https://youtu.be/BXuvQGEnreE">Demo Video</Link>
      </div>
    ),
  },
  {
    title: "Heart 2 Heart Confessations",
    link: "https://devpost.com/software/heart-2-heart",
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
