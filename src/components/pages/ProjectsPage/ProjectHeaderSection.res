@module("./styles.module.css")
external styles: {"buttons": string} = "default"

@genType @react.component
let make = () => {
  <HeaderSection title="My Personal Projects" subtitle="Both alone and with ✨friends✨">
    <div className={CLSX.clsx("centre-content", styles["buttons"])}>
      <ExtLink to={URL.profiles["github"]} svg={SVG.github} label="GitHub" />
      <ExtLink to={URL.profiles["devpost"]} svg={SVG.devpost} label="Devpost" />
      <ExtLink to={URL.profiles["npm"]} svg={SVG.npm} label="NPM" />
      <ExtLink to={URL.profiles["gitea"]} svg={SVG.gitea} label="Gitea" />
    </div>
  </HeaderSection>
}
