import clsx from "clsx";
import React, { ReactNode } from "react";
import styles from "./styles.module.css";

export interface HeaderSectionProps {
  title: string;
  subtitle?: string;
  children?: ReactNode;
}

export function HeaderSection({ title, subtitle = "", children = "" }: HeaderSectionProps) {
  return (
    <header className={clsx("hero hero--primary", styles.heroBanner)}>
      <div className="container">
        <>
          <h1 className="hero__title">{title}</h1>
          <p className="hero__subtitle">{subtitle}</p>
          {children}
        </>
      </div>
    </header>
  );
}
