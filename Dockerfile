# STAGE_1
FROM scratch as stage_one

# dodanie obrazu Alpine 
ADD alpine-minirootfs-3.18.0-x86_64.tar /

# uaktualnienie systemu i instalacja niezbędnych konponentów środowiska roboczego
RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs=18.16.0-r1 \
    npm=9.6.6-r0 && \
    rm -rf /etc/apk/cache

# dodanie grupy i użytkownika "node"
RUN addgroup -S node && \
    adduser -S node -G node

# ustawienie domyślnego użytkownika "node" w kontenerze
USER node

# ustawienie katalogu roboczego
WORKDIR /home/node/app

# kopiowanie plików do kontenera 
COPY --chown=node:node package*.json ./
COPY --chown=node:node server.js ./

# instalacja zależności zdefiniowanych w pliku package.json
RUN npm install 


# STAGE_2
FROM node:20.1.0-alpine3.16

# dodanie etykiety autora
LABEL org.opencontainers.image.authors="Krystian Czapla"

# instalacja narzędzia "curl"
RUN apk add --update --no-cache curl=8.0.1-r0

# ustawienie domyślnego użytkownika
USER node

# ustawienie katalogu roboczego
WORKDIR /home/node/app

# kopiowanie plików z pierwszego etapu budowania 
COPY --from=stage_one /home/node/app .

# deklaracja portu aplikacji w kontenerze 
EXPOSE 3000

# monitorowanie dostepnosci serwera
HEALTHCHECK --interval=10s --timeout=1s \
 CMD curl -f http://localhost:3000/ || exit 1

# deklaracja sposobu uruchomienia
CMD ["npm", "start"]