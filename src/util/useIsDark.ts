import { useColorMode } from "@docusaurus/theme-common";

export function useIsDark() {
  const { colorMode } = useColorMode();
  return colorMode === "dark";
}
