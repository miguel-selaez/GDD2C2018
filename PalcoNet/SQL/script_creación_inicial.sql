USE GD1C2018;
GO

--CREATE SCHEMA NPM; 
--GO
print (CONCAT('Creacion de tablas ', CONVERT(VARCHAR, GETDATE(), 114)))

--------------------TABLAS---------------------------------------------
CREATE TABLE NPM.Usuario(
	id_usuario int NOT NULL IDENTITY,
	nombre_usuario nvarchar(255) NOT NULL,
	pass varbinary(256) NOT NULL,
	baja_u bit NOT NULL DEFAULT 1,
	intentos_fallidos int NULL,
	id_persona int NULL,
	PRIMARY KEY(id_usuario)
)

GO

CREATE TABLE NPM.Tipo_Documento(
	id_tipo_documento int NOT NULL IDENTITY,
	descripcion_td nvarchar(50),
	baja_td bit NOT NULL,
	PRIMARY KEY(id_tipo_documento)
)

GO

CREATE TABLE NPM.Item_Factura(
	id_item_factura int NOT NULL IDENTITY,
	id_consumo int NULL,
	leyenda nvarchar(100) NULL,
	subtotal numeric(18,2) NULL,
	id_factura numeric(18,0) NOT NULL,
	PRIMARY KEY(id_item_factura)
)

GO

CREATE TABLE NPM.Factura(
	id_factura numeric(18,0) NOT NULL,
	id_estadia int NOT NULL,
	id_cliente int NOT NULL,	
	dias_alojamiento int NOT NULL,
	dias_faltantes int NULL,
	fecha_facturacion datetime,
	id_tipo_pago int NULL,
	total_factura numeric(18,2) NULL,
	PRIMARY KEY(id_factura)
)

GO 

CREATE TABLE NPM.Tipo_Pago(
	id_tipo_pago int NOT NULL IDENTITY,
	descripcion_tp nvarchar(50) NULL,
	baja_tp bit NOT NULL DEFAULT 1,
	PRIMARY KEY(id_tipo_pago)
)

GO 

CREATE TABLE NPM.Funcion(
	id_funcion int NOT NULL IDENTITY,
	descripcion_f nvarchar(255) NOT NULL,
	baja_f bit NOT NULL DEFAULT 1,
	PRIMARY KEY(id_funcion)
)

GO

CREATE TABLE NPM.Funciones_x_Rol(
	id_funcion int NOT NULL,
	id_rol int NOT NULL,
	PRIMARY KEY(id_funcion, id_rol)
)

GO

CREATE TABLE NPM.Rol(
	id_rol int NOT NULL IDENTITY,
	descripcion_rl nvarchar(255) NOT NULL,
	baja_rl bit NOT NULL DEFAULT 1,
	PRIMARY KEY(id_rol)
)

GO

CREATE TABLE NPM.Roles_x_Usuario(
	id_usuario int NOT NULL,
	id_rol int NOT NULL,
	PRIMARY KEY(id_usuario, id_rol)
)

GO

print (CONCAT('Creacion de SPs ', CONVERT(VARCHAR, GETDATE(), 114)))

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Login')
	DROP PROCEDURE NPM.P_Login
GO 	

CREATE PROCEDURE NPM.P_Login  
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
		NPM.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		NPM.Usuario as u
		LEFT JOIN NPM.Persona as p
			ON u.id_persona = p.id_persona
		LEFT JOIN NPM.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN NPM.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN NPM.Pais as pa
			ON pa.id_pais = d.id_pais
	WHERE
		UPPER(u.nombre_usuario) = UPPER(@user)
		AND u.pass = @pass_enc
		AND u.baja_u = 0
	 	
END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Roles_x_Usuario')
	DROP PROCEDURE NPM.P_Obtener_Roles_x_Usuario
GO 	

CREATE PROCEDURE NPM.P_Obtener_Roles_x_Usuario  
	@id int
