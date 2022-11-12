///usr/bin/true; exec /usr/bin/env go run "$0" "$@"

// Simple HTTP server for testing build output
// Run ./serve.go and open http://localhost:3000 in your browser

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
