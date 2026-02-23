// cmd/version.go
package cmd

import (
    "fmt"

    "github.com/spf13/cobra"
)

// These can be set at build time with ldflags, e.g.:
// go build -ldflags "-X main.version=0.1.0 -X main.commit=abc123"
var (
    version = "0.1.0-dev"
    commit  = "unknown"
    date    = "unknown"
)

func init() {
    rootCmd.AddCommand(versionCmd)
}

var versionCmd = &cobra.Command{
    Use:   "version",
    Short: "Print version information",
    Long:  `Show the version number, commit hash, and build date of wcp360 CLI.`,
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("wcp360 version %s\n", version)
        fmt.Printf("Commit:     %s\n", commit)
        fmt.Printf("Built:      %s\n", date)
        fmt.Println("License:    AGPL-3.0")
        fmt.Println("Repository: https://github.com/Webcontrolpanel360/wcp360")
    },
}