AS
BEGIN 
	SELECT 
		R.*
	FROM 
		NPM.Rol as R
		INNER JOIN NPM.Roles_x_Usuario as RU
			ON R.id_rol = RU.id_rol
	WHERE 
		RU.id_usuario = @id
		AND R.baja_rl = 0
	ORDER BY
		R.descripcion_rl

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Funciones_x_Rol')
	DROP PROCEDURE NPM.P_Obtener_Funciones_x_Rol
GO 	

CREATE PROCEDURE NPM.P_Obtener_Funciones_x_Rol 
	@id int
AS
BEGIN 
	SELECT 
		F.*
	FROM 
		NPM.Funcion as F
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
	DROP PROCEDURE NPM.P_Obtener_Roles
GO 	

CREATE PROCEDURE NPM.P_Obtener_Roles  
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		R.*
	FROM 
		NPM.Rol as R
	WHERE
		(R.descripcion_rl like '%'+ @descripcion + '%' OR @descripcion IS NULL)
		AND (R.baja_rl = @baja OR @baja IS NULL)
	ORDER BY
		R.descripcion_rl

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='FX_Mostrar_Fecha')
	DROP FUNCTION NPM.FX_Mostrar_Fecha
GO 	

CREATE FUNCTION NPM.FX_Mostrar_Fecha(@fecha datetime)  
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
	DROP PROCEDURE NPM.P_Obtener_Funciones
GO 	

CREATE PROCEDURE NPM.P_Obtener_Funciones 
	@baja bit
AS
BEGIN 
	SELECT 
		F.*
	FROM 
		NPM.Funcion as F
	WHERE 
		F.baja_f = @baja
		AND F.descripcion_f <> 'ABM USUARIO'
	ORDER BY
		F.descripcion_f

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Rol')
	DROP PROCEDURE NPM.P_Guardar_Rol
GO 	

CREATE PROCEDURE NPM.P_Guardar_Rol 
	@id int, 
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	IF @id = 0
	BEGIN 
		INSERT INTO NPM.Rol (descripcion_rl, baja_rl)
		VALUES (@descripcion, @baja)

		SELECT id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		UPDATE NPM.Rol 
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
	DROP PROCEDURE NPM.P_Guardar_Funcion_x_Rol
GO 	

CREATE PROCEDURE NPM.P_Guardar_Funcion_x_Rol 
	@id_funcion int, 
	@id_rol int
AS
BEGIN 
	INSERT INTO NPM.Funciones_x_Rol(id_funcion, id_rol)
	VALUES (@id_funcion, @id_rol)
END
GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_Usuarios')
	DROP PROCEDURE NPM.P_Obtener_Usuarios
GO 	

CREATE PROCEDURE NPM.P_Obtener_Usuarios  
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
		NPM.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		NPM.Usuario as u
		LEFT JOIN NPM.Persona as p
			ON u.id_persona = p.id_persona
		LEFT JOIN NPM.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN NPM.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN NPM.Pais as pa
			ON pa.id_pais = d.id_pais
	WHERE
		(U.nombre_usuario like '%'+ @usuario + '%' OR @usuario IS NULL)
		AND (U.baja_u = @baja OR @baja IS NULL)
	ORDER BY
		U.nombre_usuario

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Obtener_TiposDocumento')
	DROP PROCEDURE NPM.P_Obtener_TiposDocumento
GO 	

CREATE PROCEDURE NPM.P_Obtener_TiposDocumento  
	@descripcion nvarchar(255),
	@baja bit
AS
BEGIN 
	SELECT 
		T.*
	FROM 
		NPM.Tipo_Documento as T
	WHERE
		(T.descripcion_td like '%'+ @descripcion + '%' OR @descripcion IS NULL)
		AND (T.baja_td = @baja OR @baja IS NULL)
	ORDER BY
		T.descripcion_td

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Usuario')
	DROP PROCEDURE NPM.P_Guardar_Usuario
GO 	

