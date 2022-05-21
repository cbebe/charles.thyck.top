import Link from "@docusaurus/Link";
import { FeatureItem, Features } from "@site/src/components/basics/Features";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: (
      <Link to="https://thyck.top">
        <h3>Thyck Corgis</h3>
      </Link>
    ),
    svg: require("@site/static/img/thyck/logo.svg").default,
    description: (
      <div>
        <p>October 2020</p>
        Formed for University of Alberta Engineering Competition, we went on to participate in a couple more hackathons
        as a team. Check out our <Link to="https://github.com/thyckcorgis">GitHub</Link>!
      </div>
    ),
  },
  {
    title: "Focus on What Matters",
    svg: require("@site/static/img/undraw_docusaurus_tree.svg").default,
    description: (
      <>
        Docusaurus lets you focus on your docs, and we&apos;ll do the chores. Go ahead and move your docs into the{" "}
        <code>docs</code> directory.
      </>
    ),
  },
  {
    title: "Powered by React",
    svg: require("@site/static/img/undraw_docusaurus_react.svg").default,
    description: (
      <>
        Extend or customize your website layout by reusing React. Docusaurus can be extended while reusing the same
        header and footer.
      </>
    ),
  },
];

export const ProjectFeatures = () => <Features list={FeatureList} />;

export default ProjectFeatures;
