@module("./styles.module.css")
external styles: {"resumeButton": string} = "default"

@genType
let useLastResumeUpdate = () => {
  let {siteConfig} = Docusaurus.useDocusaurusContext()
  React.useMemo1(() => {
    let lastUpdate = Js.Date.fromString(siteConfig.customFields.lastResumeUpdate)
    switch lastUpdate->Js.Date.toDateString->Js.String2.split(" ") {
    | [_, month, date, year] => Some(`${month} ${date} ${year}`)
    | _ => None
    }
  }, [siteConfig.customFields.lastResumeUpdate])
}

@genType @react.component
let make = () => {
  let lastResumeUpdate = useLastResumeUpdate()
  <div className="centre-content">
    <a
      className={CLSX.clsx("button button--secondary button--lg", styles["resumeButton"])}
      href="/Resume.pdf">
      {switch lastResumeUpdate {
      | Some(d) => "Resume - Last Updated " ++ d
      | None => "Resume"
      }->React.string}
    </a>
  </div>
}