CREATE PROCEDURE NPM.P_Guardar_Usuario 
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
		INSERT INTO NPM.Usuario(nombre_usuario, pass, baja_u, intentos_fallidos, id_persona)
		VALUES (@nombre_usuario, HASHBYTES('SHA2_256', @pass), @baja, 0, @id_persona)

		SELECT @id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		IF @pass IS NULL
		BEGIN
			UPDATE NPM.Usuario
			SET 
				nombre_usuario = @nombre_usuario,
				baja_u = @baja,
				id_persona = @id_persona
			WHERE 
				 id_usuario = @id;
		END 
		ELSE
		BEGIN
			UPDATE NPM.Usuario
			SET 
				nombre_usuario = @nombre_usuario,
				pass = HASHBYTES('SHA2_256', @pass),
				baja_u = @baja,
				id_persona = @id_persona
			WHERE 
				 id_usuario = @id;
		END

		SELECT @id_out = @id;

		DELETE NPM.Usuario_x_Hotel
		WHERE 
			id_usuario = @id;

		DELETE NPM.Roles_x_Usuario
		WHERE 
			id_usuario = @id;

		RETURN @id_out;
	END

END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Rol_x_Usuario')
	DROP PROCEDURE NPM.P_Guardar_Rol_x_Usuario
GO 	

CREATE PROCEDURE NPM.P_Guardar_Rol_x_Usuario 
	@id_usuario int, 
	@id_rol int
AS
BEGIN 
	INSERT INTO NPM.Roles_x_Usuario(id_usuario, id_rol)
	VALUES (@id_usuario, @id_rol)
END

GO

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='P_Guardar_Cliente')
	DROP PROCEDURE NPM.P_Guardar_Cliente
GO 	
CREATE PROCEDURE [NPM].[P_Guardar_Cliente] 
	@id int, 
	@id_persona int,
	@baja bit, 
	@id_out int out
AS
BEGIN 
	IF @id = 0
	BEGIN 
		INSERT INTO NPM.Cliente(id_persona, baja_cl)
		VALUES (@id_persona, @baja)

		SELECT @id_out = @@IDENTITY
	END 
	ELSE 
	BEGIN 
		UPDATE NPM.Cliente
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
	DROP PROCEDURE NPM.P_Obtener_Clientes
GO 
CREATE PROCEDURE [NPM].[P_Obtener_Clientes]  
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
		NPM.FX_Mostrar_Fecha(p.fecha_nacimiento) as 'fecha_nacimiento',
		p.telefono,
		p.numero_documento,
		p.mail,
		p.inconsistente,
		t.*,
		d.*,
		pa.*
	FROM
		NPM.Cliente as c
		LEFT JOIN NPM.Persona as p
			ON c.id_persona = p.id_persona
		LEFT JOIN NPM.Direccion as d
			ON p.id_direccion = d.id_direccion
		LEFT JOIN NPM.Tipo_Documento as t
			ON p.id_tipo_documento = t.id_tipo_documento
		LEFT JOIN NPM.Pais as pa
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
	DROP PROCEDURE NPM.P_Validar_Mail_CLiente
GO 
CREATE PROCEDURE [NPM].[P_Validar_Mail_CLiente]
	@v_mail nvarchar(255),
	@v_flag bit = 0 out
AS
BEGIN
	SET NOCOUNT ON
	SET @v_flag = ISNULL((SELECT TOP 1 1 FROM NPM.Persona p WHERE p.mail = @v_mail),0)
	RETURN @v_flag
END
GO

print (CONCAT('INSERTS ', CONVERT(VARCHAR, GETDATE(), 114)))
---------------------------------- INSERTS ------------------------------
BEGIN TRY
BEGIN TRANSACTION
-- ROLES
INSERT INTO NPM.Rol VALUES 
('ADMINISTRADOR',0),
('EMPRESA',0),
('CLIENTE',0)

-- FUNCIONES
INSERT INTO NPM.Funcion VALUES 
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
--EXEC NPM.P_Alta_Persona 
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

