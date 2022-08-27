%%raw(`
import { GiteaSvg, GithubSvg, NPMSvg, DevpostSvg } from "@site/src/svg";
`)

@var external githubSvg: React.component<SVG.props> = "GithubSvg"
@var external giteaSvg: React.component<SVG.props> = "GiteaSvg"
@var external npmSvg: React.component<SVG.props> = "NPMSvg"
@var external devpostSvg: React.component<SVG.props> = "DevpostSvg"

type styles = {buttons: string}
@module("./projects.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
    <div className={CLSX.clsx("centre-content", styles.buttons)}>
      <ExtLink to={URL.profiles["github"]} svg={githubSvg} label="GitHub" />
      <ExtLink to={URL.profiles["devpost"]} svg={devpostSvg} label="Devpost" />
      <ExtLink to={URL.profiles["npm"]} svg={npmSvg} label="NPM" />
      <ExtLink to={URL.profiles["gitea"]} svg={giteaSvg} label="Gitea" />
    </div>
  </HeaderSection>
}
