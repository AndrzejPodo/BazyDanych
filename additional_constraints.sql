-- Konferencje
alter table Konferencje
    add constraint Znizka_studencka_miedzy_0_i_1
        check (znizka_studencka <= 1 and znizka_studencka >= 0)
go

-- Warsztaty
alter table Warsztaty
    add constraint Poczatek_przed_koncem
        check (poczatek < koniec)
go

alter table Warsztaty
    add constraint Cena_warsztatu_nieujemna
        check (cena >= 0)
go

alter table Warsztaty
    add constraint miejsca_nieujemne
        check (miejsca >= 0)
go

--Dni konferencji
alter table Dni_konferencji
    add constraint Miejsca_dnia_nieujemne
        check (miejsca >= 0)

--Ceny
alter table Ceny
    add constraint Cena_dnia_nieujemna
        check (cena >= 0)
go

--Rezerwacje dnia
alter table Rezerwacje_dnia
    add constraint Miejsca_na_dzien_nieujemne
        check (miejsca >= 0)
go

alter table Rezerwacje_dnia
    add constraint Miejsca_studenckie_na_dzien_nieujemne
        check (miejsca_studentow >= 0)
go

--Platonosci
alter table Platnosci
    add constraint Wartosc_nieujemna
        check (wartosc >= 0)
go

--Rezerwacje warsztatu
alter table Rezerwacje_warsztatu
    add constraint Miejsca_warsztatu_nieujemne
        check (miejsca >= 0)
go



