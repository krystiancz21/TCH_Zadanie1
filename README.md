# TCH_Zadanie1 - Sprawozdanie - Część obowiązkowa

Przebieg zadania:
1. Budowanie opracowanego obrazu (screen: Z1ss1.png):
    ```
    docker build -f Dockerfile -t zadanie1img .
    ```

2. Uruchomienie kontenera na podstawie wcześniej zbudowanego obrazu (screen: Z1ss2.png):
    ```
    docker run -d --name zadanie1 -p 3000:3000 zadanie1img
    ```

3. Uzyskanie informacji, które serwer wygenerował w trakcie uruchomienia kontenera (screen: Z1ss3.png):
    ```
    docker logs -f zadanie1
    ```

4. Sprawdzenie ile warstw posiada zbudowany obraz (screen: Z1ss4.png)
    ```
    docker inspect zadanie1img | jq '.[].RootFS'
    ```

5. Zrzut ekranu okna przeglądarki potwierdzający poprawnie działanie serwera w kontenerze (screen: Z1ss5.png):
    * Sprawdzenie poprawnego działania serwera w terminalu:
        ```
        curl -f http://localhost:3000/
        ```

6. Konkurs na obraz o najmniejszym rozmiarze (screen: Z1ss6.png):
    * Spradzenie rozmiaru obrazu:
        ```
        docker images | grep zadanie1img
        ```

    * Sprawdzenie obrazu pod względem występujących podatności za pomocą narzędzia Docker Scout:
        ```
        docker scout cves zadanie1img
        ```
