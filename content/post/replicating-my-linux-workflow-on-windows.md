---
title: "Replicating My Linux Workflow on Windows"
date: 2022-12-09T00:49:52-07:00
author: Charles Ancheta
---

A new co-op position meant new hardware[^1], and a new technology stack to
learn. Unfortunately, that includes having to use Windows. Coming back to
Windows after almost 2 full years on Linux, it felt like I forgot how to use a
computer. All the keyboard shortcuts that my hands were used to would do funny
things like lock my laptop. I just wanted my shell, my terminal, and my tiling
window manager back.

Note that this post is only about Windows alternatives for tools in my Linux
workflow. I won't be talking about tools that are specific to the job like IDEs
and DB browsers (maybe in a separate post).

## Going full Linux with WSL

I used WSL before I became a full-time Linux user. I had a positive experience
with it, so my first instinct was to reach for that. I was disappointed with the
performance, though, and the startup time is horrible. Not good if I want to be
able to use the shell right away. Having a separate `$HOME` directory also made
file organization awkward.

I figured that this was in no way going to be tolerable, so I knew I had to get
cross-platform or Windows-native tools. It was time to give up my dream of
having a single workflow everywhere.

## Terminal Tools

### Shell: Nushell ([`nu`](https://www.nushell.sh/))

I use Nushell because... (?) I didn't like Powershell[^2]?? Now that I'm writing
about it, there was no reason for me NOT to learn Powershell. The concept of
piping objects instead of text is somewhat different, but Nushell uses that same
concept (since it's inspired by Powershell). If anything, Powershell is probably
more polished since it's built with Windows as a priority. I also had to spend
time learning Nushell, anyway. My time would've been better spent learning the
tools that are actually native to the system I'm using. I wasn't giving up `zsh`
on my Linux machines either, so Nushell being cross-platform doesn't mean
anything to me.

### Directory navigation: [`lf`](https://github.com/gokcehan/lf) -> [`zoxide`](https://github.com/ajeetdsouza/zoxide)

I used to use `lf` to change directories using an
[`lfcd`](https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh) binding, but
it's a bit harder to integrate with Nushell since change in environment
variables are scoped. I came across `zoxide` which is great for jumping around
my most frequently visited directories. If I do need to explore a deep
directory, I actually fire up `lf`, even if it takes around 1.5 seconds to start
up.

### Terminal Multiplexing: Nothing :(

I tried looking for a cross-platform platform alternative to
[`tmux`](https://github.com/tmux/tmux/wiki), probably something written in Go or
Rust. One of them was [`zellij`](https://zellij.dev/), but it doesn't work on
Windows. For simple terminal management, [Windows Terminal](#terminal-emulator)
works fine.

#### Neovim

I have also flipped my workflow around Neovim and terminals. Instead of having
two or three `tmux` panes, I simply have Neovim open and use the terminal inside
it using the `:terminal` command. By not using Neovim inside `tmux`, I can use
the increment number (`<C-a>`) binding properly. I have also carried this in my
Linux workflow which simplifies things by a lot. It could get annoying sometimes
though when I accidentally quit Neovim as it also kills the shell sessions that
I start inside it. VSCode also has this problem so I usually run development
server processes in separate Windows Terminal tabs.

## Window Management

I tried to get tiling windows using
[FancyZones from Microsoft PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/fancyzones),
but it felt laggy and it was quite a resource hog. I also didn't have enough
screen space for it to be useful, anyway. I eventually got used to pressing
`Alt + Tab` and `Alt + Shift + Tab` to go back and forth between windows, which
isn't too bad. I have also carried this keyboard shortcut back to Pop! OS,
although I still prefer moving between workspaces[^3].

## Terminal Emulator

Windows Terminal, hands down. This is what I've used back when I used
Windows 10. It's customizable enough to keep me happy and the shortcut to start
different shells in new tabs is really handy when I need an admin shell (no more
searching for `Powershell`, and clicking 'Run as Administrator'). It's also the
only terminal that I've used on Windows that actually sends mouse terminal
sequences to programs. Even the VSCode integrated terminal doesn't work properly
with `lazygit`!

I also tried using Alacritty, which is what I use for the rest of my machines,
but it doesn't matter how fast the terminal emulator is if the programs
themselves are slow. Not having the features of Windows terminal actually slows
me down more.

## Conclusion

When I first started using Windows again, it all felt so foreign to me. But with
these alternatives to my workflow, there's not much difference from when I'm
working inside Linux. Maybe except for having Visual Studio running in the
background for the back-end server. With cross-platform tools written in modern
languages like Rust and Go, I can simply download the binary, plop it into
`PATH`, and go crazy.

[^1]: This beast of a gaming laptop costs around 3 times as much as my personal
laptop. It does makes sense now that they'd give me something so beefed up since
none of my own hardware can actually run Visual Studio.

[^2]: Maybe it had to do with it being slow? I think all shells are sluggish on
Windows anyway, even Nushell. Powershell 7 promises some performance
improvements, though. I will try setting it as my main shell after I've copied
my Nushell config. Writing really does help with introspection. EDIT December
17: Nope, nope, nope. The shell taking at most 1.5 seconds to "load
configurations" when I haven't made any personal configuration yet seems like
bad news. I will never use it as an interactive shell, sorry.

[^3]: I realized now that Windows also has desktop workspaces. I need to start
using that more.
