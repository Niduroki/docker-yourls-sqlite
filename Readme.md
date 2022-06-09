# YOURLS 1.9 with SQLite

Based on [Flameborn/yourls-sqlite](https://github.com/Flameborn/yourls-sqlite).

Takes the same arguments as the [official container](https://hub.docker.com/_/yourls), but ignores the ones that are unnecessary.  
Additionally there is a `/var/www/html/user/sqlite` volume, you should either bind to the local fs, or at least name.

## Important notice / change (2022-02-01)

The `YOURLS_DB_NAME` **must** be defined, and **must** be prepended with a `sqlite/` (due to simplifying and removing the custom `docker-entrypoint.sh`), otherwise the database is **not** written into the persistent volume, and data will be **lost** on restarting the container!

If you have updated this container, and your data seems to be lost: No worries, it's still there!  
Prepend `sqlite/` to your existing `YOURLS_DB_NAME`, or, if you have not defined a custom `YOURLS_DB_NAME` define it as `YOURLS_DB_NAME=sqlite/yourls`.

## Example command-line

```
docker run --name yourls-but-sqlite \
    -e YOURLS_SITE="https://exam.pl" \
    -e YOURLS_DB_NAME="sqlite/yourls" \
    -e YOURLS_USER="myuser" \
    -e YOURLS_PASS="secretpassword" \
    -v yourls-sqlite:/var/www/html/user/sqlite \
    -p 80:80 -d niduroki/yourls-sqlite:1.9
```

---

MIT-Licensed.
