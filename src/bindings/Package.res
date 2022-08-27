module Internal = {
  type author = {name: string, email: string, url: string, username: string}
  type links = {npm: string, homepage: string, repository: string, bugs: string}
  type publisher = {username: string, email: string}
  type detail = {quality: float, popularity: float, maintenance: float}
  type score = {final: float, detail: detail}
  type flags = {unstable: bool}

  type packageT = {
    name: string,
    scope: string,
    version: string,
    description: string,
    keywords?: array<string>,
    date: Js.Date.t,
    links: links,
    author: author,
    publisher: publisher,
    maintainers: array<publisher>,
  }
}

type t = {
  package: Internal.packageT,
  score: Internal.score,
  searchScore: float,
  flags?: Internal.flags,
}

@genType
type data = {objects: array<t>}
