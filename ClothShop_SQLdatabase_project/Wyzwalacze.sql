--Triger1. (niestety u mnie nie daje pożądanego efektu): Jeśli klient nie poda adresu, to uzupełnij pole przypomnieniem, że nalezy go o niego poprosić przy najbliższym kontakcie
DROP TRIGGER IF EXISTS t_klient_insert;
DELIMITER $$
CREATE TRIGGER t_klient_insert AFTER INSERT ON `Dostawca`
FOR EACH ROW
BEGIN
	DECLARE `@Imię` VARCHAR(255);
	DECLARE `@Nazwisko` VARCHAR(255);
	DECLARE `@Adres` VARCHAR(255);
    SELECT Imię, Nazwisko, Adres
    INTO `@Imię`, `@Nazwisko`, `@Adres`
    FROM INSERTED;
    IF (`@Adres` IS NULL OR `@Adres` = '') THEN SET `@Adres` = 'KONTAKT!';
    INSERT INTO Klient (Imię, Nazwisko, Adres)
    VALUES (`@Imię`, `@Nazwisko`, `@Adres`);
    END IF;
END$$
DELIMITER ;
--test (najpierw trzeba wczytać procedury)
CALL dodaj_klienta ('Jan', 'Kowalski', '');
SELECT * FROM Klient;
--Fail: dodaje jednak pustego stringa ;(

--Triger2.(niestety u mnie nie daje pożądanego efektu): Jeżeli wprowadzana nazwa producenta już istnieje w bazie
--to dopisz do nazwy kolejne 'z id ...' , "omija" ograniczenie UNIQUE
DROP TRIGGER IF EXISTS t_dostawca_insert;
DELIMITER $$
CREATE TRIGGER t_dostawca_insert AFTER INSERT ON `Dostawca`
FOR EACH ROW
BEGIN
SET @Nazwa_producenta = New.Nazwa_producenta;
SET @Adres_producenta = New.Adres_producenta;
SET @NIP_producenta = New.NIP_producenta;
SET @Data_podpisania_umowy_z_producentem = New.Data_podpisania_umowy_z_producentem;
    SELECT Nazwa_producenta, Adres_producenta, NIP_producenta, Data_podpisania_umowy_z_producentem
    INTO @Nazwa_producenta, @Adres_producenta, @NIP_producenta, @Data_podpisania_umowy_z_producentem
    FROM INSERTED;
    IF @Nazwa_producenta = (SELECT Nazwa_producenta FROM Dostawca) THEN SET @Nazwa_producenta = CONCAT(Nazwa_producenta , 'z id ', Id_producenta);
    INSERT INTO Dostawca (Nazwa_producenta, Adres_producenta, NIP_producenta, Data_podpisania_umowy_z_producentem)
    VALUES (@Nazwa_producenta, @Adres_producenta, @NIP_producenta, @Data_podpisania_umowy_z_producentem);
    END IF;
END$$
DELIMITER ;

--test
insert into Dostawca (Nazwa_producenta, Adres_producenta, NIP_producenta, Data_podpisania_umowy_z_producentem)
  values ('Centizu', '2583 International Center', '9930398610', '2018-11-22');
--fail:#1062 - Powtórzone wystąpienie 'Centizu' dla klucza 'Nazwa_producenta' - niestety nie działa, ale zostawiam to tu
--jako znak, że próbowałam :P
