/**
 * BlogPostItem.res
 * 
 * Based on jbl428's BlogPostItem Docusaurus swizzle
 * https://github.com/jbl428/jbl428.github.io/blob/main/src/theme/BlogPostItem.tsx
 * https://jbl428.github.io/2021/10/19/utterances/
 * Which he based on younho9's article: https://younho9.dev/docusaurus-manage-docs-2
 */
type el = Webapi.Dom.Element.t

module Script = {
  type t = {mutable src: string, mutable crossOrigin: [#anonymous], mutable async: bool}
  let load = (ref: React.ref<el>, theme: string) => {
    let script = Webapi.Dom.document->Webapi.Dom.Document.createElement("script")

    {
      let e: t = Obj.magic(script)
      e.src = "https://utteranc.es/client.js"
      e.crossOrigin = #anonymous
      e.async = true
    }

    {
      open Webapi.Dom.Element
      script->setAttribute("repo", `${URL.repo["orgName"]}/${URL.repo["projectName"]}`)
      script->setAttribute("issue-term", "pathname")
      script->setAttribute("label", "comment")
      script->setAttribute("theme", theme)
      ref.current->appendChild(~child=script)
    }

    ()
  }
}

module Message = {
  type contentWindow
  type t = {contentWindow: contentWindow}
  type message = {"type": string, "theme": string}
  @send external postMessage: (contentWindow, message, string) => unit = "postMessage"
  let send = (element: el, theme) => {
    Obj.magic(element).contentWindow->postMessage(
      {"type": "set-theme", "theme": theme},
      "https://utteranc.es",
    )
  }
}

module Utterances = {
  type t = el

  let useRef: unit => React.ref<t> = () => Obj.magic(React.useRef())

  @inline
  let utterancesSelector = "iframe.utterances-frame"

  let setup = (ref: React.ref<t>, utterancesTheme: string) => {
    switch Webapi.Dom.Element.querySelector(ref.current, utterancesSelector) {
    | Some(el) => Message.send(el, utterancesTheme)
    | None => Script.load(ref, utterancesTheme)
    }
    None
  }
}

module OriginalBlogPostItem = {
  @module("@theme-original/BlogPostItem")
  external make: 'a => React.element = "default"
}

let make = props => {
  let {isBlogPostPage} = Docusaurus.useBlogPost()
  let {colorMode} = Docusaurus.useColorMode()
  let ref = Utterances.useRef()
  let utterancesTheme = colorMode === #dark ? "github-dark" : "github-light"

  React.useEffect3(
    () => isBlogPostPage ? Utterances.setup(ref, utterancesTheme) : None,
    (ref, isBlogPostPage, utterancesTheme),
  )
  <>
    {React.createElement(OriginalBlogPostItem.make, props)}
    {isBlogPostPage ? <div ref={Obj.magic(ref)} /> : React.null}
  </>
}
