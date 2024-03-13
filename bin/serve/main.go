/// 2>/dev/null ; gorun "$0" "$@" ; exit $?

// Simple HTTP server for testing build output
// Run `make serve` and open http://localhost:3000 in your browser

package main

import (
	"log"
	"net/http"
)

func main() {
	fs := http.FileServer(http.Dir("./public"))
	http.Handle("/", fs)

	log.Print("Listening on :3000...")
	err := http.ListenAndServe(":3000", nil)
	if err != nil {
		log.Fatal(err)
	}
}
