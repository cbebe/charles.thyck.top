type customFields = {lastResumeUpdate: string}
type siteConfig = {customFields: customFields}
type docusaurusContext = {siteConfig: siteConfig}
@module("@docusaurus/useDocusaurusContext")
external useDocusaurusContext: unit => docusaurusContext = "default"

let useLastResumeUpdate = () => {
  let {siteConfig} = useDocusaurusContext()
  React.useMemo1(() => {
    let lastUpdate = Js.Date.fromString(siteConfig.customFields.lastResumeUpdate)
    switch lastUpdate->Js.Date.toDateString->Js.String2.split(" ") {
    | [_, month, date, year] => Some(`${month} ${date} ${year}`)
    | _ => None
    }
  }, [siteConfig.customFields.lastResumeUpdate])
}
