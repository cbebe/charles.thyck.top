// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require("prism-react-renderer/themes/github");
const darkCodeTheme = require("prism-react-renderer/themes/dracula");

const MIT_LINK = '<a href="https://choosealicense.com/licenses/mit">MIT</a>';
const NEW_TAB_SVG = `
<svg width="13.5" height="13.5" aria-hidden="true" viewBox="0 0 24 24" class="">
  <path fill="currentColor" d="M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z">
  </path>
</svg>`;

/**
 * Create a new tab link that also uses the responsive Docusaurus stuff
 * @type {(href: string, label: string) => string}
 */
function addNewTabLink(href, label) {
  const CLASS_NAME = "custom_menu__link";
  return `\
<style>
  @media screen and (max-width: 996px) {
    .${CLASS_NAME} {
        color: var(--ifm-menu-color);
        flex: 1;
        line-height: 1.25;
        padding: var(--ifm-menu-link-padding-vertical)
          var(--ifm-menu-link-padding-horizontal);
    }
  }
</style>
<a target="_blank" rel="noopener noreferrer" class="navbar__link ${CLASS_NAME}" href="${href}">
  ${label}${NEW_TAB_SVG}
</a>`;
}

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Charles Ancheta",
  tagline: "A Computer Engineering Student at the University of Alberta",
  url: "https://charlesancheta.com",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "cbebe", // Usually your GitHub org/user name.
  projectName: "my-website", // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: "https://github.com/cbebe/my-website/edit/master/",
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: "https://github.com/cbebe/my-website/edit/master/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: "dark",
        respectPrefersColorScheme: false,
      },
      navbar: {
        title: "Charles Ancheta",
        logo: {
          alt: "My Site Logo",
          src: "img/logo.svg",
        },
        items: [
          { to: "/experience", label: "Experience", position: "left" },
          { to: "/projects", label: "Projects", position: "left" },
          {
            type: "html",
            value: addNewTabLink("/Resume.pdf", "Resume"),
            position: "left",
          },
          {
            href: "https://github.com/cbebe",
            label: "GitHub",
            position: "left",
          },
          {
            href: "https://www.linkedin.com/in/charles-ancheta",
            label: "Linkedin",
            position: "left",
          },
          {
            href: "mailto:cancheta@ualberta.ca",
            label: "Email",
            position: "left",
          },
        ],
      },
      footer: {
        style: "dark",
        links: [],
        copyright: `Copyright © ${new Date().getFullYear()} Charles Ancheta. Built with Docusaurus. ${MIT_LINK}`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
