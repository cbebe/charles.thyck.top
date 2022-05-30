import Layout from "@theme/Layout";
import React from "react";
import { Name } from "./Name";
import styles from "./styles.module.css";

export function Home(): JSX.Element {
  return (
    <Layout wrapperClassName={styles.wrapper} title="Hello!" description="Charles Ancheta's Personal Website">
      <main className="centre-content">
        <Name />
      </main>
    </Layout>
  );
}
