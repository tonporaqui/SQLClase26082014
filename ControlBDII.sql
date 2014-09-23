create database DBControl

use DBControl

CREATE TABLE TBL_VIDEOJUEGOS(

CODVIDEO TINYINT PRIMARY KEY,

NOMBRE VARCHAR(60) NOT NULL,

VALORARRIENDO NUMERIC) /* valor total (NO valor diario)*/

INSERT INTO TBL_VIDEOJUEGOS VALUES (1,'PSP3',1000)

INSERT INTO TBL_VIDEOJUEGOS VALUES (2,'PSP4',1500)

INSERT INTO TBL_VIDEOJUEGOS VALUES (3,'X-BOX',1800)

CREATE TABLE TBL_DEVOLUCIONES(

RUT NUMERIC(10),

CODVIDEO TINYINT REFERENCES TBL_VIDEOJUEGOS (CODVIDEO),

FECHAPRESTAMO DATE NOT NULL,

FECHAENTREGA DATE NOT NULL,

FECHADEVOLUCION DATE NOT NULL,

CONSTRAINT PK_DEVOL PRIMARY KEY (RUT,CODVIDEO,FECHAPRESTAMO)

)

INSERT INTO TBL_DEVOLUCIONES VALUES('1',1,'20140915','20140917','20140917')

INSERT INTO TBL_DEVOLUCIONES VALUES('1',1,'20140919','20140921','')

INSERT INTO TBL_DEVOLUCIONES VALUES('2',2,'20140911','20140914','20140917')

INSERT INTO TBL_DEVOLUCIONES VALUES('3',3,'20140811','20140812','20140812')

INSERT INTO TBL_DEVOLUCIONES VALUES('3',3,'20140914','20140916','')


create function Fn_CalcularSobreCargo
(
	@codigo int,
	@fecha_devolucion date,
	@fecha_entrega date
)
returns int
as 
begin
	declare @valor_dev int
	declare @valor_arriendo int
	select @valor_arriendo = valorarriendo from TBL_VIDEOJUEGOS where codvideo = @codigo
	if @fecha_devolucion > @fecha_entrega
	begin
		if @codigo = 1 or @codigo = 3
		begin
			set @valor_dev = @valor_arriendo * 0.02
		end
		else if @codigo = 2
		begin
			set @valor_dev = @valor_arriendo * 0.03
		end
	else 
		set @valor_dev = @valor_arriendo	
	end	 
	return @valor_dev
end


create procedure sp_Actualiza 
(
	@rut int,
	@codigo int,
	@fecha_devolucion date
)
as 
begin
	update tbl_devoluciones set fechadevolucion = @fecha_devolucion
	where rut = @rut and codvideo = @codigo and fechadevolucion = ''
	
	select d.rut, v.nombre, v.valorarriendo, dbo.Fn_CalcularSobreCargo(@codigo,@fecha_devolucion,d.fechaentrega) as valor
	from tbl_devoluciones d
	inner join tbl_videojuegos v
	on d.codvideo = v.codvideo
	where d.rut = @rut
	and d.codvideo = @codigo
end

exec sp_Actualiza 1,1,'2014-09-23'

select dbo.Fn_CalcularSobreCargo(2,'2014-09-12','2014-08-12')

select * from tbl_devoluciones
select * from tbl_videojuegos