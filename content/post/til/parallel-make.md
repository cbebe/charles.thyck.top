---
title: "TIL: Parallel `make`"
date: 2023-05-30
author: Charles Ancheta
description: "I've always kind of known about the `-j` flag for `make`, but I didn't know that **it just works**."
tags: [til, make, gnu, compilation, c++]
---

I've always kind of known about the `-j` flag for `make`, but I didn't know
that **it just works**.

<!--more-->

I started [dabbling in C++ again](https://github.com/cbebe/monkey-cpp), which
meant dealing with `Makefiles`, compilation orders, and the like. I'm not sure
what part of my code is slowing down my compilation times, but it is
disappointing coming from Go and C. It's even slower than a clean Rust build!!

I thought to myself that maybe there's a way to parallelize the compilation
steps, after doing some setup. I was wrong, it did not need any setup. Just
slap a `-j` in there for infinite jobs and you're good.

```bash
# Without -j
[chrlz@workstation master monke]$ time make all
mkdir -p obj
g++ -c -o obj/token.o -std=c++20 -Wall -Wextra -pedantic -O3 src/token.cpp
g++ -c -o obj/lexer.o -std=c++20 -Wall -Wextra -pedantic -O3 src/lexer.cpp
g++ -c -o obj/ast.o -std=c++20 -Wall -Wextra -pedantic -O3 src/ast.cpp
g++ -c -o obj/parser.o -std=c++20 -Wall -Wextra -pedantic -O3 src/parser.cpp
g++ -c -o repl.o -std=c++20 -Wall -Wextra -pedantic -O3 repl.cpp
g++ -o monke_repl -std=c++20 -Wall -Wextra -pedantic -O3 obj/token.o obj/lexer.o obj/ast.o obj/parser.o repl.o
make all  9.08s user 0.66s system 99% cpu 9.748 total

# With -j
[chrlz@workstation master monke]$ time make -j all
mkdir -p obj
g++ -c -o repl.o -std=c++20 -Wall -Wextra -pedantic -O3 repl.cpp
g++ -c -o obj/token.o -std=c++20 -Wall -Wextra -pedantic -O3 src/token.cpp
g++ -c -o obj/lexer.o -std=c++20 -Wall -Wextra -pedantic -O3 src/lexer.cpp
g++ -c -o obj/ast.o -std=c++20 -Wall -Wextra -pedantic -O3 src/ast.cpp
g++ -c -o obj/parser.o -std=c++20 -Wall -Wextra -pedantic -O3 src/parser.cpp
g++ -o monke_repl -std=c++20 -Wall -Wextra -pedantic -O3 obj/token.o obj/lexer.o obj/ast.o obj/parser.o repl.o
make -j all  10.27s user 0.77s system 255% cpu 4.317 total
```

It basically cuts down my compilation time by 50%. I feel like a real dummy
now.
