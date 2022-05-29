// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/** @type {(file: string) => string} */
function getLastModified(file) {
  return require("fs").statSync(file).mtime.toISOString();
}

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Charles Ancheta",
  tagline: "A Computer Engineering Student at the University of Alberta",
  url: "https://charlesancheta.com",
  baseUrl: "/",
  trailingSlash: true,
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  customFields: {
    lastResumeUpdate: getLastModified("./static/Resume.pdf"),
  },
  organizationName: "cbebe",
  projectName: "my-website",
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },
  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        // Disable until we've found something worth putting
        docs: false,
        // docs: {
        //   sidebarPath: require.resolve("./sidebars.js"),
        //   editUrl: "https://github.com/cbebe/my-website/edit/master/",
        // },
        blog: {
          showReadingTime: true,
          editUrl: "https://github.com/cbebe/my-website/edit/master/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
        sitemap: {
          changefreq: "daily",
        },
      }),
    ],
  ],
  themeConfig: require("./theme").themeConfig,
  plugins: [require("./plugins/pwa")],
};

module.exports = config;
