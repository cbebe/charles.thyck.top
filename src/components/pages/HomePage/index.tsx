import Layout from "@theme/Layout";
import clsx from "clsx";
import React from "react";
import { Name } from "./Name";
import styles from "./styles.module.css";

export function Home(): JSX.Element {
  return (
    <Layout wrapperClassName={styles.wrapper} title="Hello!" description="Charles Ancheta's Personal Website">
      <main className={clsx("centre-content", styles.main)}>
        <Name />
        <h1 className={clsx("hero__subtitle", styles.softie)}>Software Engineer</h1>
      </main>
    </Layout>
  );
}
