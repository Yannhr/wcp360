package filesystem

import (
    "os"
    "path/filepath"
)

// FileInfo définit la structure d'un fichier pour l'UI
type FileInfo struct {
    Name  string `json:"name"`
    Size  int64  `json:"size"`
    IsDir bool   `json:"is_dir"`
    Date  string `json:"date"`
}

// ListFiles retourne la liste des fichiers et dossiers dans un chemin donné
func ListFiles(path string) ([]FileInfo, error) {
    entries, err := os.ReadDir(path)
    if err != nil {
        return nil, err
    }

    var files []FileInfo
    for _, entry := range entries {
        info, _ := entry.Info()
        files = append(files, FileInfo{
            Name:  entry.Name(),
            Size:  info.Size(),
            IsDir: entry.IsDir(),
            Date:  info.ModTime().Format("2006-01-02 15:04"),
        })
    }
    return files, nil
}

// ReadFileContent lit le contenu d'un fichier (pour l'éditeur)
func ReadFileContent(username, filename string) (string, error) {
    path := filepath.Join("/var/www/wcp360/data/www", username, filename)
    content, err := os.ReadFile(path)
    return string(content), err
}

// SaveFileContent écrit le contenu dans un fichier
func SaveFileContent(username, filename, content string) error {
    path := filepath.Join("/var/www/wcp360/data/www", username, filename)
    return os.WriteFile(path, []byte(content), 0644)
}
