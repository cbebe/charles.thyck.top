import Link from "@docusaurus/Link";
import clsx from "clsx";
import React, { ComponentProps, ComponentType } from "react";
import styles from "./styles.module.css";

export interface ExtLinkProps {
  label?: JSX.Element | string;
  to: string;
  svg?: ComponentType<ComponentProps<"svg">>;
}

export const ExtLink = ({ label, to, svg: Svg }: ExtLinkProps) => (
  <Link className={clsx("button button--secondary button--lg", styles.buttonSpaced)} to={to}>
    {Svg ? (
      <span className={styles.withSvg}>
        <Svg role="img" className={styles.buttonSvg} /> {label}
      </span>
    ) : (
      label
    )}
  </Link>
);
