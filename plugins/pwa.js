// @ts-check

module.exports = [
  "@docusaurus/plugin-pwa",
  /** @type {import('@docusaurus/plugin-pwa').PluginOptions} */
  {
    debug: true,
    offlineModeActivationStrategies: ["appInstalled", "standalone", "queryString"],
    pwaHead: [
      {
        tagName: "link",
        rel: "apple-touch-icon",
        sizes: "180x180",
        href: "/apple-touch-icon.png",
      },
      {
        tagName: "link",
        rel: "icon",
        sizes: "32x32",
        href: "/favicon-32x32.png",
      },
      {
        tagName: "link",
        rel: "icon",
        sizes: "16x16",
        href: "/favicon-16x16.png",
      },
      {
        tagName: "link",
        rel: "manifest",
        href: "/manifest.json",
      },
      {
        tagName: "meta",
        name: "theme-color",
        content: "#B388C5",
      },
    ],
  },
];
