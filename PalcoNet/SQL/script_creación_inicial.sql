USE GD2C2018;
GO

--CREATE SCHEMA MANG; 
--GO

print (CONCAT('Creacion de tablas ', CONVERT(VARCHAR, GETDATE(), 114)))

--------------------TABLAS---------------------------------------------
CREATE TABLE [MANG].[Factura] (
  [fa_id] int IDENTITY(1,1),
  [fa_id_empresa] int,
  [fa_nro] numeric(18,0),
  [fa_fecha] datetime,
  [fa_total] numeric(18,2),
  [fa_id_forma_pago] int,
  PRIMARY KEY ([fa_id])
);

GO

CREATE TABLE [MANG].[Ubicacion] (
  [ub_id] int IDENTITY(1,1),
  [ub_fila] varchar(3),
  [ub_asiento] numeric(18,0),
  [ub_sin_numerar] bit,
  [ub_precio] numeric(18,0),
  [ub_id_publicacion] int,
  [ub_id_tipo_ubicacion] int,
  PRIMARY KEY ([ub_id])
);

GO

CREATE TABLE [MANG].[Tipo_Ubicacion] (
  [tu_id] int IDENTITY(1,1),
  [tu_codigo] numeric(18,0),
  [tu_descripcion] nvarchar(255),
  [tu_baja] bit,
  PRIMARY KEY ([tu_id])
);

GO

CREATE TABLE [MANG].[Premio] (
  [pr_id] int IDENTITY(1,1),
  [pr_codigo] nvarchar(50),
  [pr_descripcion] nvarchar(100),
  [pr_cantidad] int,
  [pr_costo_puntos] int,
  [pr_baja] bit,
  PRIMARY KEY ([pr_id])
);

GO

CREATE TABLE [MANG].[Rol_x_Usuario] (
  [rxu_id_usuario] int,
  [rxu_id_rol] int,
  PRIMARY KEY ([rxu_id_usuario], [rxu_id_rol])
);

GO

CREATE TABLE [MANG].[Tarjeta] (
  [ta_id] int IDENTITY(1,1),
  [ta_nro] nvarchar(50),
  [ta_vencimiento] nvarchar(8),
  [ta_cod_verificador] char(3),
  [ta_baja] bit,
  PRIMARY KEY ([ta_id])
);

GO

CREATE TABLE [MANG].[Rubro] (
  [ru_id] int IDENTITY(1,1),
  [ru_descripcion] nvarchar(255),
  PRIMARY KEY ([ru_id])
);

GO

CREATE TABLE [MANG].[Funcion_x_Rol] (
  [fxr_id_funcion] int,
  [fxr_id_rol] int,
  PRIMARY KEY ([fxr_id_funcion], [fxr_id_rol])
);

GO

CREATE TABLE [MANG].[Canje] (
  [ca_id] int IDENTITY(1,1),
  [ca_id_cliente] int,
  [ca_id_premio] int,
  [ca_fecha_canje] datetime,
  PRIMARY KEY ([ca_id])
);

GO

CREATE TABLE [MANG].[Item_Factura] (
  [i_id] int IDENTITY(1,1),
  [i_id_compra] int,
  [i_d_factura] int,
  [i_monto] numeric(18,2),
  [i_cantidad] int,
  [i_descripcion] nvarchar(60),
  PRIMARY KEY ([i_id])
);

GO

CREATE TABLE [MANG].[Forma_Pago] (
  [fp_id] int IDENTITY(1,1),
  [fp_descripcion] nvarchar(255),
  [fp_baja] bit,
  PRIMARY KEY ([fp_id])
);

GO

CREATE TABLE [MANG].[Publicacion] (
  [p_id] int IDENTITY(1,1),
  [p_codigo] numeric(18,0),
  [p_descripcion] nvarchar(255),
  [p_fecha_publicacion] datetime,
  [p_fecha_venc] datetime,
  [p_fecha_espectaculo] datetime,
  [p_direccion] nvarchar(255),
  [p_id_estado_publicacion] int,
  [p_id_rubro] int,
  [p_id_grado] int,
  [p_id_empresa] int,
  PRIMARY KEY ([p_id])
);

