---
title: Bye bye Netlify
slug: bye-bye-netlify
authors: cbebe
tags: [netlify, hosting]
---

It was short trial, but GitHub Pages just works better for me.

<!-- truncate -->

A couple of weeks ago, I moved my website from GitHub Pages to Netlify, hoping
for a better development and production experience. I didn't really have a need
to move just yet, but I wanted to see what the buzz about Netlify was about. So
I spent a few hours setting it up and pointing my domain to the Netlify app.

It was working just fine at first, until I started making updates. The page
would just load indefinitely and I would have to visit `cbebe.netlify.app`
first before `charlesancheta.com` would behave properly. I've had a few
embarrassing moments showing my website to people for a couple times and it
refusing to load.

Another annoying was that every pull request and push to the master branch
would trigger a build, even if none of the pages were modified. Netlify only
provides a limited about of build time every month, so I found myself
cancelling more builds in the Netlify dashboard more often than I manually
deployed a build using the command line. This could be nice if other people
were contributing to this repo, but since this is a personal website, I find
that unlikely.

Realizing these, I moved back to GitHub Pages and manually deploying with the
CLI. Maybe in the future where I would have to actually launch a
production-level static website that I would revisit Netlify, but for now, I'll
stick with my current workflow.
