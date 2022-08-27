type styles = {heroBanner: string}
@module("./styles.module.css")
external styles: styles = "default"

open React
@genType @react.component
let make = (~children=""->string, ~subtitle="", ~title) => {
  <header className={CLSX.clsx("hero hero--primary", styles.heroBanner)}>
    <div className="container">
      {<>
        <h1 className="hero__title"> {title->string} </h1>
        <p className="hero__subtitle"> {subtitle->string} </p>
        {children}
      </>}
    </div>
  </header>
}
