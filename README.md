# Website

This website is built using [Hugo](https://gohugo.io) and my own
[fork](https://github.com/cbebe/risotto) of
[risotto](https://github.com/joeroe/risotto).

## Turnip calculator (`/turnip`)

- A less-featureful (and not necessarily more performant) clone of
  [Turnip Prophet](https://turnipprophet.io/) written in Rust and ReScript.
- Cold (very cold) starts take at most 1.5 seconds to load results. Average is
  <100 milliseconds.

## Scripts (`/bin`)

- `deploy` (Go)
  - Builds and deploys the website to GitHub Pages
  - Requires write access to the GitHub repository
- `packages` (Go)
  - Fetches all npm packages published by me (`cbebe`) from the NPM registry and
    writes it to a Markdown table
  - Requires `deno` to format the Markdown table
- `serve` (Go)
  - Serves the build output locally
- `make-turnip` (Shell)
  - Required for the Turnip Calculator page
  - Creates the `script` element load the bundled JavaScript

## Future Post Ideas (`/data/TODO.md`)

- To-do list of post ideas
- I will most likely be drawn away from my original ideas when I actually start
  writing

## Resume (`/resume`)

- My Resume written in LaTeX
- Can be easily built with [Nix](https://nixos.org/)
  ```bash
  cd resume
  ./make.sh # nix-shell --pure --run 'make'
  ```
- NOTE: Be careful when clicking the links on the PDF viewer while using
  `nix-shell` and watch mode (`./make.sh watch`). Weird stuff happens to Firefox
  when I click the link on the PDF viewer which forces me to kill all Firefox
  processes.
  - If you need to test the links, use your own PDF viewer.
