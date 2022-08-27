type role = [#img]
type props = {role: role, className?: string}
type t = React.component<props>

@module("@site/static/img/devpost.svg") external devpost: t = "default"
@module("@site/static/img/email.svg") external email: t = "default"
@module("@site/static/img/gitea.svg") external gitea: t = "default"
@module("@site/static/img/github.svg") external github: t = "default"
@module("@site/static/img/isaic.svg") external isaic: t = "default"
@module("@site/static/img/linkedin.svg") external linkedin: t = "default"
@module("@site/static/img/npm-logo.svg") external npm: t = "default"
@module("@site/static/img/thyck/h2h.svg") external h2h: t = "default"
@module("@site/static/img/thyck/logo.svg") external thyck: t = "default"
@module("@site/static/img/thyck/wapp.svg") external wapp: t = "default"
