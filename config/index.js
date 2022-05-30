// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

async function createConfig() {
  const { WEBSITE_URL, WEBSITE_REPO_URL } = await import("./url.js");
  /** @type {import('@docusaurus/types').Config} */
  const config = {
    title: "Charles Ancheta",
    tagline: "A Computer Engineering Student at the University of Alberta",
    url: WEBSITE_URL,
    baseUrl: "/",
    trailingSlash: true,
    onBrokenLinks: "throw",
    onBrokenMarkdownLinks: "warn",
    favicon: "/favicon.ico",
    customFields: {
      // Cloning the repo would reset the last modified time so this would be more reliable
      lastResumeUpdate: await getGitLastModified("static/Resume.pdf"),
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
          //   editUrl: `${WEBSITE_REPO_URL}/edit/master/`,
          // },
          blog: {
            showReadingTime: true,
            editUrl: `${WEBSITE_REPO_URL}/edit/master/`,
          },
          theme: {
            customCss: require.resolve("../src/css/custom.css"),
          },
          sitemap: {
            changefreq: "daily",
          },
        }),
      ],
    ],
    themeConfig: (await import("./theme/index.js")).themeConfig,
    plugins: [(await import("./plugins/pwa.js")).default],
  };

  return config;
}

module.exports = createConfig;

/** @type {(file: string) => Promise<string>} */
function execAsync(cmd) {
  return new Promise((resolve, reject) => {
    import("child_process").then(({ exec }) => {
      exec(cmd, (err, stdout) => {
        if (err) return reject(err);
        resolve(stdout);
      });
    });
  });
}

/** @type {(file: string) => Promise<string>} */
function getGitLastModified(file) {
  return execAsync(`git log -1 --pretty="format:%cI" ${file}`);
}
