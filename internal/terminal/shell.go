package terminal

import (
	"os/exec"
	"github.com/gorilla/websocket"
	"net/http"
	"io"
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

// HandleTerminal gère la connexion WebSocket pour le shell
func HandleTerminal(w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		return
	}
	defer conn.Close()

	// On lance un shell interactif (sh ou bash)
	cmd := exec.Command("bash")
	
	stdin, _ := cmd.StdinPipe()
	stdout, _ := cmd.StdoutPipe()

	go func() {
		io.Copy(stdin, &wsWriter{conn})
	}()

	cmd.Start()
	
	buf := make([]byte, 1024)
	for {
		n, err := stdout.Read(buf)
		if err != nil {
			break
		}
		conn.WriteMessage(websocket.TextMessage, buf[:n])
	}
}

type wsWriter struct {
	conn *websocket.Conn
}

func (w *wsWriter) Write(p []byte) (n int, err error) {
	_, message, err := w.conn.ReadMessage()
	return copy(p, message), err
}
