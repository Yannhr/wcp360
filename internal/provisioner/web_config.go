package provisioner

import (
    "fmt"
    "os"
)

// GenerateCaddyConfig génère une configuration pour Caddy pointant vers le home de l'utilisateur
func GenerateCaddyConfig(domain, username string) error {
    config := fmt.Sprintf(`
%s {
    root * /home/%s/public_html
    php_fastcgi unix//run/php/php-fpm.sock
    file_server
    log {
        output file /home/%s/logs/access.log
    }
}`, domain, username, username)

    path := fmt.Sprintf("/etc/caddy/vhosts/%s.caddy", domain)
    return os.WriteFile(path, []byte(config), 0644)
}
