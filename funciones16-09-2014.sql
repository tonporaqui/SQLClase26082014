create database funciones

use funciones

create table producto(
	CodProducto int primary key,
	nombreproducto varchar(50),
	precio float
)

insert into producto values(1,'articulo 1',100)
insert into producto values(2,'articulo 2',200)

create table ventaslv(
	CodProducto int,
	Fecha datetime,
	Valorventa float
)

select * from producto

create function CalculaIVA(@cantidad money)
returns money
as
begin
	declare @resultado money 
	set     @resultado = @cantidad + (@cantidad * 0.19)
	return (@resultado)
end

select dbo.CalculaIVA(500)
