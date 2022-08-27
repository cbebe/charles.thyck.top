/**
 * BlogPostItem.res
 * 
 * Based on jbl428's BlogPostItem Docusaurus swizzle
 * https://github.com/jbl428/jbl428.github.io/blob/main/src/theme/BlogPostItem.tsx
 * https://jbl428.github.io/2021/10/19/utterances/
 * Which he based on younho9's article: https://younho9.dev/docusaurus-manage-docs-2
 */
module OriginalBlogPostItem = {
  @module("@theme-original/BlogPostItem") @react.component
  external make: (~isBlogPostPage: bool) => React.element = "default"
}

type props = {"isBlogPostPage": bool}
external toDomRef: React.ref<unit> => ReactDOM.domRef = "%identity"

@genType
let make = (props: props) => {
  let {colorMode} = Docusaurus.useColorMode()
  let utterancesTheme = colorMode === #dark ? "github-dark" : "github-light"
  let containerRef = React.useRef()

  React.useEffect1(() => {
    switch props["isBlogPostPage"] {
    | false => None
    | true => {
        Utterances.setup(containerRef, utterancesTheme)
        None
      }
    }
  }, [utterancesTheme])
  <>
    {React.createElement(OriginalBlogPostItem.make, props)}
    {switch props["isBlogPostPage"] {
    | true => <div ref={containerRef->toDomRef} />
    | false => React.null
    }}
  </>
}
