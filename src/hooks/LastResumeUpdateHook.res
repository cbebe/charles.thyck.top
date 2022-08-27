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
