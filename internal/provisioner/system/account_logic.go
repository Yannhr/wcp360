package system

import (
	"fmt"
	"os/exec"
	"github.com/Webcontrolpanel360/wcp360/internal/db"
)

func CreateUserAccount(username, password, domain string) error {
	// 1. Création Linux
	exec.Command("useradd", "-m", "-s", "/bin/bash", username).Run()
	exec.Command("echo", fmt.Sprintf("%s:%s", username, password), "|", "chpasswd").Run()
	
	// 2. Création de l'arborescence
	path := fmt.Sprintf("/var/www/wcp360/vhosts/%s", domain)
	exec.Command("mkdir", "-p", path).Run()
	exec.Command("chown", "-R", username+":"+username, path).Run()

	// 3. Enregistrement DB
	_, err := db.Conn.Exec("INSERT INTO users (username, role) VALUES (?, 'user')", username)
	_, err = db.Conn.Exec("INSERT INTO sites (domain, owner) VALUES (?, ?)", domain, username)
	
	return err
}