GO

CREATE TABLE [MANG].[Compra] (
  [co_id] int IDENTITY(1,1),
  [co_id_cliente] int,
  [co_id_ubicacion] int,
  [co_fecha_compra] datetime,
  [co_puntos_obtenidos] int,
  [co_puntos_restantes] int,
  [co_fecha_venc_puntos] datetime,
  [co_facturada] bit,
  PRIMARY KEY ([co_id])
);

GO

CREATE TABLE [MANG].[Grado] (
  [g_id] int IDENTITY(1,1),
  [g_prioridad] nvarchar(50),
  [g_comision] numeric(18,0),
  PRIMARY KEY ([g_id])
);

GO

CREATE TABLE [MANG].[Show] (
  [s_id] int IDENTITY(1,1),
  [s_fecha] datetime,
  [s_id_publicacion] int,
  PRIMARY KEY ([s_id])
);

GO

CREATE TABLE [MANG].[Cliente] (
  [c_id] int IDENTITY(1,1),
  [c_nombre] nvarchar(255),
  [c_apellido] nvarchar(255),
  [c_id_tipo_documento] int,
  [c_nro_documento] numeric(18,0),
  [c_cuil] nvarchar(50),
  [c_mail] nvarchar(255),
  [c_telefono] nvarchar(50),
  [c_fecha_nacimiento] datetime,
  [c_calle] nvarchar(255),
  [c_nro_calle] numeric(18,0),
  [c_piso] numeric(18,0),
  [c_depto] nvarchar(255),
  [c_localidad] nvarchar(255),
  [c_cod_postal] nvarchar(255),
  [c_id_tarjeta] int,
  [c_id_usuario] int,
  [c_fecha_alta] datetime,
  [c_baja] bit,
  [c_inconsistente] bit,
  PRIMARY KEY ([c_id])
);

GO

CREATE TABLE [MANG].[Usuario] (
  [u_id] int IDENTITY(1,1),
  [u_nombre_usuario] varchar(100),
  [u_password] varbinary,
  [u_baja] bit,
  [u_intentos_fallidos] int,
  PRIMARY KEY ([u_id])
);

GO

CREATE TABLE [MANG].[Estado_Publicacion] (
  [ep_id] int IDENTITY(1,1),
  [ep_descripcion] nvarchar(255),
  PRIMARY KEY ([ep_id])
);

GO

CREATE TABLE [MANG].[Rol] (
  [r_id] int IDENTITY(1,1),
  [r_descripcion] nvarchar(50),
  [r_baja] bit,
  PRIMARY KEY ([r_id])
);

GO

CREATE TABLE [MANG].[Funcion] (
  [f_id] int IDENTITY(1,1),
  [f_descripcion] nvarchar(50),
  [f_baja] bit,
  PRIMARY KEY ([f_id])
);

GO

CREATE TABLE [MANG].[Empresa] (
  [e_id] int IDENTITY(1,1),
  [e_razon_social] nvarchar(255),
  [e_mail] nvarchar(50),
  [e_telefono] nvarchar(50),
  [e_cuit] nvarchar(255),
  [e_calle] nvarchar(50),
  [e_nro_calle] numeric(18,0),
  [e_piso] numeric(18,0),
  [e_depto] nvarchar(50),
  [e_localidad] nvarchar(255),
  [e_cod_postal] nvarchar(50),
  [e_ciudad] nvarchar(255),
  [e_id_usuario] int,
  [e_baja] bit,
  PRIMARY KEY ([e_id])
);

GO

CREATE TABLE [MANG].[Tipo_Documento] (
  [td_id] int IDENTITY(1,1),
  [td_descripcion] nvarchar(100),
  [td_baja] bit,
  PRIMARY KEY ([td_id])
);

GO

print (CONCAT('Creacion de SPs ', CONVERT(VARCHAR, GETDATE(), 114)))

