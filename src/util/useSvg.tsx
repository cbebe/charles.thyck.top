import React, { useEffect } from "react";

// Paste SVG element here and add id="svg"
const elem = (
  <svg id="svg" width="201" height="100" viewBox="0 0 201 100" fill="none" xmlns="http://www.w3.org/2000/svg"></svg>
);

export function useSvg() {
  useEffect(() => {
    const paths: NodeListOf<SVGPathElement> = document.querySelectorAll("#svg path");
    const pathDs = Array.from(paths).map((v) => v.getAttribute("d"));
    const svg = document.querySelector("#svg");

    console.log("Copy this object to use as an AnimatedSVG component", {
      viewBox: svg.getAttribute("viewBox"),
      pathDs,
    });
  }, []);

  return <div style={{ display: "none" }}>{elem}</div>;
}
