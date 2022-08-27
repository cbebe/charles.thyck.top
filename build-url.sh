#!/bin/sh
# A hack to re-use ReScript URL.res bindings in the config

{
  cat src/bindings/URL.res
  cat <<EOF

module.exports = {
  extras,
  work,
  profiles,
  thyck,
  website,
  repo,
};
EOF
} >config/url.js
pnpm docusaurus build