/*
IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Login')
	DROP PROCEDURE MANG.P_Login
GO 	

CREATE PROCEDURE MANG.P_Login  
	@user nvarchar(255),
	@pass nvarchar(50)
AS
BEGIN 
	DECLARE @pass_enc varbinary(256)
	SELECT @pass_enc = HASHBYTES('SHA2_256', @pass);

	SELECT 
		u.id_usuario,
		u.nombre_usuario,
		'' as pass,
		u.baja_u,
		u.intentos_fallidos,
		p.id_persona,
		p.nombre,
		p.apellido,
		MANG.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		MANG.Usuario as u
		LEFT JOIN MANG.Persona as p
			ON u.id_persona = p.id_persona
		LEFT JOIN MANG.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN MANG.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN MANG.Pais as pa
			ON pa.id_pais = d.id_pais
	WHERE
		UPPER(u.nombre_usuario) = UPPER(@user)
		AND u.pass = @pass_enc
		AND u.baja_u = 0
	 	
END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Roles_x_Usuario')
	DROP PROCEDURE MANG.P_Obtener_Roles_x_Usuario
GO 	

CREATE PROCEDURE MANG.P_Obtener_Roles_x_Usuario  
	@id int
AS
BEGIN 
	SELECT 
		R.*
	FROM 
		MANG.Rol as R
		INNER JOIN MANG.Roles_x_Usuario as RU
			ON R.id_rol = RU.id_rol
	WHERE 
		RU.id_usuario = @id
		AND R.baja_rl = 0
	ORDER BY
		R.descripcion_rl

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Funciones_x_Rol')
	DROP PROCEDURE MANG.P_Obtener_Funciones_x_Rol
GO 	

CREATE PROCEDURE MANG.P_Obtener_Funciones_x_Rol 
	@id int
AS
BEGIN 
	SELECT 
		F.*
	FROM 
		MANG.Funcion as F
		INNER JOIN Funciones_x_Rol as FR
			ON F.id_funcion = FR.id_funcion
	WHERE 
		FR.id_rol = @id
		AND F.baja_f = 0
	ORDER BY
		F.descripcion_f

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Roles')
	DROP PROCEDURE MANG.P_Obtener_Roles
GO 	

CREATE PROCEDURE MANG.P_Obtener_Roles  
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		R.*
	FROM 
		MANG.Rol as R
	WHERE
		(R.descripcion_rl like '%'+ @descripcion + '%' OR @descripcion IS NULL)
		AND (R.baja_rl = @baja OR @baja IS NULL)
	ORDER BY
		R.descripcion_rl

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='FX_Mostrar_Fecha')
	DROP FUNCTION MANG.FX_Mostrar_Fecha
GO 	

CREATE FUNCTION MANG.FX_Mostrar_Fecha(@fecha datetime)  
RETURNS varchar(10)   
AS   
BEGIN  
    DECLARE @ret varchar(10); 
	IF (@fecha IS NULL) 
		 RETURN NULL;
	ELSE
		SELECT @ret = CONVERT(varchar(10), @fecha, 112)
    
	RETURN @ret;  
END;
 
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Funciones')
	DROP PROCEDURE MANG.P_Obtener_Funciones
GO 	

CREATE PROCEDURE MANG.P_Obtener_Funciones 
	@baja bit
AS
BEGIN 
	SELECT 
		F.*
	FROM 
		MANG.Funcion as F
	WHERE 
		F.baja_f = @baja
		AND F.descripcion_f <> 'ABM USUARIO'
	ORDER BY
		F.descripcion_f

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Rol')
	DROP PROCEDURE MANG.P_Guardar_Rol
GO 	

CREATE PROCEDURE MANG.P_Guardar_Rol 
	@id int, 
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	IF @id = 0
	BEGIN 
		INSERT INTO MANG.Rol (descripcion_rl, baja_rl)
		VALUES (@descripcion, @baja)

		SELECT id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		UPDATE MANG.Rol 
		SET 
			descripcion_rl = @descripcion,
			baja_rl = @baja
		WHERE 
			id_rol = @id;

		SELECT id_out = @id;

		DELETE Funciones_x_Rol
		WHERE 
			id_rol = @id;
	END

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Funcion_x_Rol')
	DROP PROCEDURE MANG.P_Guardar_Funcion_x_Rol
GO 	

CREATE PROCEDURE MANG.P_Guardar_Funcion_x_Rol 
	@id_funcion int, 
	@id_rol int
AS
BEGIN 
	INSERT INTO MANG.Funciones_x_Rol(id_funcion, id_rol)
	VALUES (@id_funcion, @id_rol)
END
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Usuarios')
	DROP PROCEDURE MANG.P_Obtener_Usuarios
GO 	

CREATE PROCEDURE MANG.P_Obtener_Usuarios  
	@usuario nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		u.id_usuario,
		u.nombre_usuario,
		'' as pass,
		u.baja_u,
		u.intentos_fallidos,
		p.id_persona,
		p.nombre,
		p.apellido,
		MANG.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		MANG.Usuario as u
		LEFT JOIN MANG.Persona as p
			ON u.id_persona = p.id_persona
		LEFT JOIN MANG.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN MANG.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN MANG.Pais as pa
			ON pa.id_pais = d.id_pais
	WHERE
		(U.nombre_usuario like '%'+ @usuario + '%' OR @usuario IS NULL)
		AND (U.baja_u = @baja OR @baja IS NULL)
	ORDER BY
		U.nombre_usuario

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_TiposDocumento')
	DROP PROCEDURE MANG.P_Obtener_TiposDocumento
GO 	

CREATE PROCEDURE MANG.P_Obtener_TiposDocumento  
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		T.*
	FROM 
		MANG.Tipo_Documento as T
	WHERE
		(T.descripcion_td like '%'+ @descripcion + '%' OR @descripcion IS NULL)
		AND (T.baja_td = @baja OR @baja IS NULL)
	ORDER BY
		T.descripcion_td

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Usuario')
	DROP PROCEDURE MANG.P_Guardar_Usuario
GO 	

CREATE PROCEDURE MANG.P_Guardar_Usuario 
	@id int, 
	@nombre_usuario nvarchar(255),
	@pass nvarchar(50),
	@baja bit, 
	@id_persona int,
	@id_out int out
AS
BEGIN 
	IF @id = 0
	BEGIN 
		INSERT INTO MANG.Usuario(nombre_usuario, pass, baja_u, intentos_fallidos, id_persona)
		VALUES (@nombre_usuario, HASHBYTES('SHA2_256', @pass), @baja, 0, @id_persona)

		SELECT @id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		IF @pass IS NULL
		BEGIN
			UPDATE MANG.Usuario
			SET 
				nombre_usuario = @nombre_usuario,
				baja_u = @baja,
				id_persona = @id_persona
			WHERE 
				 id_usuario = @id;
		END 
		ELSE
		BEGIN
			UPDATE MANG.Usuario
			SET 
				nombre_usuario = @nombre_usuario,
				pass = HASHBYTES('SHA2_256', @pass),
				baja_u = @baja,
				id_persona = @id_persona
			WHERE 
				 id_usuario = @id;
		END

		SELECT @id_out = @id;

		DELETE MANG.Usuario_x_Hotel
		WHERE 
			id_usuario = @id;

		DELETE MANG.Roles_x_Usuario
		WHERE 
			id_usuario = @id;

		RETURN @id_out;
	END

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Rol_x_Usuario')
	DROP PROCEDURE MANG.P_Guardar_Rol_x_Usuario
GO 	

CREATE PROCEDURE MANG.P_Guardar_Rol_x_Usuario 
	@id_usuario int, 
	@id_rol int
AS
BEGIN 
	INSERT INTO MANG.Roles_x_Usuario(id_usuario, id_rol)
	VALUES (@id_usuario, @id_rol)
END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Cliente')
	DROP PROCEDURE MANG.P_Guardar_Cliente
GO 	
CREATE PROCEDURE [MANG].[P_Guardar_Cliente] 
	@id int, 
	@id_persona int,
	@baja bit, 
	@id_out int out
AS
BEGIN 
	IF @id = 0
	BEGIN 
		INSERT INTO MANG.Cliente(id_persona, baja_cl)
		VALUES (@id_persona, @baja)

		SELECT @id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		UPDATE MANG.Cliente
		SET 
			id_persona = @id_persona,
			baja_cl = @baja
		WHERE 
			id_cliente = @id;

		SELECT @id_out = @id;
	END
		
	RETURN @id_out;
	
END
GO
IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Clientes')
	DROP PROCEDURE MANG.P_Obtener_Clientes
GO 
CREATE PROCEDURE [MANG].[P_Obtener_Clientes]  
	@tipo_identificacion nvarchar(100),
	@numero_documento numeric(18,0),
	@mail nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		TOP (100)
		c.id_cliente,		
		c.baja_cl,
		p.id_persona,
		p.nombre,
		p.apellido,
		MANG.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		MANG.Cliente as c
		LEFT JOIN MANG.Persona as p
			ON c.id_persona = p.id_persona
		LEFT JOIN MANG.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN MANG.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN MANG.Pais as pa
			ON pa.id_pais = d.id_pais
	WHERE
		(p.mail LIKE '%' + @mail + '%' OR @mail IS NULL) AND
		(CAST(p.numero_documento AS nvarchar) LIKE '%' + CAST(@numero_documento AS nvarchar) + '%') AND
		(t.descripcion_td = CASE WHEN @tipo_identificacion = 'TODOS' THEN t.descripcion_td ELSE @tipo_identificacion END) AND
		(c.baja_cl = @baja OR @baja IS NULL)
	ORDER BY
		p.mail, p.numero_documento 

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Validar_Mail_CLiente')
	DROP PROCEDURE MANG.P_Validar_Mail_CLiente
GO 
CREATE PROCEDURE [MANG].[P_Validar_Mail_CLiente]
	@v_mail nvarchar(255),
	@v_flag bit = 0 out
AS
BEGIN
	SET NOCOUNT ON
	SET @v_flag = ISNULL((SELECT TOP 1 1 FROM MANG.Persona p WHERE p.mail = @v_mail),0)
	RETURN @v_flag
END
GO
*/
print (CONCAT('INSERTS ', CONVERT(VARCHAR, GETDATE(), 114)))
---------------------------------- INSERTS ------------------------------
BEGIN TRY
BEGIN TRANSACTION
-- ROLES
INSERT INTO MANG.Rol VALUES 
('ADMINISTRADOR',0),
('EMPRESA',0),
('CLIENTE',0)

