package main

import (
	"net/http"
	"os"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/Webcontrolpanel360/wcp360/internal/db"
	"github.com/Webcontrolpanel360/wcp360/internal/provisioner/system"
)

func main() {
	db.InitDB()
	e := echo.New()
	
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// SÉCURITÉ : Empêcher l'accès direct aux fichiers sensibles
	e.File("/", "ui/templates/login.html")
	e.File("/login", "ui/templates/login.html")
	e.File("/admin", "ui/templates/admin_accounts.html")
	e.File("/dashboard", "ui/templates/user_dashboard.html")

	// API : Lecture de fichier sécurisée
	e.GET("/api/user/files/read", func(c echo.Context) error {
		user := c.QueryParam("user")
		file := c.QueryParam("file")
		
		path := system.SafePath(user, file)
		content, err := os.ReadFile(path)
		if err != nil { return c.JSON(404, "Fichier introuvable") }
		
		return c.JSON(http.StatusOK, map[string]string{"content": string(content)})
	})

	e.Logger.Fatal(e.Start(":8080"))
}
