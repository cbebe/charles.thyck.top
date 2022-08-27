type styles = {resumeButton: string}
@module("./styles.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  let lastResumeUpdate = LastResumeUpdateHook.useLastResumeUpdate()
  <div className="centre-content">
    <a
      className={CLSX.clsx("button button--secondary button--lg", styles.resumeButton)}
      href="/Resume.pdf">
      {switch lastResumeUpdate {
      | Some(d) => "Resume - Last Updated " ++ d
      | None => "Resume"
      }->React.string}
    </a>
  </div>
}
