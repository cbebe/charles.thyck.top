type styles = {main: string, wrapper: string, softieWrapper: string, softie: string}
@module("./styles.module.css")
external styles: styles = "default"

@genType @react.component
let make = () => {
  <Docusaurus.Layout
    wrapperClassName={styles.wrapper}
    title="Hello!"
    description="Charles Ancheta's Personal Website">
    <main className={CLSX.clsx("centre-content", styles.main)}>
      <Name />
      <div className={styles.softieWrapper}>
        <VMoji />
        <h1 className={CLSX.clsx("hero__subtitle", styles.softie)}>
          {"Software Engineer"->React.string}
        </h1>
        <VMoji mirror={true} />
      </div>
    </main>
  </Docusaurus.Layout>
}
