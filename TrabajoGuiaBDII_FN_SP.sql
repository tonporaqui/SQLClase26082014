create database trabajodb

use trabajodb

CREATE TABLE TBL_NIVEL(

CODNIVEL TINYINT PRIMARY KEY,

NOMBRE VARCHAR(60) NOT NULL,

EDAD TINYINT)

CREATE TABLE TBL_PREMATRICULA(

RUT NUMERIC(10) PRIMARY KEY,

CODNIVEL TINYINT REFERENCES TBL_NIVEL (CODNIVEL),

NOMBRE VARCHAR(60) NOT NULL,

APEPAT VARCHAR(60) NOT NULL,

APEMAT VARCHAR(60) NOT NULL,

FECNAC DATE NOT NULL)


insert into TBL_NIVEL values(0,'kinder', 5)

insert into TBL_NIVEL values(1,'Primero básico', 6 )

insert into TBL_NIVEL values(2,'Segundo básico', 7 )

insert into TBL_NIVEL values(3,'Tercero básico', 8 )

insert into TBL_NIVEL values(4,'Cuarto básico', 9 )

insert into TBL_NIVEL values(5,'Quinto básico', 10 )

insert into TBL_NIVEL values(6,'Sexto básico', 11 )

insert into TBL_NIVEL values(7,'Septimo básico', 12 )

insert into TBL_NIVEL values(8,'Octavo básico', 13 )


/*
prueba de DATEDIFF 
compara 2 fechas segun: 
year( por año )
day (por dia )
minute (por minuto)
hour (por horas)
month (por meses)
*/
SELECT DATEDIFF(year,'2009/03/30','2015/03/31')

--creando funciones.......

CREATE FUNCTION fn_edad --funcion que busca edad entre 2 fechas
(-- declarando las variable fecha de nacimiento y fecha final
@fNacimiento datetime,
@fdiligenciamiento datetime
)RETURNS int
AS
BEGIN-- declarando variable resultado de retorno con el resultado
DECLARE @ResultVar int
set @ResultVar = DATEDIFF(year,@fNacimiento,@fdiligenciamiento )+   
case
when ( Month(@fdiligenciamiento) < Month(@fNacimiento) Or (Month(@fdiligenciamiento) = Month(@fNacimiento) And Day(@fdiligenciamiento) < day(@fNacimiento))) Then -1 else 0 end
RETURN @ResultVar
END

select dbo.fn_edad('2009/09/01','2015/03/31')--prueba funcion para buscar edad

create function fn_curso -- funcion para buscar el nivel o curso al que pertenece segun edad
(
	@fecha_nacimiento date --declaramos variable fecha de nacimiento para relacionarla con la funcion edad
)
returns int --retornaremos un entero que seria el codigo del nivel
as 
begin
return (select CODNIVEL from TBL_NIVEL
	where EDAD = dbo.fn_edad(@fecha_nacimiento,'2015/03/31')) -- retornamos una consulta y mesclamos con la funcion edad
end
	
select dbo.fn_curso('2009/03/09') -- probando funcion curso

-- creando proceso de almacenado........

alter procedure sp_creaPreAlumno  @rut int,                          --variables a usar y el tipo 
								  @nombre varchar(60),
								  @apellido_paterno varchar(60),
								  @apellido_materno varchar(60),
								  @fecha_nacimiento date
as
begin
	begin try
		if exists (select rut from tbl_prematricula where rut = @rut) -- preguntamos si existe el rut
		begin
			print('RUT EXISTE....Revisar')
		end
		else
		begin
			insert into tbl_prematricula values (@rut,dbo.fn_curso(@fecha_nacimiento),@nombre,@apellido_paterno,@apellido_materno,@fecha_nacimiento) -- insertamos usando la funcion curso para buscar el curso al que pertenece segun la funcion edad.
			if @@ERROR = 0 -- si no hay ningun error.......
			 print ('Alumno prematriculado.........')
		end
	end try
	begin catch
		print('Error en la transaccion.....................') -- salta el catch en caso que existe un error antes del primer try.
	end catch
end								  

exec sp_creaPreAlumno 13917688,'Gaston','Sepulveda','Espinoza','2009/03/09' -- prueba de procedure.

select * from TBL_PREMATRICULA -- vemos datos de la tabla.