-- FUNCIONES
INSERT INTO MANG.Funcion VALUES 
('ABM ROL', 0),
('ABM USUARIO',0),
('ABM CLIENTE',0),
('ABM EMPRESA',0),
('ABM GRADO',0),
('ABM RUBRO',0),
('ABM RESERVA',0),
('ABM PUBLICACION',0),
('COMPRAS',0),
('CANJE Y PUNTOS',0),
('RENDICIONES',0),
('LISTADO ESTADISTICO',0)

-- USUARIO
--EXEC MANG.P_Alta_Persona 
--	null,
--	'Administrador General',
--	null,
--	null,
--	null,
--	null,
--	1,
--	null,
--	null,
--	null,
--	0,
--	@id_persona_usuario OUTPUT

--INSERT INTO MANG.Usuario VALUES
--('admin', HASHBYTES('SHA2_256', CONVERT(nvarchar(50), 'w23e')), 0, 0);

-- FUNCIONES X ROL
--INSERT INTO MANG.Funciones_x_Rol (id_rol, id_funcion) VALUES 
--(1, 1),
--(1, 2),
--(1, 3),
--(1, 4),
--(1, 5),
--(1, 6),
--(1, 7),
--(1, 8),
--(1, 9),
--(1, 10),
--(2, 3),
--(2, 7),
--(2, 8),
--(2, 9),
--(3,7)

