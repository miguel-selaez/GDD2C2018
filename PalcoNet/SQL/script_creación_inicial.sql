USE GD2C2018;
GO

CREATE SCHEMA MANG; 

GO
print (CONCAT('Creacion de tablas ', CONVERT(VARCHAR, GETDATE(), 114)))

--------------------TABLAS---------------------------------------------
CREATE TABLE [MANG].[Factura] (
  [fa_id] int,
  [fa_id_empresa] int,
  [fa_nro] numeric(18,0),
  [fa_fecha] datetime,
  [fa_total] numeric(18,2),
  PRIMARY KEY ([fa_id])
);

GO

CREATE TABLE [MANG].[Ubicacion] (
  [ub_id] int,
  [ub_fila] char,
  [ub_asiento] int,
  [ub_sin_numerar] bit,
  [ub_precio] numerio(18,0),
  [ub_id_publicacion] int,
  [ub_id_tipo_ubicacion] int,
  PRIMARY KEY ([ub_id])
);

GO

CREATE TABLE [MANG].[Tipo_Ubicacion] (
  [tu_id] int,
  [tu_codigo] numeric(18,0),
  [tu_descripcion] nvarchar,
  [tu_baja] bit,
  PRIMARY KEY ([tu_id])
);

GO

CREATE TABLE [MANG].[Premio] (
  [pr_id] int,
  [pr_codigo] nvarchar,
  [pr_descripcion] nvarchar,
  [pr_cantidad] int,
  [pr_costo] int,
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
  [ta_id] int,
  [ta_nro] nvarchar,
  [ta_vencimiento] nvarchar,
  [ta_cod_verificador] char(3),
  [ta_baja] bit,
  PRIMARY KEY ([ta_id])
);

GO

CREATE TABLE [MANG].[Rubro] (
  [ru_id] int,
  [ru_descripcion] nvarchar,
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
  [ca_id] int,
  [ca_id_cliente] int,
  [ca_id_premio] int,
  [ca_fecha_canje] datetime,
  PRIMARY KEY ([ca_id])
);

GO

CREATE TABLE [MANG].[Item_Factura] (
  [if_id] int,
  [if_id_compra] int,
  [if_d_factura] int,
  [if_monto] numeric(18,2),
  [if_cantidad] int,
  [if_descripcion] nvarchar,
  PRIMARY KEY ([if_id])
);

GO

CREATE TABLE [MANG].[Forma_Pago] (
  [fp_id] int,
  [fp_descripcion] nvarchar,
  [fp_baja] bit,
  PRIMARY KEY ([fp_id])
);

GO

CREATE TABLE [MANG].[Publicacion] (
  [p_id] int,
  [p_codigo] numeric(18,0),
  [p_descripcion] nvarchar,
  [p_fecha_publicacion] datetime,
  [p_fecha_venc] datetime,
  [p_fecha_espectaculo] datetime,
  [p_direccion] nvarchar,
  [p_id_estado_publicacion] int,
  [p_id_rubro] int,
  [p_id_grado] int,
  PRIMARY KEY ([p_id])
);

GO

CREATE TABLE [MANG].[Compra] (
  [co_id] int,
  [co_id_cliente] int,
  [co_id_ubicacion] int,
  [co_fecha_compra] datetime,
  [co_puntos_obtenidos] int,
  [co_puntos_restantes] int,
  [co_fecha_venc_puntos] datetime,
  [co_facturada] bit,
  [co_forma_pago_id] int,
  PRIMARY KEY ([co_id])
);

GO

CREATE TABLE [MANG].[Grado] (
  [g_id] int,
  [g_prioridad] nvarchar,
  [g_comision] numeric(18,0),
  PRIMARY KEY ([g_id])
);

GO

CREATE TABLE [MANG].[Show] (
  [s_id] int,
  [s_fecha] datetime,
  [s_id_publicacion] int,
  PRIMARY KEY ([s_id])
);

GO

CREATE TABLE [MANG].[Cliente] (
  [c_id] int,
  [c_nombre] nvarchar,
  [c_apellido] nvarchar,
  [c_id_tipo_documento] int,
  [c_nro_documento] nvarchar,
  [c_cuil] nvarchar,
  [c_mail] nvarchar,
  [c_telefono] nvarchar,
  [c_fecha_nacimiento] datetime,
  [c_calle] nvarchar,
  [c_nro_calle] numeric(18,0),
  [c_piso] numeric(18,0),
  [c_depto] nvarchar,
  [c_localidad] nvarchar,
  [c_cod_postal] nvarchar,
  [c_id_tarjeta] int,
  [c_id_usuario] int,
  [c_fecha_alta] datetime,
  [c_baja] bit,
  [c_inconsistente] bit,
  PRIMARY KEY ([c_id])
);

GO

CREATE TABLE [MANG].[Usuario] (
  [u_id] int,
  [u_nombre_usuario] varchar,
  [u_password] varbinary,
  [u_baja] bit,
  [u_intentos_fallidos] int,
  PRIMARY KEY ([u_id])
);

GO

CREATE TABLE [MANG].[Estado_Publicacion] (
  [ep_id] int,
  [ep_descripcion] nvarchar,
  PRIMARY KEY ([ep_id])
);

GO

CREATE TABLE [MANG].[Rol] (
  [r_id] int,
  [r_descripcion] nvarchar,
  [r_baja] bit,
  PRIMARY KEY ([r_id])
);

GO

CREATE TABLE [MANG].[Funcion] (
  [f_id] int,
  [f_descripcion] nvarchar,
  [f_baja] bit,
  PRIMARY KEY ([f_id])
);

GO

CREATE TABLE [MANG].[Empresa] (
  [e_id] int,
  [e_razon_social] nvarchar,
  [e_mail] nvarchar,
  [e_telefono] nvarchar,
  [e_cuit] nvarchar,
  [e_calle] nvarchar,
  [e_nro_calle] numeric(18,0),
  [e_piso] numeric(18,0),
  [e_depto] nvarchar,
  [e_localidad] nvarchar,
  [e_cod_postal] nvarchar,
  [e_ciudad] nvarchar,
  [e_id_usuario] int,
  [e_baja] bit,
  PRIMARY KEY ([e_id])
);

GO

CREATE TABLE [MANG].[Tipo_Documento] (
  [td_id] int,
  [td_descripcion] nvarchar,
  [td_baja] bit,
  PRIMARY KEY ([td_id])
);

GO

print (CONCAT('Creacion de SPs ', CONVERT(VARCHAR, GETDATE(), 114)))

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
INSERT INTO MANG.Roles_x_Usuario (id_usuario, id_rol) VALUES (1, 1)

--TIPO_DOCUMENTO
INSERT MANG.Tipo_Documento VALUES ('DNI',0) 
INSERT MANG.Tipo_Documento VALUES ('PASAPORTE',0) 

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


print (CONCAT('Fin del Script Inicial', CONVERT(VARCHAR, GETDATE(), 114)))