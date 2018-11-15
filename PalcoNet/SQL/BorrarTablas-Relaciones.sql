USE GD2C2018;
GO
ALTER TABLE [MANG].[Canje] DROP CONSTRAINT [FK_Canje_Cliente]
GO
ALTER TABLE [MANG].[Canje] DROP CONSTRAINT [FK_Canje_Premio]
GO
ALTER TABLE [MANG].[Cliente] DROP CONSTRAINT [FK_Cliente_Tarjeta]
GO
ALTER TABLE [MANG].[Cliente] DROP CONSTRAINT [FK_Cliente_Tipo_Documento]
GO
ALTER TABLE [MANG].[Cliente] DROP CONSTRAINT [FK_Cliente_Usuario]
GO
ALTER TABLE [MANG].[Compra] DROP CONSTRAINT [FK_Compra_Cliente]
GO
ALTER TABLE [MANG].[Compra] DROP CONSTRAINT [FK_Compra_Ubicacion]
GO
ALTER TABLE [MANG].[Empresa] DROP CONSTRAINT [FK_Empresa_Usuario]
GO
ALTER TABLE [MANG].[Factura] DROP CONSTRAINT [FK_Factura_Empresa]
GO
ALTER TABLE [MANG].[Factura] DROP CONSTRAINT [FK_Factura_Forma_Pago]
GO
ALTER TABLE [MANG].[Funcion_x_Rol] DROP CONSTRAINT [FK_Funcion_x_Rol_Funcion]
GO
ALTER TABLE [MANG].[Funcion_x_Rol] DROP CONSTRAINT [FK_Funcion_x_Rol_Rol]
GO
ALTER TABLE [MANG].[Item_Factura] DROP CONSTRAINT [FK_Item_Factura_Compra]
GO
ALTER TABLE [MANG].[Item_Factura] DROP CONSTRAINT [FK_Item_Factura_Factura]
GO
ALTER TABLE [MANG].[Publicacion] DROP CONSTRAINT [FK_Publicacion_Empresa]
GO
ALTER TABLE [MANG].[Publicacion] DROP CONSTRAINT [FK_Publicacion_Estado_Publicacion]
GO
ALTER TABLE [MANG].[Publicacion] DROP CONSTRAINT [FK_Publicacion_Grado]
GO
ALTER TABLE [MANG].[Publicacion] DROP CONSTRAINT [FK_Publicacion_Rubro]
GO
ALTER TABLE [MANG].[Rol_x_Usuario] DROP CONSTRAINT [FK_Rol_x_Usuario_Rol]
GO
ALTER TABLE [MANG].[Rol_x_Usuario] DROP CONSTRAINT [FK_Rol_x_Usuario_Usuario]
GO
ALTER TABLE [MANG].[Show] DROP CONSTRAINT [FK_Show_Publicacion]
GO
ALTER TABLE [MANG].[Ubicacion] DROP CONSTRAINT [FK_Ubicacion_Publicacion]
GO
ALTER TABLE [MANG].[Ubicacion] DROP CONSTRAINT [FK_Ubicacion_Tipo_Ubicacion]
GO

--- TABLAS
-- Limpieza de datos
TRUNCATE TABLE [MANG].Cliente
TRUNCATE TABLE [MANG].Factura
TRUNCATE TABLE [MANG].Funcion
GO
TRUNCATE TABLE [MANG].Funciones_x_Rol
TRUNCATE TABLE [MANG].Item_Factura
TRUNCATE TABLE [MANG].Rol
GO
TRUNCATE TABLE [MANG].Roles_x_Usuario
TRUNCATE TABLE [MANG].Tipo_Documento
TRUNCATE TABLE [MANG].Tipo_Pago
TRUNCATE TABLE [MANG].Usuario

-- Borrado de tablas
GO
DROP TABLE [MANG].Cliente
DROP TABLE [MANG].Factura
DROP TABLE [MANG].Funcion
GO
DROP TABLE [MANG].Funcion_x_Rol
DROP TABLE [MANG].Item_Factura
DROP TABLE [MANG].Rol
GO
DROP TABLE [MANG].Rol_x_Usuario
DROP TABLE [MANG].Tipo_Documento
DROP TABLE [MANG].Forma_Pago
DROP TABLE [MANG].Usuario

GO


