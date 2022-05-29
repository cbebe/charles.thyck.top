import Link from "@docusaurus/Link";
import clsx from "clsx";
import React, { ComponentType, SVGProps } from "react";
import styles from "./styles.module.css";

export interface ExtLinkProps {
  label: string;
  to: string;
  svg?: ComponentType<SVGProps<SVGSVGElement>>;
}

export const ExtLink = ({ label, to, svg: Svg }: ExtLinkProps) => (
  <Link className={clsx("button button--secondary button--lg", styles.buttonSpaced)} to={to}>
    {Svg ? (
      <span className={styles.withSvg}>
        {/* @ts-expect-error */}
        <Svg role="img" className={styles.buttonSvg} /> {label}
      </span>
    ) : (
      label
    )}
  </Link>
);
