// @ts-check

const { profiles } = require("../../src/bindings/URL.bs");
const { readFileSync } = require("fs");

const newTabSvg = readFileSync("static/img/new_tab.svg");

const navbar =
  /** @type {import('@docusaurus/preset-classic').ThemeConfig['navbar']} */
  ({
    title: "Charles Ancheta",
    logo: { alt: "My Site Logo", src: "img/thyck/logo.svg" },
    items: [
      { to: "/work", label: "Work", position: "left" },
      { to: "/projects", label: "Projects", position: "left" },
      { to: "/blog", label: "Blog", position: "left" },
      { type: "html", value: addNewTabLink("/Resume.pdf", "Resume"), position: "left" },
      { href: profiles.github, label: "GitHub", position: "left" },
    ],
  });

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
  ${label}
  ${newTabSvg}
</a>`;
}

module.exports = { navbar };
