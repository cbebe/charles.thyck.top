type el = Webapi.Dom.Element.t
external toElement: React.ref<unit> => React.ref<el> = "%identity"

@inline
let utterancesSelector = "iframe.utterances-frame"

module Script = {
  type t = {mutable src: string, mutable crossOrigin: [#anonymous], mutable async: bool}
  external conv: el => t = "%identity"
  @val external d: Webapi.Dom.Document.t = "document"
  let make = (ref: React.ref<el>, theme: string) => {
    open Webapi.Dom
    open Element
    let script = d->Document.createElement("script")
    let e = script->conv
    e.src = "https://utteranc.es/client.js"
    script->setAttribute("repo", "cbebe/charlesancheta.com")
    script->setAttribute("issue-term", "pathname")
    script->setAttribute("label", "comment")
    script->setAttribute("theme", theme)
    e.crossOrigin = #anonymous
    e.async = true
    ref.current->appendChild(~child=script)
    ()
  }
}

module Message = {
  type contentWindow
  type t = {contentWindow: contentWindow}
  type message = {"type": string, "theme": string}
  @send external postMessage: (contentWindow, message, string) => unit = "postMessage"
  external conv: el => t = "%identity"
  let make = (element: el, theme: string) => {
    let message = {"type": "set-theme", "theme": theme}
    let e = element->conv
    e.contentWindow->postMessage(message, "https://utteranc.es")
  }
}

let setup = (containerRef: React.ref<unit>, utterancesTheme: string) => {
  open Webapi.Dom
  let ref = containerRef->toElement
  let utterancesEl = Element.querySelector(ref.current, utterancesSelector)

  switch utterancesEl {
  | Some(el) => el->Message.make(utterancesTheme)
  | None => Script.make(ref, utterancesTheme)
  }
  None
}
