import { FeatureItem, Features } from "@site/src/components/basics/Features";
import React from "react";

const FeatureList: FeatureItem[] = [
  {
    title: "Easy to Use",
    svg: require("@site/static/img/undraw_docusaurus_mountain.svg").default,
    description: (
      <>
        Docusaurus was designed from the ground up to be easily installed and used to get your website up and running
        quickly.
      </>
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

export const HomepageFeatures = () => <Features list={FeatureList} />;

export default HomepageFeatures;
