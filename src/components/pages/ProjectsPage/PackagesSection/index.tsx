import React from "react";

interface Package {
  name: "";
  url: "";
  description: "";
}

const packages = [];

export function PackagesSection() {
  return (
    <section id="packages">
      <div className="text--center">
        <h1 className="hero__title">NPM Packages</h1>
      </div>
    </section>
  );
}
