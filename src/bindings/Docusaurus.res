type colorMode = {colorMode: [#dark | #light]}

@module("@docusaurus/theme-common")
external useColorMode: unit => colorMode = "useColorMode"

@module("@docusaurus/useIsBrowser")
external useIsBrowser: unit => bool = "default"

type customFields = {lastResumeUpdate: string, packages: array<Package.npmPackage>}
type siteConfig = {customFields: customFields}
type docusaurusContext = {siteConfig: siteConfig}
@module("@docusaurus/useDocusaurusContext")
external useDocusaurusContext: unit => docusaurusContext = "default"

module Layout = {
  @react.component @module("@theme/Layout")
  external make: (
    ~wrapperClassName: string=?,
    ~title: string,
    ~description: string,
    ~children: React.element,
  ) => React.element = "default"
}

module Link = {
  @module("@docusaurus/Link") @react.component
  external make: (~to: string, ~children: React.element) => React.element = "default"
}
