type colorMode = {colorMode: [#dark | #light]}
type blogPost = {isBlogPostPage: bool}

@module("@docusaurus/theme-common")
external useColorMode: unit => colorMode = "useColorMode"

@module("@docusaurus/useIsBrowser")
external useIsBrowser: unit => bool = "default"

type customFields = {lastResumeUpdate: string, packages: array<Package.t>}
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

/**
 * !! INTERNAL CODE !!
 * Works as of Docusaurus v2.0.1
 * 
 * Watch out for this:
 * https://github.com/facebook/docusaurus/blob/main/packages/docusaurus-theme-classic/src/theme/BlogPostItem/index.tsx
 */
@module("@docusaurus/theme-common/internal")
external useBlogPost: unit => blogPost = "useBlogPost"
