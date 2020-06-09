FROM dpage/pgadmin4:latest
COPY --chown=pgadmin:pgadmin servers.json passfile /pgadmin4/
RUN chmod 0600 /pgadmin4/passfile
