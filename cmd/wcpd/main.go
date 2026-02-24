package main

import (
    "log"
    "net/http"

    "github.com/gin-gonic/gin"
    "go.uber.org/zap"
)

func main() {
    // Logger de base (à améliorer plus tard avec config)
    logger, _ := zap.NewProduction()
    defer logger.Sync()

    logger.Info("Starting WCP360 Core Minimal...")

    // Serveur Gin minimal
    r := gin.Default()

    // Endpoint health simple
    r.GET("/healthz", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "status": "healthy",
            "version": "0.0.1-alpha",
        })
    })

    // Endpoint racine pour tester
    r.GET("/", func(c *gin.Context) {
        c.String(http.StatusOK, "WCP360 Core Minimal is running! 🚀")
    })

    // Lancement sur port 8080 (configurable plus tard)
    port := ":8080"
    logger.Info("Server listening on " + port)
    if err := r.Run(port); err != nil {
        log.Fatalf("Failed to start server: %v", err)
    }
}