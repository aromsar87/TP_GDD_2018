-- -----------------------------------------------------
-- BD --
-- -----------------------------------------------------

USE [GD2C2018];
GO

-- -----------------------------------------------------
-- Creación de Schema EL_GROUP_BY
-- -----------------------------------------------------

IF (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'EL_GROUP_BY') IS NOT NULL
	DROP SCHEMA EL_GROUP_BY
GO

CREATE SCHEMA [EL_GROUP_BY] AUTHORIZATION [gdEspectaculos2018]
GO

-- -----------------------------------------------------
-- Configuraciones
-- -----------------------------------------------------

SET NOCOUNT ON
GO

-- -----------------------------------------------------
-- Borramos las tablas
-- -----------------------------------------------------

IF OBJECT_ID('EL_GROUP_BY.Rol') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Rol;
GO

IF OBJECT_ID('EL_GROUP_BY.Usuario') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Usuario;
GO

IF OBJECT_ID('EL_GROUP_BY.Funcionalidad') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Funcionalidad;
GO

IF OBJECT_ID('EL_GROUP_BY.Cliente') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Cliente;
GO

IF OBJECT_ID('EL_GROUP_BY.Empresa') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Empresa;
GO

IF OBJECT_ID('EL_GROUP_BY.Rubro') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Rubro;
GO

IF OBJECT_ID('EL_GROUP_BY.Espectaculo') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Espectaculo;
GO

IF OBJECT_ID('EL_GROUP_BY.Ubicacion_Tipo') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Ubicacion_Tipo;
GO

IF OBJECT_ID('EL_GROUP_BY.Ubicacion') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Ubicacion;
GO

IF OBJECT_ID('EL_GROUP_BY.Grado_Publicacion') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Grado_Publicacion;
GO

IF OBJECT_ID('EL_GROUP_BY.Publicacion') IS NOT NULL
	DROP TABLE EL_GROUP_BYPublicacion.;
GO

IF OBJECT_ID('EL_GROUP_BY.Factura') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Factura;
GO

IF OBJECT_ID('EL_GROUP_BY.Forma_Pago') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Forma_Pago;
GO

IF OBJECT_ID('EL_GROUP_BY.Compra') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Compra;
GO

IF OBJECT_ID('EL_GROUP_BY.Item') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Item;
GO

IF OBJECT_ID('EL_GROUP_BY.Puntos') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Puntos;
GO

IF OBJECT_ID('EL_GROUP_BY.Rol_Funcionalidad') IS NOT NULL
	DROP TABLE EL_GROUP_BY.Rol_Funcionalidad;
