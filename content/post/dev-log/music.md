---
title: "Background music while working"
author: Charles Ancheta
date: 2025-01-07T23:19:11-07:00
tags:
  - dev
  - music
  - scripting
---

Finally found some appropriate background music for when I'm working.

My peers used to always ask me what I listen to while working on my computer,
and they're always shocked to find out that I work in silence. I used to
unironically listen to
[lofi hip hop mix 📚 beats to relax/study to](https://www.youtube.com/watch?v=CFGLoQIhmow)
but I get too sleepy. When I listen to music I actually like listening to, I get
too distracted.

So I searched up "focus beats" and got
[this](https://www.youtube.com/watch?v=wELOA2U7FPQ).

Of course, I can't just have it playing all day because of meetings, so I set up
a hotkey that runs a script to play/pause the music on `tmux`:

```sh
#!/bin/sh

session_name="focus"
mpv_command="mpv --vo=null --video=no --no-video --term-osd-bar --no-resume-playback ~/Music/Focus.m4a"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new-session -d -s "$session_name" "$mpv_command"
else
	tmux send-keys -t "${session_name}.0" "space"
fi
```
