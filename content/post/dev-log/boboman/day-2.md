---
title: "Dev Log: Boboman - Day 2"
date: 2022-07-04
author: Charles Ancheta
tags: [dev-log, love, lua, gh-pages]
---

MAJOR BUG ALERT!!

Apparently my collision logic for the bombs weren't going to hold up. Every time a bomb explodes, there is a small time
window where you can place a bomb and the bomb would not recognize the player, making it a "not new" bomb. Because of
that, the player gets pushed off right away and could end up in the weirdest of places.

After hours of debugging I couldn't really solve it because of how the collision library orders the entity updates. I
didn't feel like giving up for today, though, and making no progress. I simply created a deployment script to deploy the
game to [GitHub pages](https://cbebe.github.io/boboman/) and fixed the player update logic so it at least doesn't end up
outside of the map. Still a pretty good day even if I didn't make as much progress as I wanted.
