@module("./styles.module.css")
external styles: {"main": string, "wrapper": string, "softie": string} = "default"

@genType @react.component
let make = () => {
  <Docusaurus.Layout
    wrapperClassName={styles["wrapper"]}
    title="Hello!"
    description="Charles Ancheta's Personal Website">
    <main className={CLSX.clsx("centre-content", styles["main"])}>
      <Name />
      <div className={styles["softie"]}>
        <VMoji />
        <h1 className="hero__subtitle"> {"Software Engineer"->React.string} </h1>
        <VMoji mirror={true} />
      </div>
    </main>
  </Docusaurus.Layout>
}
