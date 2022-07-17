@module("clsx")
external clsx: (string, string) => string = "default"

@module("clsx")
external clsxd: (string, Js.Dict.t<bool>) => string = "default"
