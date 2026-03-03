package db

import (
	"database/sql"
	"fmt"
	_ "github.com/mattn/go-sqlite3"
)

var Conn *sql.DB

func InitDB() {
	var err error
	Conn, err = sql.Open("sqlite3", "./wcp360.db")
	if err != nil {
		panic(err)
	}

	// Nouveau schéma avec table Databases
	schema := `
	CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, role TEXT);
	CREATE TABLE IF NOT EXISTS sites (id INTEGER PRIMARY KEY, domain TEXT, owner TEXT);
	CREATE TABLE IF NOT EXISTS databases (id INTEGER PRIMARY KEY, db_name TEXT, db_user TEXT, owner TEXT);
	`
	
	_, err = Conn.Exec(schema)
	if err != nil {
		fmt.Println("Erreur schéma:", err)
	}
}
