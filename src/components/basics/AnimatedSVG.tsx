import React from "react";
import styles from "./styles.module.css";

export interface AnimatedSVGProps {
  viewBox: `${number} ${number} ${number} ${number}`;
  pathDs: string[];
  strokeWidth?: `${number}`;
  stroke?: string;
}

export function AnimatedSVG(props: AnimatedSVGProps) {
  const { viewBox, pathDs, strokeWidth = "5", stroke = "white" } = props;

  return (
    <svg className={styles.svg} viewBox={viewBox} fill="none" xmlns="http://www.w3.org/2000/svg">
      {pathDs.map((v, idx) => (
        <path key={idx} d={v} stroke={stroke} strokeWidth={strokeWidth} />
      ))}
    </svg>
  );
}
