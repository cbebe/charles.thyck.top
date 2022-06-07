import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import { NPMPackage } from "@site/config/package";
import React, { useMemo } from "react";

interface Package {
  name: string;
  url: string;
  description: string;
}

function usePackages(): Package[] {
  const {
    siteConfig: {
      customFields: { packages },
    },
  } = useDocusaurusContext();
  const data = useMemo<Package[]>(
    () =>
      (packages as NPMPackage[]).map((p) => ({
        name: p.package.name,
        url: p.package.links.npm,
        description: p.package.description,
      })),
    [packages]
  );
  return data;
}

export function PackagesSection() {
  const packages = usePackages();
  return (
    <section id="packages">
      <div className="text--center">
        <h1 className="hero__title">NPM Packages</h1>
        {packages.map((p) => (
          <div key={p.name}>
            <h1>
              <a href={p.url}>{p.name}</a>
            </h1>
            <p>{p.description}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
