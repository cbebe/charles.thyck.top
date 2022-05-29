import Link from "@docusaurus/Link";
import clsx from "clsx";
import React, { ComponentProps, ComponentType, ReactChild } from "react";
import styles from "./styles.module.css";

export interface BaseFeatureItem {
  title: ReactChild;
  description: JSX.Element;
  link?: string;
}

export type FeatureItem = FeatureItemWithSvg | FeatureItemWithImg;

export type FeatureItemWithImg = BaseFeatureItem & {
  type: "img";
  img: string;
  alt?: string;
};

export type FeatureItemWithSvg = BaseFeatureItem & {
  type: "svg";
  svg: ComponentType<ComponentProps<"svg">>;
};

export const Feature = (props: FeatureItem & { col: number }) => {
  const { title, type, description, col, link } = props;
  const elem =
    type === "img" ? <img src={props.img} alt={props.alt} /> : <props.svg className={styles.featureSvg} role="img" />;
  return (
    <div className={clsx("col", `col--${col}`)}>
      <div className="text--center">{link ? <Link to={link}>{elem}</Link> : elem}</div>
      <div className="text--center padding-horiz--md">
        {typeof title === "string" ? <h3>{title}</h3> : title}
        {typeof description === "string" ? <p>{description}</p> : description}
      </div>
    </div>
  );
};

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
