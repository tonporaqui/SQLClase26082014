use funciones


	
select * from fn_ComunaPorCiudad(1)

select * from EMPLEADOS


CREATE FUNCTION fn_empleados (@largo varchar(15)) /*creamos la funcion*/
returns @fn_empleados table /*creamos un returns con una variable del tipo tabla*/
		(
			EmpleadoID int primary key not null, /*creamos una tabla temporal*/
			EmpleadoNombre varchar(60) not null,
			TipoNombre varchar(20)
		)
AS
BEGIN 
if @largo ='NombreCorto'
	insert @fn_empleados 
	Select empleadoid, nombres,'Solo Nombre' as TipoNombre 
	from Empleados 
	/* insertamos en la variable del tipo tabla @fn_empleados lo que seleccionemos de
	 la tabla empleados*/
else if @largo = 'NombreLargo' 
	insert @fn_empleados
	select empleadoid,(nombres +' '+ apellidos), 'Nombre y Apellidos' as TipoNombre
	from empleados
	/* insertamos en la variable del tipo tabla @fn_empleados lo que seleccionemos de
	 la tabla empleados*/	
return
END

select * from fn_empleados('NombreCorto')

select * from fn_empleados('NombreLargo')
/* BUSCA EMPLEADOS POR SEXO*/
create function fn_empleadoPorGenero(@genero char)
returns @fn_genero table
		(
			ID_EMPLEADO int primary key not null,
			nombre varchar(50) not null,
			sexo varchar(20)
		)
as
begin
if @genero = 'F'
	insert @fn_genero 
	select empleadoid, (nombres+' '+Apellidos ),'Mujeres' as sexo
	from empleados 
	where sexo = 'F'
else if @genero = 'M'
	insert @fn_genero
	select empleadoid, (nombres+' '+Apellidos), 'Hombres' as sexo
	from empleados
	where sexo = 'M'

	return

end

select * from fn_empleadoPorGenero('M')
select * from fn_empleadoPorGenero('F')