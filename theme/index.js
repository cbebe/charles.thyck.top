// @ts-check

const MIT_LINK = '<a href="https://choosealicense.com/licenses/mit">MIT</a>';

const themeConfig =
  /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
  ({
    colorMode: {
      defaultMode: "dark",
      respectPrefersColorScheme: false,
    },
    navbar: require("./navbar").navbar,
    footer: {
      style: "dark",
      links: [],
      copyright: `Copyright © ${new Date().getFullYear()} Charles Ancheta. Built with Docusaurus. ${MIT_LINK}`,
    },
    prism: {
      theme: require("prism-react-renderer/themes/github"),
      darkTheme: require("prism-react-renderer/themes/dracula"),
    },
  });

module.exports = { themeConfig };
