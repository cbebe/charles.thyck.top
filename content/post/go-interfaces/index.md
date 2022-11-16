---
title: "Go Interfaces give me a reason to live again"
date: 2022-11-16T03:52:09-07:00
author: Charles Ancheta
tags: [dev, go, scripting]
---

A few months ago I made a [meme](/post/friendship-ended) about Go being my new
favourite language (replacing TypeScript) and I just want to share a satisfying
moment I had recently.

# The Task

In the [previous iteration](https://cbebe.github.io/v2) of my website[^1], I
have a few lines in my config that fetches information about my published NPM
packages to be rendered on the
[Projects page](https://cbebe.github.io/v2/projects/#packages). I wanted to do
the same for my new website, outputted as a Markdown table, which can be easily
imported into the page with [`readFile`](https://gohugo.io/functions/readfile/).

# Initial Code

{{< readfile file="fetch.go" code="true" lang="go" >}}

The initial code works fine for the task, but I also want it to be formatted
with [`deno fmt`](https://deno.land/manual@v1.28.0/tools/formatter) (for no good
reason since it's not even commited into version control). My first instinct was
to pipe it into `deno fmt` so I wouldn't have to create a temporary file. I
could do that with the `script`[^2] package using a one-liner.

```go
// equivalent to `echo "$str" | deno fmt - --ext md > data/packages.md`
script.Echo(str).Exec("deno fmt - --ext md").WriteFile("data/packages.md")
```

# Refactoring

I noticed that I only call `fmt.Fprint` and `fmt.Fprintf` on the file, which
only needs the `io.Writer` interface, so we can pull the Markdown writing code
into a function.

```go
func writePackagesTable(w io.Writer) error {
	req := script.Get("https://registry.npmjs.org/-/v1/search?text=maintainer:" + maintainer)
	out, err := req.JQ("[.objects | .[] | {href: .package.links.npm, description: .package.description}]").Bytes()
	if err != nil {
		return fmt.Errorf("error fetching packages: %v", err)
	}

	var packages []struct {
		Href        string
		Description string
	}
	json.Unmarshal(out, &packages)

	// Write Markdown into a Writer
	fmt.Fprint(w, "| package | description |\n|-|-|\n")
	for _, p := range packages {
		name := path.Base(p.Href)
		fmt.Fprintf(w, "| [%s](%s) | %s |\n", name, p.Href, p.Description)
	}
}
```

Then in `main` I can simply pass the file to this new function.

```go
func main() {
	f, err := os.Create("data/packages.md")
	if err != nil {
		log.Fatalf("failed to create file: %v", err)
	}
	defer f.Close()
	if err := writePackagesTable(f); err != nil {
		log.Fatal(err)
	}
}
```

The neat thing is that I can now pass in anything that implements the
`io.Writer` interface, which is a lot of things in the standard library. This
includes `*bytes.Buffer`, which I can convert into a string and pipe into
`deno fmt` before saving the output to a file.

```diff
func main() {
-	f, err := os.Create("data/packages.md")
-	if err != nil {
-		log.Fatalf("failed to create file: %v", err)
-	}
-	defer f.Close()
+	buf := bytes.NewBuffer(nil)
-	if err := writePackagesTable(f); err != nil {
+	if err := writePackagesTable(buf); err != nil {
		log.Fatal(err)
	}
+	script.Echo(buf.String()).Exec("deno fmt - --ext md").WriteFile("data/packages.md")
}
```

# Conclusion

Go's standard library has a really nice API when it comes to I/O, which makes
changes a breeze if you keep your interfaces small. Gems like this makes me love
Go even more and it's definitely going to be my go-to language from now on[^3].

[^1]: I admit that the Docusaurus site is way cuter, but then I realized that no
one should have to download half a megabyte of JS just to read some text on a
browser

[^2]: Cross-platform Scripting with Go is more fun (and readable!) with the
[script](https://pkg.go.dev/github.com/bitfield/script#section-readme) package
which I discovered from this
[article](https://bitfieldconsulting.com/golang/scripting) by the same author.

[^3]: Another satisfying moment I had with Go is porting the
[`docusaurus deploy`](https://github.com/facebook/docusaurus/blob/542228ee1beb5cfddd7ba8ae088f109f164e80c5/packages/docusaurus/src/commands/deploy.ts#L187)
command for my website. This cuts down the deploy time for my website from 5
minutes to under 5 seconds!!! This probably has to do more with moving from
Docusaurus to Hugo, but there is certainly a bump in speed when executing
natively compared to Node.js.
