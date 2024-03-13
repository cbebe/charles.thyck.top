/// 2>/dev/null ; gorun "$0" "$@" ; exit $?

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os/exec"
	"path"

	"github.com/bitfield/script"
)

const maintainer = "cbebe"

func writePackagesTable(w io.Writer) error {
	req := script.Get("https://registry.npmjs.org/-/v1/search?text=maintainer:" + maintainer)
	parsed, err := req.JQ("[.objects | .[] | {href: .package.links.npm, description: .package.description}]").Bytes()
	if err != nil {
		return fmt.Errorf("error fetching packages: %v", err)
	}

	var packages []struct {
		Href        string
		Description string
	}
	json.Unmarshal(parsed, &packages)

	fmt.Fprint(w, "| package | description |\n|-|-|\n")
	for _, p := range packages {
		name := path.Base(p.Href)
		fmt.Fprintf(w, "| [%s](%s) | %s |\n", name, p.Href, p.Description)
	}

	return nil
}

func main() {
	if _, err := exec.LookPath("deno"); err != nil {
		log.Fatalf("`deno` executable not found")
	}
	buf := bytes.NewBuffer(nil)
	if err := writePackagesTable(buf); err != nil {
		log.Fatal(err)
	}
	// We can simply write to a file instead of formatting
	// the GENERATED text but we extra like that
	script.Echo(buf.String()).Exec("deno fmt - --ext md").WriteFile("data/packages.md")
}
