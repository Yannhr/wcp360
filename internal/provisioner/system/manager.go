package system

import (
	"path/filepath"
	"strings"
	"os"
)

// SafePath empêche un utilisateur de sortir de son dossier (ex: ../../etc/passwd)
func SafePath(username, filename string) string {
	basePath := "/tmp/wcp360_home/" + username
	// Clean élimine les .. et les slashs en trop
	path := filepath.Join(basePath, filepath.Clean("/"+filename))
	
	// On vérifie que le chemin final commence bien par le chemin de base
	if !strings.HasPrefix(path, basePath) {
		return basePath
	}
	return path
}
