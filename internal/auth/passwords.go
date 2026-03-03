package auth

import "golang.org/x/crypto/bcrypt"

// HashPassword transforme le texte clair en hash illisible
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

// CheckPassword vérifie si le mot de passe correspond au hash
func CheckPassword(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
