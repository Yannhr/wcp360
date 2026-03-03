package system

import (
    "os/exec"
    "fmt"
)

// CreateHostingUser crée un utilisateur Linux isolé pour un nouveau client
func CreateHostingUser(username string) error {
    // 1. Créer le groupe et l'utilisateur avec un home spécifique
    // On désactive le shell pour éviter les connexions SSH non désirées
    cmd := exec.Command("useradd", "-m", "-d", "/home/"+username, "-s", "/usr/sbin/nologin", username)
    if err := cmd.Run(); err != nil {
        return fmt.Errorf("erreur creation utilisateur: %v", err)
    }

    // 2. Créer l'arborescence standard (Skeleton)
    dirs := []string{"public_html", "logs", "backups", ".ssh"}
    for _, dir := range dirs {
        path := fmt.Sprintf("/home/%s/%s", username, dir)
        exec.Command("mkdir", "-p", path).Run()
        // Donner la propriété à l'utilisateur
        exec.Command("chown", "-R", username+":"+username, path).Run()
    }

    return nil
}
