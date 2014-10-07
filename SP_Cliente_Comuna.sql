use ClienteComunas
create procedure sp_LeerCliente
(
	@rut int,
	@dv char output, 
	@nombres varchar(100) output,
	@apellido_paterno varchar(100) output,
	@apellido_materno varchar(100) output,
	@direccion varchar(200) output,
	@comuna varchar(100)output
)
as
begin
	begin try
		if not exists (select rut from dbo.tbl_clientes where rut = @rut)
		begin
			print ('Cliente no existe...')
		end
		else
		begin
			select @dv = dv,@nombres = nombres, @apellido_paterno = appaterno, @apellido_materno = apmaterno,@direccion = direccion,@comuna = NombreComuna
			from tbl_clientes
			inner join tbl_comunas 
				on tbl_clientes.codcomuna = tbl_comunas.codcomuna
				where rut = @rut
		end
	end try
	begin catch
			print ('error transaccion....')
	end catch
end

exec sp_LeerCliente 13917688,'k','Gaston','Sepulveda','Espinoza','Puerto Montt 5715',306

create procedure sp_InsertarCliente
(
	@rut int,
	@dv char , 
	@nombres varchar(100) ,
	@apellido_paterno varchar(100),
	@apellido_materno varchar(100),
	@direccion varchar(200),
	@comuna int
)
as 
begin
	begin try
	if not exists (select rut from tbl_clientes where rut = @rut)
	begin
		insert into tbl_clientes values (@rut,@dv,@nombres,@apellido_paterno,@apellido_paterno,GETDATE(),@direccion,@comuna)
		print ('Cliente Insertado...')
	end
	else
	begin
		print ('Cliente Existe...')
	end
	end try
	begin catch
		print ('error transaccion....')
	end catch
	
end

exec sp_InsertarCliente 13917688,'k','Gaston','Sepulveda','Espinoza','Puerto Montt 5715',306




