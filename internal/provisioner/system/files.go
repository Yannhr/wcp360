package system

import (
	"os"
)

type FileEntry struct {
	Name  string `json:"name"`
	IsDir bool   `json:"is_dir"`
	Size  int64  `json:"size"`
}

func ListUserFiles(username string) ([]FileEntry, error) {
	// Sur Codespaces on utilise /tmp pour simuler le home
	path := "/tmp/wcp360_home/" + username
	
	// S'assure que le dossier existe pour éviter l'erreur
	os.MkdirAll(path, 0755)

	entries, err := os.ReadDir(path)
	if err != nil {
		return nil, err
	}

	var files []FileEntry
	for _, entry := range entries {
		info, _ := entry.Info()
		files = append(files, FileEntry{
			Name:  entry.Name(),
			IsDir: entry.IsDir(),
			Size:  info.Size(),
		})
	}
	return files, nil
}
