@module("./styles.module.css")
external styles: {"heroBanner": string} = "default"

@genType @react.component
let make = (~children=""->React.string, ~subtitle="", ~title) => {
  <header className={CLSX.clsx("hero hero--primary", styles["heroBanner"])}>
    <div className="container">
      {<>
        <h1 className="hero__title"> {title->React.string} </h1>
        <p className="hero__subtitle"> {subtitle->React.string} </p>
        {children}
      </>}
    </div>
  </header>
}
