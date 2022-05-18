// @ts-check

const { navbar } = require("./navbar");
const lightCodeTheme = require("prism-react-renderer/themes/github");
const darkCodeTheme = require("prism-react-renderer/themes/dracula");

const MIT_LINK = '<a href="https://choosealicense.com/licenses/mit">MIT</a>';

const themeConfig =
  /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
  {
    colorMode: {
      defaultMode: "dark",
      respectPrefersColorScheme: false,
    },
    navbar,
    footer: {
      style: "dark",
      links: [],
      copyright: `Copyright © ${new Date().getFullYear()} Charles Ancheta. Built with Docusaurus. ${MIT_LINK}`,
    },
    prism: {
      theme: lightCodeTheme,
      darkTheme: darkCodeTheme,
    },
  };

module.exports = { themeConfig };