-- ROLES X USUARIO
--INSERT INTO MANG.Rol_x_Usuario (rxu_id_usuario, rxu_id_rol) VALUES (1, 1)

--TIPO_DOCUMENTO
INSERT MANG.Tipo_Documento VALUES ('DNI',0); 
INSERT MANG.Tipo_Documento VALUES ('PASAPORTE',0); 


--FORMA DE PAGO
INSERT MANG.Forma_Pago VALUES ('Efectivo', 0);
INSERT MANG.Forma_Pago VALUES ('Tarjeta de Crédito', 0); 

-- TIPO DE UBICACION
INSERT INTO MANG.Tipo_Ubicacion (tu_codigo, tu_descripcion, tu_baja)
SELECT 
	DISTINCT 
	[Ubicacion_Tipo_Codigo],
    [Ubicacion_Tipo_Descripcion],
	0 AS 'baja'
FROM [gd_esquema].[Maestra]
WHERE 
	[Ubicacion_Tipo_Codigo] IS NOT NULL
ORDER BY 
	[Ubicacion_Tipo_Descripcion] ASC

-- UBICACION - Depende de PUBLICACION
/*INSERT INTO MANG.Ubicacion (ub_fila, ub_asiento, ub_sin_numerar, ub_precio, ub_id_publicacion, ub_id_tipo_ubicacion)
SELECT 
	DISTINCT
    [Ubicacion_Fila],
    [Ubicacion_Asiento],
    [Ubicacion_Sin_numerar],
    [Ubicacion_Precio],
	(select top 1 p_id from MANG.Publicacion where p_codigo = [Espectaculo_Cod]) as 'id_publicacion',
    (select top 1 tu_id from MANG.Tipo_Ubicacion where tu_codigo = [Ubicacion_Tipo_Codigo]) as 'id_tipo ubicacion'
FROM [gd_esquema].[Maestra]
where Espectaculo_Cod = 12424
*/

