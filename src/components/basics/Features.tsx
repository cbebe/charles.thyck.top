import Link from "@docusaurus/Link";
import clsx from "clsx";
import React, { ComponentProps, ComponentType, ReactChild } from "react";
import styles from "./styles.module.css";

export interface FeatureItem {
  title: ReactChild;
  svg: ComponentType<ComponentProps<"svg">>;
  description: JSX.Element;
  link?: string;
}

export const Feature = ({ title, svg: Svg, description, col, link }: FeatureItem & { col: number }) => (
  <div className={clsx("col", `col--${col}`)}>
    <div className="text--center">
      {link ? (
        <Link to={link}>
          <Svg className={styles.featureSvg} role="img" />
        </Link>
      ) : (
        <Svg className={styles.featureSvg} role="img" />
      )}
    </div>
    <div className="text--center padding-horiz--md">
      {typeof title === "string" ? <h3>{title}</h3> : title}
      {typeof description === "string" ? <p>{description}</p> : description}
    </div>
  </div>
);

export function Features({ list }: { list: FeatureItem[] }) {
  const remainder = list.length % 3;
  const rows = Math.ceil(list.length / 3);
  const calculateRow = remainder !== 0 ? (col: number) => (Math.floor(col / 3) === rows - 1 ? remainder : 3) : () => 3;
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {list.map((props, idx) => (
            <Feature key={idx} col={12 / calculateRow(idx)} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
