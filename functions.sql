create function Dni_konferencji_wolne_miejsca (
    @id_konferencji int,
    @dzien date
) returns int as begin
    declare @id_dnia int
    declare @miejsca int

    set @id_dnia = (select id from Dni_konferencji where id_konferencji = @id_konferencji and dzien = @dzien)
    set @miejsca = (select miejsca from Dni_konferencji where id = @id_dnia)

    return @miejsca - (select sum(miejsca + miejsca_studentow) from Rezerwacje_dnia where id_dnia = @id_dnia)
end
go

create function Cena_dnia (@id_dnia int, @dzien_rezerwacji date) 
returns decimal(19, 4) as begin
   return (select top 1 cena from Ceny where id_dnia_konferencji = @id_dnia and od_dnia <= @dzien_rezerwacji order by od_dnia desc)
end
go

create function Znizka_studencka (@id_konferencji int)
returns decimal(19, 4) as begin
    return (select top 1 (1 - znizka_studencka) from Konferencje where id = @id_konferencji)
end
go

create function Cena_rezerwacji_warsztatu (@id_rezerwacji_warsztatu int)
returns decimal(19, 4) as begin
    return ( select top 1 cena * A.miejsca
        from Warsztaty inner join (select id_warsztatu, miejsca from Rezerwacje_warsztatu where id = @id_rezerwacji_warsztatu)  as A
        on Warsztaty.id = id_warsztatu )
end
go

create function Cena_rezerwacji_dnia (@id_rezerwacji_dnia int)
returns decimal(19, 4) as begin
    declare @data_rezerwacji date
    set @data_rezerwacji = (select top 1 data_rezerwacji from Rezerwacje_dnia
    inner join Rezerwacje_konferencji Rk on Rezerwacje_dnia.id_rezerwacji_konferencji = Rk.id
    where Rezerwacje_dnia.id = @id_rezerwacji_dnia)

    declare @cena_warsztatow decimal(19, 4)
    set @cena_warsztatow = (select sum(dbo.Cena_rezerwacji_warsztatu(id)) from Rezerwacje_warsztatu where id_rezerwacji_dnia = @id_rezerwacji_dnia)

    declare @cena_miejsca decimal(19, 4)
    set @cena_miejsca = (select top 1 dbo.Cena_dnia(id_dnia, @data_rezerwacji) from Rezerwacje_dnia where id = @id_rezerwacji_dnia)

    declare @znizka_studencka decimal(19, 4)
    set @znizka_studencka = (select top 1 dbo.Znizka_studencka(id_konferencji)
    from Rezerwacje_dnia inner join Rezerwacje_konferencji k on Rezerwacje_dnia.id_rezerwacji_konferencji = k.id
    where Rezerwacje_dnia.id = @id_rezerwacji_dnia)

    return @cena_warsztatow + (select top 1 (miejsca_studentow * @znizka_studencka + miejsca) from Rezerwacje_dnia where id = @id_rezerwacji_dnia) * @cena_miejsca
end
go


create function Cena_rezerwacji_konferencji (@id_rezerwacji_konferencji int)
returns decimal(19, 4) as begin 
    return (select sum(dbo.Cena_rezerwacji_dnia(id)) from Rezerwacje_dnia where id_rezerwacji_konferencji = @id_rezerwacji_konferencji)
end
go

