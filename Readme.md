# YOURLS 1.8 with SQLite

Based on [Flameborn/yourls-sqlite](https://github.com/Flameborn/yourls-sqlite) plus some docker-entrypoint.sh changes (docker-entrypoint creates a DB "just in case" - had to change that).

Takes the same arguments as the [official container](https://hub.docker.com/_/yourls), but ignores the ones that are unnecessary.  
Additionally there is a `/var/www/html/user/sqlite` volume, you should either bind to the local fs, or at least name.

The `YOURLS_DB_NAME` environment variable will be prepended with a `sqlite/` (avoiding double `sqlite/sqlite/` though) in order to write into the sqlite-volume.

## Example command-line

```
docker run --name yourls-but-sqlite \
    -e YOURLS_SITE="https://exam.pl" \
    -e YOURLS_DB_NAME="yourls" \
    -e YOURLS_USER="myuser" \
    -e YOURLS_PASS="secretpassword" \
    -v yourls-sqlite:/var/www/html/user/sqlite \
    -p 80:80 -d niduroki/yourls-sqlite:1.8
```

---

MIT-Licensed.
