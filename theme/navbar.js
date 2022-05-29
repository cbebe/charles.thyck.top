// @ts-check

const navbar =
  /** @type {import('@docusaurus/preset-classic').ThemeConfig['navbar']} */
  ({
    title: "Charles Ancheta",
    logo: {
      alt: "My Site Logo",
      src: "img/thyck/logo.svg",
    },
    items: [
      { to: "/work", label: "Work", position: "left" },
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
  });

/**
 * Create a new tab link that also uses the responsive Docusaurus stuff
 * @type {(href: string, label: string) => string}
 */
function addNewTabLink(href, label) {
  const CLASS_NAME = "custom_menu__link";
  const NEW_TAB_SVG = `
<svg width="13.5" height="13.5" aria-hidden="true" viewBox="0 0 24 24" class="">
  <path fill="currentColor" d="M21 13v10h-21v-19h12v2h-10v15h17v-8h2zm3-12h-10.988l4.035 4-6.977 7.07 2.828 2.828 6.977-7.07 4.125 4.172v-11z">
  </path>
</svg>`;

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

module.exports = { navbar };
