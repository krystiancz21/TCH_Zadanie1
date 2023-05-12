# Zadanie 1 - Sprawozdanie - Część dodatkowa

Przebieg zadania:

1. Stworzenie nowego buildera:
    ```
    docker buildx create --name newbuilder
    ```

2. Ustawienie nowego buildera jako domyślny:
    ```
    docker buildx use newbuilder
    ```

3. Sprawdzenie konfiguracji Buildx: 
    ```
    docker buildx inspect --bootstrap
    ```

4. Ustawienie wirtualnego środowiska wykonawczego dla platform, które nie odpowiadają bieżącej architekturze procesora:Ustawienie wirtualnego środowiska wykonawczego dla platform, które nie odpowiadają bieżącej architekturze procesora:
    ```
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    ```

5. Budowanie obrazu dla architektur -  linux/arm/v7, linux/arm64/v8, linux/amd64 (screen: D1ss1.png):
    ```
    docker buildx build -t docker.io/s95382/z1dod:zad1 --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --push .
    ```

6. Repozytorium DockerHub z obrazem:
    * https://hub.docker.com/r/s95382/z1dod/tags

7. Pobranie obrazu z repozytorium (screen: D1ss2.png):
    ```
    docker pull s95382/z1dod:zad1
    ```

8. Uruchomienie kontenera na podstawie pobranego obrazu (screen: D1ss2.png):
    ```
    docker run -d --name zadanie1dod -p 3000:3000 s95382/z1dod:zad1
    ```

9. Sprawdzenie działania kontenera (screen: D1ss2.png):
    ```
    docker ps
    ```

10. Wyświetlenie zawartości serwera (screen: D1ss2.png):
    ```
    curl localhost:3000
    ```
    