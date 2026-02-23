// cmd/wcpd/main.go
package main

import (
    "context"
    "flag"
    "fmt"
    "log"
    "net/http"
    "os"
    "os/signal"
    "syscall"
    "time"

    "github.com/Webcontrolpanel360/wcp360/core/config"
)

func main() {
    configPath := flag.String("config", "configs/dev.yaml", "chemin de la config")
    debug := flag.Bool("debug", false, "mode debug")
    flag.Parse()

    cfg, err := config.Load(*configPath)
    if err != nil {
        log.Fatalf("Erreur config: %v", err)
    }

    if *debug {
        log.Printf("Debug ON | Config: %s | Port: %d", *configPath, cfg.Server.Port)
    }

    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()

    mux := http.NewServeMux()
    mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "WCP360 ok")
    })

    srv := &http.Server{
        Addr:    fmt.Sprintf(":%d", cfg.Server.Port),
        Handler: mux,
    }

    go func() {
        log.Printf("Écoute sur :%d", cfg.Server.Port)
        if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            log.Fatal(err)
        }
    }()

    sig := make(chan os.Signal, 1)
    signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
    <-sig

    log.Println("Arrêt...")
    shutdownCtx, _ := context.WithTimeout(context.Background(), 10*time.Second)
    srv.Shutdown(shutdownCtx)
    log.Println("Terminé")
}
