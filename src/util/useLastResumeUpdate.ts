import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import { useMemo } from "react";

export function useLastResumeUpdate() {
  const { siteConfig } = useDocusaurusContext();
  return useMemo(() => {
    const lastUpdate = new Date(siteConfig.customFields.lastResumeUpdate as string);
    const [, month, date, year] = lastUpdate.toDateString().split(" ");
    return `${month} ${date} ${year}`;
  }, [siteConfig.customFields.lastResumeUpdate]);
}
