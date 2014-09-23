/*
	esta funcion permite buscar comuna por ciudad fn_ComunaPorCiudad
*/

create function fn_ComunaPorCiudad(@ciudad tinyint)
returns table
as
return(select * from COMUNAS where codCiudad=@ciudad)

select * from fn_ComunaPorCiudad(1)


/*
	consulta cruzada
*/

select * from fn_ComunaPorCiudad(1) CC

inner join Comunas cm
	on cc.CodComuna = cm.CodComuna
	
/*
	
*/

create function fn_CalculaIvaProducto(@codProd int)
returns money
begin
	declare @valor money
	select @valor = precio + (precio * 0.19)
	from producto
	where codproducto = @codProd
	
	return @valor
end

select dbo.fn_calculaivaproducto (1)

/*
	funcion doble select
*/

select valoriva from iva where indvigencia = 'v'

create function fn_retornaIva(@codpro int)
returns  float
as 
begin
	declare @valoriva float 
	declare @preciovia float
	
	set @valoriva = 0
	set @preciovia = 0
	
	select @valoriva = valoriva
	from iva
	where indvigencia = 'v'
	
	select @preciovia = precio + (precio * @valoriva)
	from producto 
	where codproducto = @codpro
	return @preciovia
end

select dbo.fn_retornaIva(1)

create procedure sp_insertaVenta(@codpro int, @fechaventa date)
as
begin
	insert into ventaslv values (@codpro,@fechaventa,dbo.fn_retornaIva(@codpro))
end

exec sp_insertaVenta 2,'20110830'

select * from ventaslv

/*
	funcion para validar digito verificador de un rut
*/

CREATE  FUNCTION [dbo].[ObtenerDigitoVerificador]
(
	@rut INTEGER
 )
 RETURNS VARCHAR(1)

 AS
 BEGIN

 DECLARE @dv VARCHAR(1)
 DECLARE @rutAux INTEGER
 DECLARE @Digito INTEGER
 DECLARE @Contador INTEGER
 DECLARE @Multiplo INTEGER
 DECLARE @Acumulador INTEGER


 SET @Contador = 2;
 SET @Acumulador = 0;
 SET @Multiplo = 0;

	WHILE(@rut!=0)
		BEGIN

			SET @Multiplo = (@rut % 10) * @Contador;
			SET @Acumulador = @Acumulador + @Multiplo;
			SET @rut = @rut / 10;
			SET @Contador = @Contador + 1;
			if(@Contador = 8)
			BEGIN
				SET @Contador = 2;
			End;
		END;

	SET @Digito = 11 - (@Acumulador % 11);

	SET @dv = LTRIM(RTRIM(CONVERT(VARCHAR(2),@Digito)));

	IF(@Digito = 10)
	BEGIN
		SET @dv = 'K';
	END;

	IF(@Digito = 11)
	BEGIN
		SET @dv = '0';
	END;

RETURN @dv

END

select dbo.ObtenerDigitoVerificador(13917688)