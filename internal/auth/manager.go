package auth

import (
	"github.com/golang-jwt/jwt/v5"
	"time"
)

// JwtCustomClaims définit les données stockées dans le token
type JwtCustomClaims struct {
	Username string `json:"name"`
	Role     string `json:"role"` // "root" ou "user"
	jwt.RegisteredClaims
}

func GenerateToken(username string, role string) (string, error) {
	claims := &JwtCustomClaims{
		username,
		role,
		jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Hour * 72)),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte("secret-tres-sur")) // À mettre en config plus tard
}
