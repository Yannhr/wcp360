package main

import (
	"net/http"
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
	e.Use(middleware.CORS())

	// Pages
	e.File("/", "ui/templates/login.html")
	e.File("/login", "ui/templates/login.html")
	e.File("/admin", "ui/templates/admin_accounts.html")
	e.File("/dashboard", "ui/templates/user_dashboard.html")

	// API Login
	e.POST("/api/login", func(c echo.Context) error {
		return c.JSON(http.StatusOK, map[string]string{"token": "test", "role": "root"})
	})

	// API Fichiers
	e.GET("/api/user/files", func(c echo.Context) error {
		user := c.QueryParam("user")
		files, err := system.ListUserFiles(user)
		if err != nil { return c.JSON(500, err.Error()) }
		return c.JSON(http.StatusOK, files)
	})

	e.Logger.Fatal(e.Start(":8080"))
}