-- COMPRAS - depende de PUBLICACION Y CLIENTE
/*
select 
	DISTINCT
	[Espectaculo_Cod],
    [Ubicacion_Fila],
    [Ubicacion_Asiento],
    [Ubicacion_Precio],
	[Ubicacion_Tipo_Codigo],
	[Cli_Dni],
	[Compra_Fecha],
	[Compra_Cantidad]
into #temp_compras
from [gd_esquema].[Maestra]
where 
	[Cli_Dni] IS NOT NULL
	and [Factura_Nro] IS NOT NULL

--INSERT INTO MANG.Compra 
--(co_id_cliente, 
--co_id_ubicacion, 
--co_fecha_compra, 
--co_puntos_obtenidos, 
--co_puntos_restantes,
--co_fecha_venc_puntos, 
--co_facturada)

select 
	(select c_id from MANG.Cliente where c_nro_documento = t.Cli_Dni) as 'id_cliente',
	(select 
		ub_id 
	from MANG.Ubicacion
	inner join MANG.Tipo_Ubicacion 
		on ub_id_tipo_ubicacion = tu_id
	inner join MANG.Publicacion
		on ub_id_publicacion = p_id
	where 
		ub_fila = t.Ubicacion_Fila 
		and ub_asiento = t.Ubicacion_Asiento 
		and ub_precio = t.Ubicacion_Precio
		and tu_codigo = t.Ubicacion_Tipo_Codigo
		and p_codigo = t.Espectaculo_Cod
	) as 'id_ubicacion',
	t.Compra_Fecha,
	10 as 'puntos_obtenidos', -- 10 puntos por compra
	10 as 'puntos_restantes', -- no consumio ninguno todavia
	DATEADD(MONTH, 1, t.Compra_Fecha) as 'fecha_compra', -- vence al mes de la compra
	1 as 'fue_facturada'-- porque todas las compras en la maestra estan facturadas
from 
	#temp_compras as t

DROP TABLE #temp_compras
*/

