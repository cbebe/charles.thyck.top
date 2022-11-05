#!/bin/sh
# A hack to re-use ReScript URL.res bindings in the config
# Just using ReScript output here won't work because of the export keyword
# Hours wasted because I forgot that I tried to do that again: 2

{
  cat $1
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
} >$2
