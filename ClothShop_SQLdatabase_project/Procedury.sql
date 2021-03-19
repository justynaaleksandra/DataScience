--Dodawanie Klienta
DROP PROCEDURE IF EXISTS dodaj_klienta;
DELIMITER $$
CREATE PROCEDURE dodaj_klienta(IN `@Imię` VARCHAR(255), `@Nazwisko` VARCHAR(255), `@Adres` VARCHAR(255))
  BEGIN
  INSERT INTO Klient(Imię, Nazwisko, Adres)
  VALUES (`@Imię`, `@Nazwisko`, `@Adres`);
END $$
DELIMITER ;
--wywołanie i test
CALL dodaj_klienta ('Jan', 'Kowalski', 'Wrzosowa 7 Warszawa');
SELECT * FROM Klient; --klient dodany

--Usuwanie klienta o podanym id
DROP PROCEDURE IF EXISTS usun_klienta;
DELIMITER $$
CREATE PROCEDURE usun_klienta(IN `@Id_klienta` INT)
  BEGIN
  DELETE FROM Klient WHERE Id_klienta = `@Id_klienta`;
END $$
DELIMITER ;
--wywołanie i test
CALL usun_klienta (31);
SELECT * FROM Klient;
