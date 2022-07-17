@genType @react.component
let make = () => {
  open Docusaurus
  <Layout title="Projects" description="Charles Ancheta's Projects">
    <ProjectHeaderSection />
    <main>
      <ThyckCorgisSection />
      <PackagesSection />
    </main>
  </Layout>
}
