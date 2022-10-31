type el = Webapi.Dom.Element.t
external toElement: React.ref<unit> => React.ref<el> = "%identity"

@inline
let utterancesSelector = "iframe.utterances-frame"

module Script = {
  type t = {mutable src: string, mutable crossOrigin: [#anonymous], mutable async: bool}
  external conv: el => t = "%identity"
  let make = (ref: React.ref<el>, theme: string) => {
    open Webapi.Dom
    open Element
    let script = document->Document.createElement("script")

    {
      let e = conv(script)
      e.src = "https://utteranc.es/client.js"
      e.crossOrigin = #anonymous
      e.async = true
    }

    script->setAttribute("repo", `${URL.repo["orgName"]}/${URL.repo["projectName"]}`)
    script->setAttribute("issue-term", "pathname")
    script->setAttribute("label", "comment")
    script->setAttribute("theme", theme)

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
    conv(element).contentWindow->postMessage(message, "https://utteranc.es")
  }
}

let setup = (containerRef: React.ref<unit>, utterancesTheme: string) => {
  open Webapi.Dom
  let ref = containerRef->toElement
  let utterancesEl = Element.querySelector(ref.current, utterancesSelector)

  switch utterancesEl {
  | Some(el) => Message.make(el, utterancesTheme)
  | None => Script.make(ref, utterancesTheme)
  }
  None
}
