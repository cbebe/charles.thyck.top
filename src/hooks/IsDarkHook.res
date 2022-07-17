type colorMode = {colorMode: [#dark | #light]}

@module("@docusaurus/theme-common")
external useColorMode: unit => colorMode = "useColorMode"

@genType
let useIsDark = () => {
  useColorMode().colorMode == #dark
}
