if [ -z "$DOMAIN" ]; then
  echo "No domain provided. Skipping SSL."
  exit 0
fi

certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m admin@$DOMAIN || true
