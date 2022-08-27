%%raw(`
import { PROFILES } from "@site/config/url";
import { GiteaSvg, GithubSvg, NPMSvg, DevpostSvg } from "@site/src/svg";
`)

@var external githubSvg: React.component<SVG.props> = "GithubSvg"
@var external giteaSvg: React.component<SVG.props> = "GiteaSvg"
@var external npmSvg: React.component<SVG.props> = "NPMSvg"
@var external devpostSvg: React.component<SVG.props> = "DevpostSvg"

@var
external profiles: {"GITHUB": string, "DEVPOST": string, "NPM": string, "GITEA": string} =
  "PROFILES"
@var external work: {"EMAIL": string} = "WORK"

type styles = {buttons: string}
@module("./projects.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
    <div className={CLSX.clsx("centre-content", styles.buttons)}>
      <ExtLink to={profiles["GITHUB"]} svg={githubSvg} label="GitHub" />
      <ExtLink to={profiles["DEVPOST"]} svg={devpostSvg} label="Devpost" />
      <ExtLink to={profiles["NPM"]} svg={npmSvg} label="NPM" />
      <ExtLink to={profiles["GITEA"]} svg={giteaSvg} label="Gitea" />
    </div>
  </HeaderSection>
}