GO

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Rol
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Rol (
  Rol_ID INT IDENTITY(1,1),
  Rol_Nombre NVARCHAR(20) NOT NULL,
  Rol_Habilitado BIT NOT NULL,
  PRIMARY KEY (Rol_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Funcionalidad
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Funcionalidad (
  Fun_ID INT IDENTITY(1,1),
  Fun_Nombre NVARCHAR(30) NOT NULL,
  Fun_visible BIT,
  PRIMARY KEY (Fun_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Rol_Funcionalidad
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Rol_Funcionalidad (
  Rol_ID INT,
  Funcionalidad_ID INT NOT NULL,
  PRIMARY KEY (Funcionalidad_ID, Rol_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Rol_Usuario
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.ROL_USUARIO(
	USUARIO_ID int,
	ROL_ID int not null,
	ROL_USUARIO_ESTADO bit,
	PRIMARY KEY (USUARIO_ID, ROL_ID)
);

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Usuario
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Usuario (
  Usuario_ID INT NOT NULL IDENTITY(1,1),
  Usuario_Username NVARCHAR(50) NOT NULL,
  Usuario_Password NVARCHAR(50) NOT NULL,
  Usuario_Tipo NVARCHAR(20) NOT NULL,
  Usuario_Habilitado BIT NOT NULL,
  Usuario_Intentos SMALLINT NOT NULL,
  Usuario_Mail NVARCHAR(255),
  Usuario_Telefono NVARCHAR(20),
  Usuario_Calle NVARCHAR(255),
  Usuario_Numero_Calle NUMERIC(18,0),
  Usuario_Piso NUMERIC(18,0),
  Usuario_Depto NVARCHAR(255),
  Usuario_Codigo_Postal NVARCHAR(255),
  PRIMARY KEY (Usuario_ID))
;

CREATE UNIQUE INDEX Usuario_Username_UNIQUE ON EL_GROUP_BY.Usuario (Usuario_Username ASC);

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Cliente
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Cliente (
  Cliente_ID INT NOT NULL IDENTITY(1,1),
  Cliente_Nombre NVARCHAR(255),
  Cliente_Apellido NVARCHAR(255),
  Cliente_Tipo_Documento NVARCHAR(10),
  Cliente_Numero_Documento NUMERIC(18,0),
  Cliente_Cuil NVARCHAR(20),
  Cliente_Fecha_Nacimiento DATETIME,
  Cliente_Tarjeta_Marca NVARCHAR(20),
  Cliente_Tarjeta_Numero NUMERIC(16,0),
  Cliente_Fecha_Creacion DATETIME,
  Usuario_ID INT,
  PRIMARY KEY (Cliente_ID),
  CONSTRAINT FK_Cliente_Usuario_ID FOREIGN KEY (Usuario_ID)     
    REFERENCES EL_GROUP_BY.Usuario (Usuario_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

CREATE UNIQUE INDEX Cliente_Tipo_Documento_UNIQUE ON EL_GROUP_BY.Cliente (Cliente_Tipo_Documento ASC);

CREATE UNIQUE INDEX Cliente_Numero_Documento_UNIQUE ON EL_GROUP_BY.Cliente (Cliente_Numero_Documento ASC);

CREATE UNIQUE INDEX Cliente_Cuil_UNIQUE ON EL_GROUP_BY.Cliente (Cliente_Cuil ASC);


-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Empresa
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Empresa (
  Empresa_ID INT NOT NULL IDENTITY(1,1),
  Empresa_Razon_Social NVARCHAR(255) NOT NULL,
  Empresa_Cuit NVARCHAR(255) NOT NULL,
  Empresa_Ciudad NVARCHAR(50),
  Empresa_Fecha_Creacion DATETIME,
  Usuario_ID INT,
  PRIMARY KEY (Empresa_ID),
  CONSTRAINT FK_Empresa_Usuario_ID FOREIGN KEY (Usuario_ID)     
    REFERENCES EL_GROUP_BY.Usuario (Usuario_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

CREATE UNIQUE INDEX Empresa_Razon_Social_UNIQUE ON EL_GROUP_BY.Empresa (Empresa_Razon_Social ASC);

CREATE UNIQUE INDEX Empresa_Cuit_UNIQUE ON EL_GROUP_BY.Empresa (Empresa_Cuit ASC);

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Rubro
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Rubro (
  Rubro_ID INT NOT NULL,
  Rubro_Descripcion NVARCHAR(255) NOT NULL,
  PRIMARY KEY (Rubro_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Espectaculo
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Espectaculo (
  Espectaculo_ID INT NOT NULL,
  Espectaculo_Codigo NUMERIC(18,0) NOT NULL,
  Espectaculo_Descripcion NVARCHAR(255) NOT NULL,
  Espectaculo_Fecha DATETIME NOT NULL,
  Espectaculo_Fecha_Vencimiento DATETIME NOT NULL,
  Espectaculo_Estado NVARCHAR(255) NOT NULL,
  Espectaculo_Ubicaciones_Disponibles NUMERIC(18,0) NOT NULL,
  Espectaculo_Total_Ubicaciones NUMERIC(18,0) NOT NULL,
  Rubro_ID INT NOT NULL,
  PRIMARY KEY (Espectaculo_ID),
  CONSTRAINT FK_Espectaculo_Rubro_ID FOREIGN KEY (Rubro_ID)     
    REFERENCES EL_GROUP_BY.Rubro (Rubro_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Ubicacion_Tipo
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Ubicacion_Tipo (
  Ubicacion_Tipo_ID INT NOT NULL,
  Ubicacion_Tipo_Codigo NUMERIC(18,0) NOT NULL,
  Ubicacion_Tipo_Descripcion NVARCHAR(255) NOT NULL,
  PRIMARY KEY (Ubicacion_Tipo_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Ubicacion
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Ubicacion (
  Ubicacion_ID INT NOT NULL,
  Ubicacion_Fila VARCHAR(3) NULL,
  Ubicacion_Asiento NUMERIC(18,0) NULL,
  Ubicacion_Sin_Numerar BIT NOT NULL,
  Ubicacion_Precio NUMERIC(18,0) NOT NULL,
  Ubicacion_Disponible BIT NOT NULL,
  Ubicacion_Tipo_ID INT NOT NULL,
  Espectaculo_ID INT NOT NULL,
  PRIMARY KEY (Ubicacion_ID),
  CONSTRAINT FK_Ubicacion_Espectaculo_ID FOREIGN KEY (Espectaculo_ID)     
    REFERENCES EL_GROUP_BY.Espectaculo (Espectaculo_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Grado_Publicacion
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Grado_Publicacion (
  Grado_Publicacion_ID INT NOT NULL,
  Grado_Publicacion_Comision NUMERIC(3,3) NOT NULL,
  Grado_Publicacion_Prioridad NVARCHAR(10) NOT NULL,
  PRIMARY KEY (Grado_Publicacion_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Publicacion
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Publicacion (
  Publicacion_ID INT NOT NULL,
  Publicacion_Descripcion_Inicio NVARCHAR(255) NOT NULL,
  Publicacion_Fecha DATETIME NOT NULL,
  Publicacion_Estado NVARCHAR(255) NOT NULL,
  Publicacion_Cantidad_Localidades NUMERIC(7,0) NOT NULL,
  Usuario_ID INT NOT NULL,
  Grado_Publicacion_ID INT NOT NULL,
  Espectaculo_ID INT NOT NULL,
  PRIMARY KEY (Publicacion_ID),
  CONSTRAINT FK_Publicacion_Usuario_ID FOREIGN KEY (Usuario_ID)     
    REFERENCES EL_GROUP_BY.Usuario (Usuario_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
  CONSTRAINT FK_Publicacion_Grado_Publicacion_ID FOREIGN KEY (Grado_Publicacion_ID)     
    REFERENCES EL_GROUP_BY.Grado_Publicacion (Grado_Publicacion_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
  CONSTRAINT FK_Publicacion_Espectaculo_ID FOREIGN KEY (Espectaculo_ID)     
    REFERENCES EL_GROUP_BY.Espectaculo (Espectaculo_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Factura
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Factura (
  Factura_ID INT NOT NULL,
  Factura_Nro NUMERIC(18,0) NOT NULL,
  Factura_Fecha DATETIME NOT NULL,
  Factura_Total NUMERIC(18,2) NOT NULL,
  PRIMARY KEY (Factura_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Forma_Pago
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Forma_Pago (
  Forma_Pago_ID INT NOT NULL,
  Forma_Pago_Descripcion NVARCHAR(255) NOT NULL,
  PRIMARY KEY (Forma_Pago_ID))
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Compra
-- -----------------------------------------------------

CREATE TABLE EL_GROUP_BY.Compra (
  Compra_ID INT NOT NULL,
  Compra_Fecha DATETIME NOT NULL,
  Compra_Cantidad NUMERIC(18,0) NOT NULL,
  Factura_ID INT NOT NULL,
  Usuario_ID INT NOT NULL,
  Forma_Pago_ID INT NOT NULL,
  PRIMARY KEY (Compra_ID),
  CONSTRAINT FK_Compra_Factura_ID FOREIGN KEY (Factura_ID)     
    REFERENCES EL_GROUP_BY.Factura (Factura_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
  CONSTRAINT FK_Compra_Usuario_ID FOREIGN KEY (Usuario_ID)     
    REFERENCES EL_GROUP_BY.Usuario (Usuario_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
  CONSTRAINT FK_Compra_Forma_Pago_ID FOREIGN KEY (Forma_Pago_ID)     
    REFERENCES EL_GROUP_BY.Forma_Pago (Forma_Pago_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Item
-- -----------------------------------------------------


CREATE TABLE EL_GROUP_BY.Item (
  Item_ID INT NOT NULL,
  Item_Monto NUMERIC(18,2) NOT NULL,
  Item_Cantidad NUMERIC(18,0) NOT NULL,
  Item_Descripcion NVARCHAR(60) NOT NULL,
  Factura_ID INT NOT NULL,
  PRIMARY KEY (Item_ID),
  CONSTRAINT FK_Item_Factura_ID FOREIGN KEY (Factura_ID)     
    REFERENCES EL_GROUP_BY.Factura (Factura_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;

-- -----------------------------------------------------
-- Creación de Tabla EL_GROUP_BY.Puntos
-- -----------------------------------------------------


CREATE TABLE EL_GROUP_BY.Puntos (
  Puntos_ID INT NOT NULL,
  Puntos_Cantidad NUMERIC(18,0) NOT NULL,
  Puntos_Fecha_Vencimiento DATETIME NOT NULL,
  Cliente_ID INT NOT NULL,
  PRIMARY KEY (Puntos_ID),
  CONSTRAINT FK_Puntos_Cliente_ID FOREIGN KEY (Cliente_ID)     
    REFERENCES EL_GROUP_BY.Cliente (Cliente_ID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE)
;
GO
-- -----------------------------------------------------
-- Funciones
-- -----------------------------------------------------

-- ME DEVUELVE EL ID_USUARIO
CREATE FUNCTION EL_GROUP_BY.FUNC_COD_USUARIO(@USU NVARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @RESULTADO INT
	SELECT @RESULTADO = Usuario_ID FROM EL_GROUP_BY.USUARIO WHERE Usuario_Username = @USU
	RETURN @RESULTADO
END;
GO

-- -----------------------------------------------------
-- Cargar Usuarios
-- -----------------------------------------------------
GO

CREATE PROC EL_GROUP_BY.CARGAR_USUARIOS
AS
BEGIN TRAN
	INSERT INTO EL_GROUP_BY.USUARIO
	SELECT DISTINCT (Cli_Nombre + CONVERT(NVARCHAR(50),Cli_Dni))
					,HASHBYTES('SHA2_256', CONVERT(NVARCHAR(50),Cli_Dni))
					,'CLIENTE'
					,1
					,0
					,Cli_Mail
					,null
					,Cli_Dom_Calle
					,Cli_Nro_Calle
					,Cli_Piso
					,Cli_Depto
					,Cli_Cod_Postal
		FROM gd_esquema.Maestra
		WHERE Cli_Dni IS NOT NULL
		UNION
		SELECT DISTINCT CONVERT(NVARCHAR(50),Espec_Empresa_Cuit)
					,HASHBYTES('SHA2_256', CONVERT(NVARCHAR(50),Espec_Empresa_Cuit))
					,'EMPRESA'
					,1
					,0
					,Espec_Empresa_Mail
					,null
					,Espec_Empresa_Dom_Calle
					,Espec_Empresa_Nro_Calle
					,Espec_Empresa_Piso
					,Espec_Empresa_Depto
					,Espec_Empresa_Cod_Postal
		FROM gd_esquema.Maestra
		WHERE Espec_Empresa_Cuit IS NOT NULL

	INSERT INTO EL_GROUP_BY.USUARIO VALUES
		(CONVERT(NVARCHAR(50),'admin')
		,HASHBYTES('SHA2_256', CONVERT(NVARCHAR(50),'w23e'))
		,'ADMINISTRADOR'
		,1
		,0
		,'admin@frba.com'
		,15123123
		,'Calle Falsa'
		,123
		,null
		,null
		,'1990')
COMMIT
GO

-- -----------------------------------------------------
-- Cargar Clientes
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_CLIENTES AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.Cliente 
	SELECT DISTINCT Cli_Nombre
		            ,Cli_Apeliido
					,'DNI'
					,Cli_Dni
					,null
					,Cli_Fecha_Nac
					,null
					,null
					,null
					,EL_GROUP_BY.FUNC_COD_USUARIO(Cli_Nombre + CONVERT(NVARCHAR(50),Cli_Dni))
		FROM gd_esquema.Maestra
		WHERE Cli_Dni IS NOT NULL

	-- Acá cargaremos al admin como un cliente más
	INSERT INTO EL_GROUP_BY.Cliente
		VALUES ('admin'
			,'admin'
			,'DNI'
			,35123123
			,null
			,CONVERT(DATETIME,'1990/02/02 00:00:00',121)
			,'SANTANDER RIO'
			,4242424242424242
			,CONVERT(DATETIME,'2018/02/02 00:00:00',121)
			,783)
COMMIT
GO

-- -----------------------------------------------------
-- Cargar Empresas
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_EMPRESAS AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.Empresa
	SELECT DISTINCT Espec_Empresa_Razon_Social
		            ,Espec_Empresa_Cuit
					,null
					,null
					,EL_GROUP_BY.FUNC_COD_USUARIO(CONVERT(NVARCHAR(50),Espec_Empresa_Cuit))
		FROM gd_esquema.Maestra
		WHERE Espec_Empresa_Cuit IS NOT NULL

	-- Acá cargaremos al admin como una empresa más
	INSERT INTO EL_GROUP_BY.Empresa
		VALUES ('RAZON SOCIAL X'
		    ,'30-71031609-7'
			,null
			,CONVERT(DATETIME,'1980/02/02 00:00:00',121)
			,783)
COMMIT
GO

-- -----------------------------------------------------
-- Cargar Roles
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_ROLES AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.ROL VALUES ('CLIENTE',1)
	INSERT INTO EL_GROUP_BY.ROL VALUES ('EMPRESA',1)
	INSERT INTO EL_GROUP_BY.ROL VALUES ('ADMINISTRADOR',1)
COMMIT;
GO

-- -----------------------------------------------------
-- Cargar Funcionalidades
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_FUNCIONALIDADES AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('ABM_ROL',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('ABM_CLIENTE',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('ABM_EMPRESA',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('ABM_RUBRO',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('ABM_GRADO_PUBLICACION',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('GENERAR_PUBLICACION',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('EDITAR_PUBLICACION',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('COMPRAR',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('HISTORIAL_CLIENTE',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('CANJE_ADMINISTRACION_PUNTOS',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('GENERAR_PAGO_COMISIONES',1)
	INSERT INTO EL_GROUP_BY.FUNCIONALIDAD VALUES ('LISTADO_ESTADISTICO',1)
COMMIT;
GO

-- -----------------------------------------------------
-- Cargar Roles_X_Usuario
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_ROLES_X_USUARIO AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.ROL_USUARIO
			SELECT Usuario_ID,
					1,
					1
			FROM EL_GROUP_BY.USUARIO
			WHERE Usuario_Username = 'admin'
	UNION
			SELECT Usuario_ID,
					2,
					1
		FROM EL_GROUP_BY.USUARIO
		WHERE Usuario_Username = 'admin'
	UNION
			SELECT Usuario_ID,
					3,
					1
		FROM EL_GROUP_BY.USUARIO
		WHERE Usuario_Username = 'admin'
	UNION
		SELECT USUARIO_ID,
				ROL_ID,
				1
			FROM EL_GROUP_BY.Cliente, EL_GROUP_BY.ROL
			WHERE Rol_Nombre = 'CLIENTE'
	UNION
		SELECT USUARIO_ID,
				ROL_ID,
				1
			FROM EL_GROUP_BY.Empresa, EL_GROUP_BY.ROL
			WHERE Rol_Nombre = 'EMPRESA'

COMMIT;
GO

-- -----------------------------------------------------
-- Cargar Roles_X_Funcionalidad
-- -----------------------------------------------------

CREATE PROCEDURE EL_GROUP_BY.CARGAR_ROLES_X_FUNCIONALIDAD AS
BEGIN TRANSACTION
	INSERT INTO EL_GROUP_BY.ROL_FUNCIONALIDAD
		SELECT Rol_ID,
				FUN_ID
			FROM EL_GROUP_BY.ROL R, EL_GROUP_BY.FUNCIONALIDAD F
			WHERE R.Rol_Nombre = 'ADMINISTRADOR' AND
					(F.FUN_ID = 1 OR
					F.FUN_ID = 2 OR
					F.FUN_ID = 3)
	UNION
		SELECT Rol_ID,
				Fun_ID
			FROM EL_GROUP_BY.ROL R, EL_GROUP_BY.FUNCIONALIDAD F
			WHERE R.Rol_Nombre = 'CLIENTE' AND
					(F.Fun_ID = 8 OR
					F.Fun_ID = 9 OR
					F.Fun_ID = 10 OR
					F.Fun_ID = 12)
	UNION
		SELECT Rol_ID,
				Fun_ID
			FROM EL_GROUP_BY.ROL R, EL_GROUP_BY.FUNCIONALIDAD F
			WHERE R.Rol_Nombre = 'EMPRESA' AND
					(F.Fun_ID = 4 OR
						F.Fun_ID = 5 OR
						F.Fun_ID = 6 OR
						F.Fun_ID = 7 OR
						F.Fun_ID = 11)
COMMIT TRANSACTION;
GO

-- -----------------------------------------------------
-- SPs
-- -----------------------------------------------------

create procedure EL_GROUP_BY.BUSCAR_USUARIO @Usuario nvarchar(50), @Password nvarchar(50)
as
begin 
	declare @habilitado bit
	declare @cant_int_fallido int

	select @habilitado = Usuario_Habilitado from EL_GROUP_BY.USUARIO where Usuario_Username =  @Usuario and Usuario_Password = HASHBYTES('SHA2_256',@Password)
	select @cant_int_fallido = Usuario_Intentos from EL_GROUP_BY.USUARIO where Usuario_Username = @Usuario

	if not exists(select 1 from EL_GROUP_BY.USUARIO where Usuario_Username = @Usuario)
		select 0 as estado
	if exists(select 1 from EL_GROUP_BY.USUARIO where Usuario_Username = @Usuario and Usuario_Password <> HASHBYTES('SHA2_256',@Password))
		if (@cant_int_fallido = 3) 
			begin
				update EL_GROUP_BY.USUARIO set Usuario_Habilitado = 0 where Usuario_Username = @Usuario
				select 2 as estado
			end
		else select 1 as estado
	if @habilitado = 0
		select 2 as estado
	if @habilitado = 1
		begin
			if @cant_int_fallido = 1 or @cant_int_fallido = 2
				update EL_GROUP_BY.USUARIO set Usuario_Intentos = 0 where Usuario_Username = @Usuario
			select 3 as estado
		end
end
go

create procedure EL_GROUP_BY.REG_INTENTO_FALLIDO @Usuario varchar(50)
as
begin
	declare @cant_int_fallido int
	select @cant_int_fallido = Usuario_Intentos from EL_GROUP_BY.USUARIO where Usuario_Username = @Usuario

	if @cant_int_fallido between 0 and 2
		update EL_GROUP_BY.USUARIO set Usuario_Intentos = Usuario_Intentos + 1 where Usuario_Username = @Usuario
end
go

create procedure EL_GROUP_BY.OBTENER_ID_USUARIO @USUARIO varchar(50)
as
begin
	select USUARIO_ID from EL_GROUP_BY.USUARIO where Usuario_Username = @USUARIO
end
go

create procedure EL_GROUP_BY.OBTENER_CANT_ROLES @USU_ID int
as
begin
	select count(USUARIO_ID) from EL_GROUP_BY.ROL_USUARIO where USUARIO_ID = @USU_ID and ROL_USUARIO_ESTADO = 1  
end
go

create procedure EL_GROUP_BY.OBTENER_ROLES_ACTIVOS @ID int
as
begin
	select R.Rol_Nombre, R.ROL_ID from EL_GROUP_BY.ROL R inner join EL_GROUP_BY.ROL_USUARIO RXU 
		on R.ROL_ID = RXU.ROL_ID where RXU.USUARIO_ID = @ID and R.Rol_Habilitado = 1 
end
go

create procedure EL_GROUP_BY.OBTENER_FUNCIONALIDADES_X_ROL @ROL_ID int
as
begin
	select F.Fun_ID from EL_GROUP_BY.FUNCIONALIDAD F inner join EL_GROUP_BY.ROL_FUNCIONALIDAD RXU 
		on F.Fun_ID = RXU.Funcionalidad_ID where RXU.Rol_ID = @ROL_ID and F.Fun_visible = 1 
end
go

create procedure EL_GROUP_BY.GUARDAR_ROL @nombre varchar(25), @habilitado bit
as
begin
	insert into EL_GROUP_BY.ROL values (@nombre, @habilitado);
end
go

create procedure EL_GROUP_BY.DAME_ID_X_NOMBRE @nombre varchar(25)
as
begin
	select Rol_ID from EL_GROUP_BY.ROL where Rol_Nombre = @nombre 
end
go

create procedure EL_GROUP_BY.ELIMINAR_ROL @ID int
as
begin
	update EL_GROUP_BY.ROL set Rol_Habilitado = 0 where Rol_ID = @ID;
end
go

create procedure EL_GROUP_BY.AGREGAR_FUNCIONALIDAD_A_ROL @ROL_ID INT, @FUNCIONALIDAD_ID INT
as
begin
	insert into EL_GROUP_BY.ROL_FUNCIONALIDAD values (@ROL_ID,@FUNCIONALIDAD_ID)
end
go

create procedure EL_GROUP_BY.ELIMINAR_FUNCIONALIDAD_A_ROL @ROL_ID INT, @FUNCIONALIDAD_ID INT
as
begin
	delete from EL_GROUP_BY.ROL_FUNCIONALIDAD where Rol_ID = @ROL_ID and FUNCIONALIDAD_ID = @FUNCIONALIDAD_ID
end
go

create procedure EL_GROUP_BY.LISTAR_FUNCIONES_X_ROL @ROL_ID int
as
begin
	select f.* from EL_GROUP_BY.ROL_FUNCIONALIDAD as rxf inner join EL_GROUP_BY.FUNCIONALIDAD as f
		   on rxf.FUNCIONALIDAD_ID = f.FUN_ID where rxf.Rol_ID = @ROL_ID;
end
go

create procedure EL_GROUP_BY.LISTAR_FUNCIONES_X_ROL_NO_ASIGNADAS @ROL_ID int
as
begin
	select * from EL_GROUP_BY.FUNCIONALIDAD except 
									     select f.* from EL_GROUP_BY.ROL_FUNCIONALIDAD as rxf inner join EL_GROUP_BY.FUNCIONALIDAD as f
										 on rxf.Funcionalidad_ID = f.Fun_ID where rxf.Rol_ID = @ROL_ID;
end
go

--------------------------------------------------------
-- Borrador para hacer algunas pruebas
--------------------------------------------------------
select Cli_Dni from gd_esquema.Maestra where Cli_Dni is not null;
drop table EL_GROUP_BY.Usuario;
drop proc EL_GROUP_BY.CARGAR_USUARIOS;

exec EL_GROUP_BY.CARGAR_USUARIOS;

select * from EL_GROUP_BY.Usuario;
select * from EL_GROUP_BY.Cliente where Usuario_ID = 3;

exec EL_GROUP_BY.CARGAR_CLIENTES;

drop table EL_GROUP_BY.Cliente;
drop proc EL_GROUP_BY.CARGAR_CLIENTES;

select * from EL_GROUP_BY.Cliente;

drop table EL_GROUP_BY.Empresa;
drop proc EL_GROUP_BY.CARGAR_EMPRESAS;

exec EL_GROUP_BY.CARGAR_EMPRESAS;

select * from EL_GROUP_BY.Empresa;

exec EL_GROUP_BY.CARGAR_ROLES;

select * from EL_GROUP_BY.Rol;

exec EL_GROUP_BY.CARGAR_FUNCIONALIDADES;
drop table EL_GROUP_BY.Funcionalidad;
drop proc EL_GROUP_BY.CARGAR_FUNCIONALIDADES;

select * from EL_GROUP_BY.Funcionalidad;

exec EL_GROUP_BY.CARGAR_ROLES_X_USUARIO;

select * from EL_GROUP_BY.ROL_USUARIO;

exec EL_GROUP_BY.CARGAR_ROLES_X_FUNCIONALIDAD;
drop table EL_GROUP_BY.Rol_Funcionalidad;

select * from EL_GROUP_BY.Rol_Funcionalidad;
