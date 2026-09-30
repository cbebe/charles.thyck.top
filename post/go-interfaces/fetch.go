package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"path"

	"github.com/bitfield/script"
)

const maintainer = "cbebe"

func main() {
	// Create file for writing
	f, err := os.Create("data/packages.md")
	if err != nil {
		log.Fatalf("failed to create file: %v", err)
	}
	defer f.Close()
	// Fetch data from NPM and extract relevant data with jq
	req := script.Get("https://registry.npmjs.org/-/v1/search?text=maintainer:" + maintainer)
	out, err := req.JQ("[.objects | .[] | {href: .package.links.npm, description: .package.description}]").Bytes()
	if err != nil {
		log.Fatalf("error fetching packages: %v", err)
	}
	// Parse JSON into an array of structs
	var packages []struct {
		Href        string
		Description string
	}
	json.Unmarshal(out, &packages)

	// Write Markdown into file
	fmt.Fprint(f, "| package | description |\n|-|-|\n")
	for _, p := range packages {
		name := path.Base(p.Href)
		fmt.Fprintf(f, "| [%s](%s) | %s |\n", name, p.Href, p.Description)
	}
}
