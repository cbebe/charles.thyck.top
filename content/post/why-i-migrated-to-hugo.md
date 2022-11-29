---
title: "Why I Migrated to Hugo"
date: 2022-11-29T02:50:15-07:00
author: Charles Ancheta
tags: [website, hugo, blazingly, fast, js, go, rescript]
---

Aside from the fact that Hugo is _Blazingly Fast™_, I had a few problems with
Docusaurus/the whole JS ecosystem that made it hard for me to keep updating my
website.

<!--more-->

## I had no need for React in this website

There were only a few components that needed JavaScript, and now that I re-built
the website with Hugo, there was only one that actually needed to be dynamic
(i.e. post comments section, which was a single script tag in Hugo compared to
an entire source file in React).

I was basically compiling my Markdown files to JSX, then compiling it to HTML
instead of going directly to HTML. This made me unsatisfied with my build times
considering I was not using much Docusaurus' features.

## I liked writing code too much that I never wrote actual content

Around the end of August, I discovered [ReScript](https://rescript-lang.org/).
This was a breath of fresh air, coming from TypeScript fatigue. Naturally, I was
tempted to convert all my TypeScript projects to ReScript (even my work ones,
thank my co-worker for stopping me).

My website wasn't saved from this, though. It was fun for a while, playing
around with its type system. Then I realized I spent more time inside the `src`
directory instead of `blog`. I was basically just playing around with the code,
not even changing the appearance or structure of the pages.

While I still use ReScript for my actual projects, my website doesn't need it.

## Simply less JavaScript

My content is purely markdown, my structure is purely HTML, my styling is
stolen[^1]. No code necessary[^2]. The only JS that I request now is from
Cloudflare (email protection and analytics) and
[utteranc.es](https://utteranc.es/) (post comments using GitHub account). In
conclusion, I'm just de-bloating my website, and I'm trying to move away from
writing more code. The world surely is a better place with me exercising
restraint.

[^1]: I really just love this [style](https://github.com/joeroe/risotto).

[^2]: [aside from the little Go script that I use to auto-generate
more content](/post/go-interfaces/), but this is just one instance
