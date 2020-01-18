create view Uczestnicy_dni_konferencji as
  select id_osoby, imie, nazwisko, czy_student, id_dnia 
  from Dni_konferencji
    inner join Rezerwacje_dnia Rd on Dni_konferencji.id = Rd.id_dnia
    inner join Zapisy_dnia Zd on Rd.id = Zd.id_rezerwacji_dnia
    inner join Osoby O on Zd.id_osoby = O.id
go

create view Uczestnicy_warsztatow as
  select id_osoby, imie, nazwisko, czy_student, id_warsztatu 
  from Warsztaty
    inner join Rezerwacje_warsztatu Rw on Warsztaty.id = Rw.id_warsztatu
    inner join Zapisy_warsztatu Zw on Rw.id = Zw.id_rezerwacji_warsztatu
    inner join Zapisy_dnia Zd on Zw.id_zapisu_dnia = Zd.id
    inner join Osoby O on Zd.id_osoby = O.id
go

create view Uczestnicy_konferencji as
  select distinct id_osoby, imie, nazwisko, id_konferencji
  from Konferencje
    inner join Dni_konferencji Dk on Konferencje.id = Dk.id_konferencji
    inner join Uczestnicy_dni_konferencji on id_dnia = Dk.id
go

create view Wplaty_rezerwacje as
  select id_klienta, id_rezerwacji, dbo.Cena_rezerwacji_konferencji(id_rezerwacji) - sum(wartosc) as [Saldo]
    from Rezerwacje_konferencji
    inner join Platnosci P on Rezerwacje_konferencji.id = P.id_rezerwacji
  group by id_klienta, id_rezerwacji
go

create view Kontakty_klienci as
  select Klienci.id, nazwa, telefon, email 
  from Klienci
    inner join Firmy F on Klienci.id_firmy = F.id
  union all
  select Klienci.id, imie + ' ' + nazwisko, telefon, email 
    from Klienci
      inner join Osoby O on Klienci.id_osoby = O.id
go

create view Nieoplacone_rezerwacje as
  select K.nazwa as klient, telefon, email, datediff(day, data_rezerwacji, getdate()) as Zalega_dni, Saldo, K2.nazwa as konferencja, id_rezerwacji
    from Rezerwacje_konferencji Rk
      inner join Wplaty_rezerwacje Wr on Rk.id_klienta = Wr.id_klienta and Wr.id_rezerwacji = Rk.id
      inner join Kontakty_klienci K on K.id = Wr.id_klienta
      inner join Konferencje K2 on Rk.id_konferencji = K2.id
    where datediff(day, data_rezerwacji, getdate()) >= 7 and Saldo > 0 and anulowano = 0
go

create view Stali_klienci as
  select nazwa, telefon, email, dokonane_rezerwacje, laczna_kwota_rezerwacji, id_klienta 
    from Kontakty_klienci
      inner join
      (select id_klienta, count(*) as dokonane_rezerwacje, sum(dbo.Cena_rezerwacji_konferencji(Rk.id)) as laczna_kwota_rezerwacji
        from Klienci
          inner join Rezerwacje_konferencji Rk on Klienci.id = Rk.id_klienta and anulowano = 0
    group by id_klienta) S on S.id_klienta = id
go
