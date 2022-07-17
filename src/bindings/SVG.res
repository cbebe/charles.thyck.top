@genType
module DevpostSvg = {
  @genType @module("@site/static/img/devpost.svg") @react.component
  external make: (~role: string=?, ~className: string=?) => React.element = "ReactComponent"
}

@genType
module ThyckCorgiSvg = {
  @genType @module("@site/static/img/thyck/logo.svg") @react.component
  external make: (~role: string=?, ~className: string=?) => React.element = "ReactComponent"
}

type role = [#img]
type props = {role: role, className: string}
