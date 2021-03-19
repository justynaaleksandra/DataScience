--8.Wyświetl wszystkie produkty z wszystkimi danymi od dostawcy, który znajduje się na pozycji 1 w tabeli „Dostawca”.
--9.Posortuj te produkty po Nazwie od A-B
SELECT * FROM Produkt p
JOIN Dostawca d
ON p.Id_producenta=d.Id_producenta
WHERE d.Id_producenta =1
ORDER BY Nazwa_produktu;

--10. Wylicz średnią cenę za produktu od tego dostawcy *podaję wszystkie średnie ceny
SELECT d.Id_producenta,d.Nazwa_producenta, ROUND(AVG(p.Cena_netto_zakupu),2) AS Średnia_cena_netto_zakupu,
ROUND(AVG(p.Cena_brutto_zakupu),2) AS Średnia_cena_brutto_zakupu,
ROUND(AVG(p.Cena_netto_sprzedaży),2) AS Średnia_cena_netto_sprzedaży,
ROUND(AVG(p.Cena_brutto_sprzedaży),2) AS Średnia_cena_netto_sprzedaży
FROM Produkt p
JOIN Dostawca d
ON p.Id_producenta=d.Id_producenta
WHERE d.Id_producenta =1;

--11. Oceniam jako Tanie/Drogie po cenie netto zakupu, ponieważ inne są pochodnymi tej ceny
--Próbowałam różnych rozwiązań, w końcu zdecydowałam się na policzenie mediany i uzależnienie etykiety od ceny (najpierw chciałam
-- prościej - tylko na podstawie liczby pozycji/2, ale nie chciało mi przejść dodanie Pozycji do warunku WHERE, ostatecznie z medianą udało się dobrze)

--widok produktow od dostawcy1
CREATE VIEW dostawca1
AS SELECT DISTINCT d.Id_producenta, d.Nazwa_producenta, p.Nazwa_produktu,
p.Cena_netto_zakupu FROM Produkt p
JOIN Dostawca d
ON p.Id_producenta=d.Id_producenta
WHERE d.Id_producenta =1
ORDER BY `Cena_netto_zakupu`;

--policzenie mediany
SELECT
  @pozycja := COUNT(*) + 1
FROM
  dostawca1;
WITH temp as (
  SELECT
    Cena_netto_zakupu,
    ROW_NUMBER() OVER (ORDER BY `Cena_netto_zakupu`) AS Pozycja
  FROM
    dostawca1
)

SELECT
  @mediana := ROUND(AVG(Cena_netto_zakupu),2) AS mediana_ceny
FROM
  temp
WHERE
  temp.Pozycja IN (FLOOR(@pozycja / 2) , CEIL(@pozycja / 2));


(SELECT *, 'Tanie' AS `Klasa produktu`
FROM dostawca1
WHERE Cena_netto_zakupu <= @mediana
UNION
SELECT *, 'Drogie' AS `Klasa produktu`
FROM dostawca1
WHERE Cena_netto_zakupu > @mediana)
ORDER BY `Cena_netto_zakupu`;

--12.
SELECT DISTINCT p.Nazwa_produktu FROM Produkt p
RIGHT JOIN Zamówienie z
ON p.Id_produktu=z.Id_produktu;
--13.
SELECT DISTINCT p.Nazwa_produktu FROM Produkt p
RIGHT JOIN Zamówienie z
ON p.Id_produktu=z.Id_produktu
LIMIT 5;
--14.
SELECT SUM(p.Cena_brutto_sprzedaży) AS `Suma wszystkich zamówień` FROM Produkt p
RIGHT JOIN Zamówienie z
ON p.Id_produktu=z.Id_produktu;
--15.
SELECT z.Id_zamówienia, z.data_zamówienia, p.Nazwa_produktu FROM Produkt p
RIGHT JOIN Zamówienie z
ON p.Id_produktu=z.Id_produktu
ORDER BY `data_zamówienia` DESC;
--16.
SELECT * FROM Produkt
  WHERE
  (Id_produktu OR
  Id_producenta OR
  Nazwa_produktu OR
  Opis_produktu OR
  Cena_netto_zakupu OR
  Cena_brutto_zakupu OR
  Cena_netto_sprzedaży OR
  Cena_brutto_sprzedaży OR
  Procent_VAT_sprzedaży) IS NULL OR
  (Id_produktu OR
  Id_producenta OR
  Nazwa_produktu OR
  Opis_produktu OR
  Cena_netto_zakupu OR
  Cena_brutto_zakupu OR
  Cena_netto_sprzedaży OR
  Cena_brutto_sprzedaży OR
  Procent_VAT_sprzedaży) = ' ';

  --17.
  SELECT COUNT(*) AS `ilość zamówień`, p.Nazwa_produktu, p.Cena_brutto_sprzedaży FROM Produkt p
  RIGHT JOIN Zamówienie z
  ON p.Id_produktu=z.Id_produktu
  GROUP BY Nazwa_produktu
  ORDER BY `ilość zamówień` DESC, `Nazwa_produktu`
  LIMIT 10;
--wyświetlam 10 bestsellerów

--18.
SELECT data_zamówienia, COUNT(*) AS `największa ilość zamówień` FROM Zamówienie
GROUP BY `data_zamówienia`
ORDER BY `największa ilość zamówień` DESC, `data_zamówienia` DESC
LIMIT 1;
