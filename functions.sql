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

