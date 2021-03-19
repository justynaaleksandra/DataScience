--Usunięcie bazy, gdyby już taka istniała oraz stworzenie nowej
DROP DATABASE IF EXISTS Sklep_odzieżowy;
CREATE DATABASE Sklep_odzieżowy;
USE Sklep_odzieżowy; --zostawiam USE, natomiast w Xampie nie działa, trzeba wybrać ręcznie

--Struktura tabel
CREATE TABLE `Dostawca` (
  `Id_producenta` INT PRIMARY KEY AUTO_INCREMENT,
  `Nazwa_producenta` VARCHAR(255) UNIQUE NOT NULL,
  `Adres_producenta` VARCHAR(255) DEFAULT 'Brak adresu',
  `NIP_producenta` VARCHAR(15) UNIQUE NOT NULL,
  `Data_podpisania_umowy_z_producentem` DATE DEFAULT NULL
);

CREATE TABLE `Produkt` (
  `Id_produktu` INT PRIMARY KEY AUTO_INCREMENT,
  `Id_producenta` INT NOT NULL,
  `Nazwa_produktu` VARCHAR(255) NOT NULL,
  `Opis_produktu` VARCHAR(500) DEFAULT 'Brak opisu',
  `Cena_netto_zakupu` DECIMAL(10,2) NOT NULL,
  `Cena_brutto_zakupu` DECIMAL(10,2) NOT NULL,
  `Cena_netto_sprzedaży` DECIMAL(10,2) NOT NULL,
  `Cena_brutto_sprzedaży` DECIMAL(10,2) NOT NULL,
  `Procent_VAT_sprzedaży` DECIMAL(2,0) NOT NULL
);

CREATE TABLE `Zamówienie` (
  `Id_zamówienia` INT PRIMARY KEY AUTO_INCREMENT,
  `Id_klienta` INT NOT NULL,
  `Id_produktu` INT NOT NULL,
  `Data_zamówienia` DATE DEFAULT NULL
);

CREATE TABLE `Klient` (
  `Id_klienta` INT PRIMARY KEY AUTO_INCREMENT,
  `Imię` VARCHAR(255) NOT NULL,
  `Nazwisko` VARCHAR(255) NOT NULL,
  `Adres` VARCHAR(255) NOT NULL
);

--teraz należy wgrać dane z pliku Sklep_odzieżowy_dane
--a następnie dodać ograniczenia

--Ograniczenia, klucze obce i indeksy
ALTER TABLE `Produkt` ADD FOREIGN KEY (`Id_producenta`) REFERENCES `Dostawca` (`Id_producenta`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `Zamówienie` ADD FOREIGN KEY (`Id_produktu`) REFERENCES `Produkt` (`Id_produktu`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `Zamówienie` ADD FOREIGN KEY (`Id_klienta`) REFERENCES `Klient` (`Id_klienta`) ON UPDATE CASCADE ON DELETE CASCADE;
-- ALTER TABLE `Dostawca` ADD CONSTRAINT (`SprawdzNIP`) CHECK (Sklep_odzieżowy.SprawdzNIP(NIP_producenta) = 1);

-- chciałam dodać tu CHECK ale w xampie nie działało, chyba to jakiś problem z MAriaDB i wpieraniem Checka ale zostawiam tu,
--bo już napisałam tę funkcję do walidacji NIP, może na innej wersji zadziała?
