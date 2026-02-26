// cmd/wcp360/main.go
package main

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
    _ "github.com/spf13/pflag"   // blank import = "imported for side effects only"
)

// These will be set via ldflags at build time (example: go build -ldflags "-X main.version=0.1.0")
var (
    version   = "0.0.1-dev"
    commit    = "unknown"
    buildDate = "unknown"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
    Use:     "wcp360",
    Short:   "WCP360 - Modern, lightweight, secure web hosting control panel",
    Long: `WCP360 is a next-generation Linux-native web control panel written in pure Go.
Focus: performance-first, security-by-design, modular architecture, zero JavaScript bloat.

Single binary | cgroups v2 isolation | Nginx + Podman orchestration | Coraza WAF

Website (docs): https://github.com/Webcontrolpanel360/wcp360`,
    Version: fmt.Sprintf("%s (commit %s, built %s)", version, commit, buildDate),

    PersistentPreRun: func(cmd *cobra.Command, args []string) {
        // Future: load config, check root privileges if needed, init logger, etc.
    },

    Run: func(cmd *cobra.Command, args []string) {
        // Default behavior when no subcommand is given → show help + welcome
        fmt.Println("Welcome to WCP360 - The modern web hosting control panel")
        fmt.Println("Use --help for available commands or try: wcp360 version")
        cmd.Help()
    },
}

// ---------------------
// Global persistent flags (available on all commands)
// ---------------------
func initGlobalFlags() {
    rootCmd.PersistentFlags().BoolP("verbose", "v", false, "Enable verbose output")
    rootCmd.PersistentFlags().String("config", "/etc/wcp360/config.yaml", "Path to config file")
}

// ---------------------
// Version command (enhanced)
// ---------------------
var versionCmd = &cobra.Command{
    Use:   "version",
    Short: "Show detailed version information",
    Long:  "Displays version, commit hash, build date and Go runtime info.",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("WCP360 %s\n", version)
        fmt.Printf("Commit:     %s\n", commit)
        fmt.Printf("Built:      %s\n", buildDate)
        fmt.Printf("Go version: %s\n", os.Getenv("GO_VERSION")) // or runtime.Version() in real code
        fmt.Println("\nLicense: MIT")
        fmt.Println("Repository: https://github.com/Webcontrolpanel360/wcp360")
    },
}

// ---------------------
// Setup / Bootstrap commands (high priority per ROADMAP)
// ---------------------
var setupCmd = &cobra.Command{
    Use:   "setup",
    Short: "Initialize WCP360 on this server (run as root once)",
    Long: `Performs first-time setup:
- Creates wcp360 system user/group
- Sets up directories (/opt/wcp360, /etc/wcp360, /var/lib/wcp360, ...)
- Initializes internal SQLite/PostgreSQL database
- Generates admin credentials or JWT secret
- Installs systemd service
This is usually called by the install.sh script.`,
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Setup command called (stub - to be implemented)")
        // TODO: check root, create dirs, db init, etc.
    },
}

var adminCreateCmd = &cobra.Command{
    Use:   "admin create [username]",
    Short: "Create the first admin account (run during setup)",
    Args:  cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        username := args[0]
        fmt.Printf("Creating admin user: %s (stub - password/email prompt to be added)\n", username)
        // TODO: prompt password, email, insert into DB with bcrypt hash
    },
}

// ---------------------
// User management (core feature from FEATURES/COMMANDS)
// ---------------------
var userCmd = &cobra.Command{
    Use:   "user",
    Short: "Manage hosting users / accounts",
}

var userCreateCmd = &cobra.Command{
    Use:   "create [username]",
    Short: "Create a new hosting user",
    Args:  cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("Creating user %s (stub)\n", args[0])
        // Flags: --email, --password, --package, --domains-limit, etc.
    },
}

// ---------------------
// Domain management
// ---------------------
var domainCmd = &cobra.Command{
    Use:   "domain",
    Short: "Manage domains / vhosts",
}

var domainAddCmd = &cobra.Command{
    Use:   "add [domain] --user [username]",
    Short: "Add a new domain to a user",
    Args:  cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("Adding domain %s (stub)\n", args[0])
    },
}

// ---------------------
// Database commands
// ---------------------
var dbCmd = &cobra.Command{
    Use:   "db",
    Short: "Manage databases (MariaDB / PostgreSQL)",
}

var dbCreateCmd = &cobra.Command{
    Use:   "create [dbname] --user [username]",
    Short: "Create a new database and user",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Database create stub")
    },
}

// ---------------------
// Backup commands
// ---------------------
var backupCmd = &cobra.Command{
    Use:   "backup",
    Short: "Manage backups (local / S3)",
}

var backupCreateCmd = &cobra.Command{
    Use:   "create [username|all]",
    Short: "Trigger a manual backup",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Backup create stub")
    },
}

// ---------------------
// Security / WAF
// ---------------------
var securityCmd = &cobra.Command{
    Use:   "security",
    Short: "Security tools (WAF, firewall, abuse detection)",
}

var wafStatusCmd = &cobra.Command{
    Use:   "waf status",
    Short: "Show Coraza WAF status and blocked requests",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("WAF status stub")
    },
}

// ---------------------
// Main init
// ---------------------
func init() {
    // Global flags
    initGlobalFlags()

    // Add subcommands
    rootCmd.AddCommand(versionCmd)
    rootCmd.AddCommand(setupCmd)
    rootCmd.AddCommand(adminCreateCmd)

    // User group
    userCmd.AddCommand(userCreateCmd)
    rootCmd.AddCommand(userCmd)

    // Domain group
    domainCmd.AddCommand(domainAddCmd)
    rootCmd.AddCommand(domainCmd)

    // DB group
    dbCmd.AddCommand(dbCreateCmd)
    rootCmd.AddCommand(dbCmd)

    // Backup group
    backupCmd.AddCommand(backupCreateCmd)
    rootCmd.AddCommand(backupCmd)

    // Security group
    securityCmd.AddCommand(wafStatusCmd)
    rootCmd.AddCommand(securityCmd)

    // Example how to add flags to a command
    userCreateCmd.Flags().StringP("email", "e", "", "User email address (required)")
    userCreateCmd.Flags().StringP("package", "p", "basic", "Hosting package/skeleton")
    userCreateCmd.MarkFlagRequired("email") // example
}

func main() {
    if err := rootCmd.Execute(); err != nil {
        fmt.Fprintf(os.Stderr, "Error: %v\n", err)
        os.Exit(1)
    }
}