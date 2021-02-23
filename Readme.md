# YOURLS 1.8 with SQLITE

Currently with a self-built YOURLS:1.8-apache, because 1.8 is too new as of writing.

Based on [Flameborn/yourls-sqlite](https://github.com/Flameborn/yourls-sqlite) plus some docker-entrypoint.sh changes (docker-entrypoint creates a DB "just in case" - had to change that).

Takes the same arguments as the [official container](https://hub.docker.com/_/yourls), but ignores the ones that are unnecessary.

MIT-Licensed.