--INSERT INTO NPM.Usuario VALUES
--('admin', HASHBYTES('SHA2_256', CONVERT(nvarchar(50), 'w23e')), 0, 0);

-- FUNCIONES X ROL
--INSERT INTO NPM.Funciones_x_Rol (id_rol, id_funcion) VALUES 
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
INSERT INTO NPM.Roles_x_Usuario (id_usuario, id_rol) VALUES (1, 1)

--TIPO_DOCUMENTO
INSERT NPM.Tipo_Documento VALUES ('DNI',0) 
INSERT NPM.Tipo_Documento VALUES ('PASAPORTE',0) 

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

-- FACTURA
ALTER TABLE [NPM].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Cliente] FOREIGN KEY([id_cliente])
REFERENCES [NPM].[Cliente] ([id_cliente])
GO

ALTER TABLE [NPM].[Factura] CHECK CONSTRAINT [FK_Factura_Cliente]
GO

ALTER TABLE [NPM].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Tipo_Pago] FOREIGN KEY([id_tipo_pago])
REFERENCES [NPM].[Tipo_Pago] ([id_tipo_pago])
GO

ALTER TABLE [NPM].[Factura] CHECK CONSTRAINT [FK_Factura_Tipo_Pago]
GO

ALTER TABLE [NPM].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Estadia] FOREIGN KEY([id_estadia])
REFERENCES [NPM].[Estadia] ([id_estadia])
GO

ALTER TABLE [NPM].[Factura] CHECK CONSTRAINT [FK_Factura_Estadia]
GO


-- FUNCIONES X ROL
ALTER TABLE [NPM].[Funciones_x_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funciones_x_Rol_Funcion] FOREIGN KEY([id_funcion])
REFERENCES [NPM].[Funcion] ([id_funcion])
GO

ALTER TABLE [NPM].[Funciones_x_Rol] CHECK CONSTRAINT [FK_Funciones_x_Rol_Funcion]
GO

ALTER TABLE [NPM].[Funciones_x_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funciones_x_Rol_Rol] FOREIGN KEY([id_rol])
REFERENCES [NPM].[Rol] ([id_rol])
GO

ALTER TABLE [NPM].[Funciones_x_Rol] CHECK CONSTRAINT [FK_Funciones_x_Rol_Rol]
GO

-- ITEM FACTURA
ALTER TABLE [NPM].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [FK_Item_Factura_Consumo] FOREIGN KEY([id_consumo])
REFERENCES [NPM].[Consumo] ([id_consumo])
GO

ALTER TABLE [NPM].[Item_Factura] CHECK CONSTRAINT [FK_Item_Factura_Consumo]
GO

ALTER TABLE [NPM].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [FK_Item_Factura_Factura] FOREIGN KEY([id_factura])
REFERENCES [NPM].[Factura] ([id_factura])
GO

ALTER TABLE [NPM].[Item_Factura] CHECK CONSTRAINT [FK_Item_Factura_Factura]
GO

-- ROLES X USUARIO
ALTER TABLE [NPM].[Roles_x_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Roles_x_Usuario_Rol] FOREIGN KEY([id_rol])
REFERENCES [NPM].[Rol] ([id_rol])
GO

ALTER TABLE [NPM].[Roles_x_Usuario] CHECK CONSTRAINT [FK_Roles_x_Usuario_Rol]
GO

ALTER TABLE [NPM].[Roles_x_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Roles_x_Usuario_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [NPM].[Usuario] ([id_usuario])
GO

ALTER TABLE [NPM].[Roles_x_Usuario] CHECK CONSTRAINT [FK_Roles_x_Usuario_Usuario]
GO

-- USUARIO 
ALTER TABLE [NPM].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Persona] FOREIGN KEY([id_persona])
REFERENCES [NPM].[Persona] ([id_persona])
GO

ALTER TABLE [NPM].[Usuario] CHECK CONSTRAINT [FK_Usuario_Persona]
GO

print (CONCAT('Fin del Script Inicial', CONVERT(VARCHAR, GETDATE(), 114)))