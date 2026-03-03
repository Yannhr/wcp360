package system

import (
	"fmt"
	"os"
	"github.com/Webcontrolpanel360/wcp360/internal/db"
)

type Account struct {
	ID       int    `json:"id"`
	Username string `json:"username"`
	Domain   string `json:"domain"`
}

func GetAccounts() ([]Account, error) {
	rows, err := db.Conn.Query("SELECT id, username FROM users")
	if err != nil { return nil, err }
	defer rows.Close()

	var accounts []Account
	for rows.Next() {
		var a Account
		rows.Scan(&a.ID, &a.Username)
		db.Conn.QueryRow("SELECT domain FROM sites WHERE owner = ?", a.Username).Scan(&a.Domain)
		accounts = append(accounts, a)
	}
	return accounts, nil
}

func CreateFullAccount(username, password, domain, quota string) error {
	// SIMULATION pour GitHub Codespaces (évite l'erreur de permission)
	fakePath := "/tmp/wcp360_home/" + username
	os.MkdirAll(fakePath, 0755)
	
	// Enregistrement DB
	db.Conn.Exec("INSERT INTO users (username, role) VALUES (?, 'user')", username)
	db.Conn.Exec("INSERT INTO sites (domain, owner) VALUES (?, ?)", domain, username)

	fmt.Printf("[SIMULATION] Compte créé : %s\n", username)
	return nil
}