COMMIT TRANSACTION

END TRY
BEGIN CATCH
	SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRANSACTION
END CATCH
GO

print (CONCAT('Relaciones ', CONVERT(VARCHAR, GETDATE(), 114)))
---------------RELACIONES ------------------

GO
ALTER TABLE [MANG].[Canje]  WITH CHECK ADD  CONSTRAINT [FK_Canje_Cliente] FOREIGN KEY([ca_id_cliente])
REFERENCES [MANG].[Cliente] ([c_id])
GO
ALTER TABLE [MANG].[Canje] CHECK CONSTRAINT [FK_Canje_Cliente]
GO
ALTER TABLE [MANG].[Canje]  WITH CHECK ADD  CONSTRAINT [FK_Canje_Premio] FOREIGN KEY([ca_id_premio])
REFERENCES [MANG].[Premio] ([pr_id])
GO
ALTER TABLE [MANG].[Canje] CHECK CONSTRAINT [FK_Canje_Premio]
GO
ALTER TABLE [MANG].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Tarjeta] FOREIGN KEY([c_id_tarjeta])
REFERENCES [MANG].[Tarjeta] ([ta_id])
GO
ALTER TABLE [MANG].[Cliente] CHECK CONSTRAINT [FK_Cliente_Tarjeta]
GO
ALTER TABLE [MANG].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Tipo_Documento] FOREIGN KEY([c_id_tipo_documento])
REFERENCES [MANG].[Tipo_Documento] ([td_id])
GO
ALTER TABLE [MANG].[Cliente] CHECK CONSTRAINT [FK_Cliente_Tipo_Documento]
GO
ALTER TABLE [MANG].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Usuario] FOREIGN KEY([c_id_usuario])
REFERENCES [MANG].[Usuario] ([u_id])
GO
ALTER TABLE [MANG].[Cliente] CHECK CONSTRAINT [FK_Cliente_Usuario]
GO
ALTER TABLE [MANG].[Compra]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Cliente] FOREIGN KEY([co_id_cliente])
REFERENCES [MANG].[Cliente] ([c_id])
GO
ALTER TABLE [MANG].[Compra] CHECK CONSTRAINT [FK_Compra_Cliente]
GO
ALTER TABLE [MANG].[Compra]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Ubicacion] FOREIGN KEY([co_id_ubicacion])
REFERENCES [MANG].[Ubicacion] ([ub_id])
GO
ALTER TABLE [MANG].[Compra] CHECK CONSTRAINT [FK_Compra_Ubicacion]
GO
ALTER TABLE [MANG].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Usuario] FOREIGN KEY([e_id_usuario])
REFERENCES [MANG].[Usuario] ([u_id])
GO
ALTER TABLE [MANG].[Empresa] CHECK CONSTRAINT [FK_Empresa_Usuario]
GO
ALTER TABLE [MANG].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Empresa] FOREIGN KEY([fa_id_empresa])
REFERENCES [MANG].[Empresa] ([e_id])
GO
ALTER TABLE [MANG].[Factura] CHECK CONSTRAINT [FK_Factura_Empresa]
GO
ALTER TABLE [MANG].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Forma_Pago] FOREIGN KEY([fa_id_forma_pago])
REFERENCES [MANG].[Forma_Pago] ([fp_id])
GO
ALTER TABLE [MANG].[Factura] CHECK CONSTRAINT [FK_Factura_Forma_Pago]
GO
ALTER TABLE [MANG].[Funcion_x_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_x_Rol_Funcion] FOREIGN KEY([fxr_id_funcion])
REFERENCES [MANG].[Funcion] ([f_id])
GO
ALTER TABLE [MANG].[Funcion_x_Rol] CHECK CONSTRAINT [FK_Funcion_x_Rol_Funcion]
GO
ALTER TABLE [MANG].[Funcion_x_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_x_Rol_Rol] FOREIGN KEY([fxr_id_rol])
REFERENCES [MANG].[Rol] ([r_id])
GO
ALTER TABLE [MANG].[Funcion_x_Rol] CHECK CONSTRAINT [FK_Funcion_x_Rol_Rol]
GO
ALTER TABLE [MANG].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [FK_Item_Factura_Compra] FOREIGN KEY([i_id_compra])
REFERENCES [MANG].[Compra] ([co_id])
GO
ALTER TABLE [MANG].[Item_Factura] CHECK CONSTRAINT [FK_Item_Factura_Compra]
GO
ALTER TABLE [MANG].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [FK_Item_Factura_Factura] FOREIGN KEY([i_d_factura])
REFERENCES [MANG].[Factura] ([fa_id])
GO
ALTER TABLE [MANG].[Item_Factura] CHECK CONSTRAINT [FK_Item_Factura_Factura]
GO
ALTER TABLE [MANG].[Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Publicacion_Empresa] FOREIGN KEY([p_id_empresa])
REFERENCES [MANG].[Empresa] ([e_id])
GO
ALTER TABLE [MANG].[Publicacion] CHECK CONSTRAINT [FK_Publicacion_Empresa]
GO
ALTER TABLE [MANG].[Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Publicacion_Estado_Publicacion] FOREIGN KEY([p_id_estado_publicacion])
REFERENCES [MANG].[Estado_Publicacion] ([ep_id])
GO
ALTER TABLE [MANG].[Publicacion] CHECK CONSTRAINT [FK_Publicacion_Estado_Publicacion]
GO
ALTER TABLE [MANG].[Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Publicacion_Grado] FOREIGN KEY([p_id_grado])
REFERENCES [MANG].[Grado] ([g_id])
GO
ALTER TABLE [MANG].[Publicacion] CHECK CONSTRAINT [FK_Publicacion_Grado]
GO
ALTER TABLE [MANG].[Publicacion]  WITH CHECK ADD  CONSTRAINT [FK_Publicacion_Rubro] FOREIGN KEY([p_id_rubro])
REFERENCES [MANG].[Rubro] ([ru_id])
GO
ALTER TABLE [MANG].[Publicacion] CHECK CONSTRAINT [FK_Publicacion_Rubro]
GO
ALTER TABLE [MANG].[Rol_x_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Rol_x_Usuario_Rol] FOREIGN KEY([rxu_id_rol])
REFERENCES [MANG].[Rol] ([r_id])
GO
ALTER TABLE [MANG].[Rol_x_Usuario] CHECK CONSTRAINT [FK_Rol_x_Usuario_Rol]
GO
ALTER TABLE [MANG].[Rol_x_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Rol_x_Usuario_Usuario] FOREIGN KEY([rxu_id_usuario])
REFERENCES [MANG].[Usuario] ([u_id])
GO
ALTER TABLE [MANG].[Rol_x_Usuario] CHECK CONSTRAINT [FK_Rol_x_Usuario_Usuario]
GO
ALTER TABLE [MANG].[Show]  WITH CHECK ADD  CONSTRAINT [FK_Show_Publicacion] FOREIGN KEY([s_id_publicacion])
REFERENCES [MANG].[Publicacion] ([p_id])
GO
ALTER TABLE [MANG].[Show] CHECK CONSTRAINT [FK_Show_Publicacion]
GO
ALTER TABLE [MANG].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Publicacion] FOREIGN KEY([ub_id_publicacion])
REFERENCES [MANG].[Publicacion] ([p_id])
GO
ALTER TABLE [MANG].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Publicacion]
GO
ALTER TABLE [MANG].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Tipo_Ubicacion] FOREIGN KEY([ub_id_tipo_ubicacion])
REFERENCES [MANG].[Tipo_Ubicacion] ([tu_id])
GO
ALTER TABLE [MANG].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Tipo_Ubicacion]
GO


print (CONCAT('Fin del Script Inicial', CONVERT(VARCHAR, GETDATE(), 114)))