type colorMode = {colorMode: [#dark | #light]}

@module("@docusaurus/theme-common")
external useColorMode: unit => colorMode = "useColorMode"

let useIsDark = () => {
  useColorMode().colorMode == #dark
}
