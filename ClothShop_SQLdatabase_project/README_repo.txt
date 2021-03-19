PROJEKT Sklep_odzieżowy

Podstawowy zakres projektu realizują pliki:
- Sklep_odzieżowy.sql,
- Sklep_odzieżowy_dane.sql,
- Zadania_z_projektu.sql.

1. Najpierw należy utworzyć bazę i tabele poprzez polecenia z pliku Sklep_odzieżowy.sql.
2. Następnie wczytać dane z pliku Sklep_odzieżowy_dane.sql.
3. Następnie wrócić do pliku Sklep_odzieżowy.sql, i dodać ograniczenia i klucze obce.
4. Wtedy można zrealizować polecenia zawarte w projekcie poprzez kolejne kwerendy z pliku  Zadania_z_projektu.sql.
Komentarze co do poszczególnych poleceń są na bieżąco w pliku.

UWAGI
- Dane wygenerowałam trochę więcej niż w założeniach, korzystając z Macaroo i potem dostosowałam do kontekstu naszego projektu. 

DODATKI
Projekt zawiera też dodatkowe pliki rozszerzające jego zakres:
- Funkcja_Walidacja NIP.sql
- Procedury.sql
- Wyzwalacze.sql

UWAGI do dodatkowych plików:
- Powalczyłam z funkcją walidującą NIP - XAMPP jej składnię przyjmuje bez błędów i sprawdza numery, natomiast nie mogłam do końca potestować z bazą,
bo XAMPP nie przyjmuje mi składni dodania CHECK - nie wiem dlaczego... Dlatego wykomentowałam dodanie tego ograniczenia w pliku,
ale nadal przesyłam tą funkcję, bo może na innej wersji jakoś zadziała (gdzieś czytałam, że niektóre wersje MariaDB nie wspierały dodawania CHECKów,
aczkolwiek ja mam 10.4 , więc to powinno już być)
-Procedury działają dobrze - dodałam takie na łatwe dodawanie i usuwanie klienta do bazy. Przy testach nie podaje Id_klienta, bo samo się inkrementuje.
-Jeśli chodzi o Wyzwalacze - z nimi też trochę problem, bo obydwa które napisałam przechodzą składniowo bez błędów,
natomiast przy testach - nie robią tego co miały. Może coś wynika ze specyfiki MySQL, że trzeba by inaczej napisać IF, aby dobrze sprawdzał warunek.
Pewnie w pracy nie należałoby wysyłać kodu, który nie robi tego co ma robić, ale ponieważ to projekt szkoleniowy, to zdecydowałam się jednak załączyć ten plik.
