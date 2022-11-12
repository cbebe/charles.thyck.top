---
title: "Dev Log: Boboman - Day 3"
date: 2022-07-05
author: Charles Ancheta
tags: [dev-log, love, lua]
---

Feeling good today. I got to fix the collision bug that was happening yesterday. It actually had to do with the
collision lifecycle, so to make the player detectable, I decoupled the check from the lifecycle of the bomb. Because of
this, I could revert the player's bomb timer to normal. Moving away from a project and letting your brain sit on a
problem for a while really does wonders.

I also created an enemy entity based off the player asset and make that and the box entities destructible by explosions.
I thought I lost my commit progress on it after mashing a few keys on `lazygit`, but I got it back after a `git reflog`
and `git cherry-pick` combo.

Overall, I'm making pretty good progress, and shaping the game more by adding stuff to the TODO.
