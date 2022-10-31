@module("./styles.module.css")
external styles: {"heroBanner": string} = "default"

@react.component
let make = (~children=React.string(""), ~subtitle="", ~title) => {
  <header className={CLSX.clsx("hero hero--primary", styles["heroBanner"])}>
    <div className="container">
      {<>
        <h1 className="hero__title"> {React.string(title)} </h1>
        <p className="hero__subtitle"> {React.string(subtitle)} </p>
        {children}
      </>}
    </div>
  </header>
}
