package main

import (
    "fmt"
    "net/http"
)

// Main web service function
func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":8080", nil)
}

// Return a "Hello world" string
func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello wide world!")
}
