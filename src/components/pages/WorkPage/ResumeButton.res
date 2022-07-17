type styles = {resumeButton: string}
@module("./styles.module.css")
external styles: styles = "default"

@module("clsx")
external clsx: (string, string) => string = "default"

@react.component
let make = () => {
  open LastResumeUpdateHook
  let lastResumeUpdate = useLastResumeUpdate()
  <div className="centre-content">
    <a
      className={clsx("button button--secondary button--lg", styles.resumeButton)}
      href="/Resume.pdf">
      {switch lastResumeUpdate {
      | Some(d) => "Resume - Last Updated " ++ d
      | None => "Resume"
      }->React.string}
    </a>
  </div>
}
