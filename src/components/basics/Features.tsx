import clsx from "clsx";
import React, { ComponentProps, ComponentType, ReactChild } from "react";
import styles from "./styles.module.css";

export interface FeatureItem {
  title: ReactChild;
  Svg: ComponentType<ComponentProps<"svg">>;
  description: JSX.Element;
}

export function Feature({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        {/* @ts-expect-error */}
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        {typeof title === "string" ? <h3>{title}</h3> : title}
        <p>{description}</p>
      </div>
    </div>
  );
}

export function Features({ list }: { list: FeatureItem[] }) {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {list.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
