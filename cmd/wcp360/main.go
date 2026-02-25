package main

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
    Use:   "wcp360",
    Short: "WCP360 - Modern Linux Web Control Panel",
    Long: `WCP360 is a lightweight, secure, pure-Go web hosting control panel.
Focus: performance, security by design, no bloat.`,
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("WCP360 v0.0.1-dev – Hello from the future control panel!")
        fmt.Println("Use --help for commands.")
    },
}

func main() {
    if err := rootCmd.Execute(); err != nil {
        fmt.Fprintf(os.Stderr, "Error: %v\n", err)
        os.Exit(1)
    }
}
// Ajoute après la définition de rootCmd
var versionCmd = &cobra.Command{
    Use:   "version",
    Short: "Show WCP360 version",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("WCP360 version 0.0.1-dev (development skeleton)")
    },
}

func init() {
    rootCmd.AddCommand(versionCmd)
}