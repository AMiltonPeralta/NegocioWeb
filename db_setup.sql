-- =======================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y TABLAS (TPC)
-- Proyecto: NegocioWeb
-- Instancia: (localdb)\MSSQLLocalDB
-- =======================================================

USE master;
GO

-- Recrear la base de datos si ya existe para asegurar consistencia
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'NegocioWebDB')
BEGIN
    ALTER DATABASE NegocioWebDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NegocioWebDB;
END
GO

CREATE DATABASE NegocioWebDB;
GO

USE NegocioWebDB;
GO

-- =======================================================
-- 1. TABLA: CATEGORIAS
-- =======================================================
CREATE TABLE Categorias (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 2. TABLA: MARCAS
-- =======================================================
CREATE TABLE Marcas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 3. TABLA: CLIENTES
-- =======================================================
CREATE TABLE Clientes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Documento VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NULL,
    Email VARCHAR(100) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 4. TABLA: PROVEEDORES
-- =======================================================
CREATE TABLE Proveedores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(50) NULL,
    Email VARCHAR(100) NULL,
    Direccion VARCHAR(200) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 5. TABLA: USUARIOS
-- =======================================================
CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Clave VARCHAR(100) NOT NULL,
    Rol VARCHAR(50) NOT NULL DEFAULT 'Vendedor', -- 'Administrador' o 'Vendedor'
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 6. TABLA: PRODUCTOS
-- =======================================================
CREATE TABLE Productos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    MarcaId INT NOT NULL FOREIGN KEY REFERENCES Marcas(Id),
    CategoriaId INT NOT NULL FOREIGN KEY REFERENCES Categorias(Id),
    StockActual INT NOT NULL DEFAULT 0,
    StockMinimo INT NOT NULL DEFAULT 0,
    PorcentajeGanancia DECIMAL(18,2) NOT NULL DEFAULT 0,
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =======================================================
-- 7. TABLA INTERMEDIA: PRODUCTOPROVEEDOR
-- =======================================================
CREATE TABLE ProductoProveedor (
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    ProveedorId INT NOT NULL FOREIGN KEY REFERENCES Proveedores(Id),
    PRIMARY KEY (ProductoId, ProveedorId)
);
GO

-- =======================================================
-- 8. TABLA: COMPRAS
-- =======================================================
CREATE TABLE Compras (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProveedorId INT NOT NULL FOREIGN KEY REFERENCES Proveedores(Id),
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(18,2) NOT NULL DEFAULT 0
);
GO

-- =======================================================
-- 9. TABLA: DETALLECOMPRAS
-- =======================================================
CREATE TABLE DetalleCompras (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CompraId INT NOT NULL FOREIGN KEY REFERENCES Compras(Id),
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    Cantidad INT NOT NULL,
    CostoUnitario DECIMAL(18,2) NOT NULL
);
GO

-- =======================================================
-- 10. TABLA: VENTAS
-- =======================================================
CREATE TABLE Ventas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NULL FOREIGN KEY REFERENCES Clientes(Id),
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(18,2) NOT NULL DEFAULT 0,
    NumeroFactura VARCHAR(50) NOT NULL
);
GO

-- =======================================================
-- 11. TABLA: DETALLEVENTAS
-- =======================================================
CREATE TABLE DetalleVentas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    VentaId INT NOT NULL FOREIGN KEY REFERENCES Ventas(Id),
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL
);
GO

-- =======================================================
-- 12. TABLA: PRECIOSCOMPRA
-- =======================================================
CREATE TABLE PreciosCompra (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductoId INT NOT NULL FOREIGN KEY REFERENCES Productos(Id),
    PrecioCompra DECIMAL(18,2) NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE()
);
GO


-- =======================================================
-- INSERCIÓN DE DATOS SEMILLA (SEEDING DATA)
-- =======================================================

-- 1. Insertar Categorías sugeridas
INSERT INTO Categorias (Nombre, Activo) VALUES 
('Útiles Escolares', 1),
('Cuadernos', 1),
('Papelería', 1),
('Tecnología Básica', 1),
('Limpieza', 1);
GO

-- 2. Insertar Marcas recomendadas
INSERT INTO Marcas (Nombre, Activo) VALUES 
('Faber-Castell', 1),
('Bic', 1),
('Filgo', 1),
('Simball', 1),
('Pizzini', 1),
('Maped', 1),
('Rivadavia', 1),
('Éxito', 1),
('Gloria', 1),
('Ledesma', 1),
('Autor', 1),
('Boreal', 1),
('Chamex', 1),
('Double A', 1),
('Casio', 1),
('Kingston', 1),
('SanDisk', 1),
('Logitech', 1),
('Genius', 1),
('Duracell', 1),
('Eveready', 1),
('Elite', 1),
('Campanita', 1),
('Ayudín', 1),
('Lysoform', 1),
('Procenex', 1),
('Poett', 1);
GO

-- 3. Insertar Clientes
INSERT INTO Clientes (Nombre, Documento, Telefono, Email, Activo) VALUES 
('Juan Pérez', '20-35489621-9', '011-4567-8910', 'juan.perez@email.com', 1),
('María Gómez', '27-38951234-5', '011-5432-1098', 'maria.gomez@email.com', 1),
('Carlos Rodríguez', '20-28147258-3', '0341-987-6543', 'carlos.rod@email.com', 0),
('Ana Martínez', '27-41025896-1', '0261-123-4567', 'ana.mtz@email.com', 1);
GO

-- 4. Insertar Proveedores
INSERT INTO Proveedores (Nombre, Telefono, Email, Direccion, Activo) VALUES 
('Distribuidora Ledesma', '011-4822-1234', 'ventas@ledesma-libreria.com', 'Av. del Libertador 4200, CABA', 1),
('Papelera San Martín', '011-4751-5678', 'contacto@papelerasm.com', 'Ruta 8 Km 22, San Martín', 1),
('Importadora TechHut', '0261-423-7890', 'pedidos@techhut.com.ar', 'San Martín 1500, Mendoza', 0),
('Pizzini Mayorista', '011-4981-2468', 'distribucion@pizzini.com', 'Corrientes 3400, CABA', 1);
GO

-- 5. Insertar Usuarios
INSERT INTO Usuarios (Nombre, Email, Clave, Rol, Activo) VALUES 
('Milton Peralta', 'milton.peralta@negocioweb.com', '123456', 'Administrador', 1),
('Juan Rodríguez', 'juan.rodriguez@negocioweb.com', '123456', 'Vendedor', 1),
('María Gómez', 'maria.gomez@negocioweb.com', '123456', 'Vendedor', 0);
GO

-- 6. Insertar Productos Iniciales
-- Categoría: Útiles Escolares (Id: 1)
-- Faber-Castell (Id: 1), Bic (Id: 2), Pizzini (Id: 5), Maped (Id: 6)
INSERT INTO Productos (Nombre, MarcaId, CategoriaId, StockActual, StockMinimo, PorcentajeGanancia, Activo) VALUES 
('Lápices de Colores x12 Ecolápiz', 1, 1, 50, 15, 35.00, 1),
('Bolígrafo Cristal Azul Trazo Medio', 2, 1, 200, 40, 40.00, 1),
('Juego de Geometría Técnico (Regla, Escuadra, Transportador)', 5, 1, 25, 5, 30.00, 1),
('Tijera Escolar Essentials 13cm', 6, 1, 40, 10, 35.00, 1);

-- Categoría: Cuadernos (Id: 2)
-- Rivadavia (Id: 7), Éxito (Id: 8), Gloria (Id: 9), Ledesma (Id: 10)
INSERT INTO Productos (Nombre, MarcaId, CategoriaId, StockActual, StockMinimo, PorcentajeGanancia, Activo) VALUES 
('Repuesto de Hojas Rivadavia Rayado x96', 7, 2, 80, 20, 30.00, 1),
('Cuaderno Universitario Espiral A4 Éxito 80 Hojas', 8, 2, 60, 15, 30.00, 1),
('Cuaderno Tapa Dura Gloria 84 Hojas Azul', 9, 2, 120, 30, 25.00, 1),
('Cuaderno Espiral Ledesma Ecológico A4', 10, 2, 45, 10, 35.00, 1);

-- Categoría: Papelería (Id: 3)
-- Ledesma (Id: 10), Boreal (Id: 12), Double A (Id: 14)
INSERT INTO Productos (Nombre, MarcaId, CategoriaId, StockActual, StockMinimo, PorcentajeGanancia, Activo) VALUES 
('Resma de Hojas A4 Ledesma 75g x500 Hojas', 10, 3, 150, 25, 25.00, 1),
('Resma Oficio Boreal 80g x500 Hojas', 12, 3, 90, 15, 20.00, 1),
('Resma Premium A4 Double A 80g', 14, 3, 35, 10, 30.00, 1);

-- Categoría: Tecnología Básica (Id: 4)
-- Casio (Id: 15), Kingston (Id: 16), Logitech (Id: 18), Duracell (Id: 20)
INSERT INTO Productos (Nombre, MarcaId, CategoriaId, StockActual, StockMinimo, PorcentajeGanancia, Activo) VALUES 
('Calculadora Científica Casio fx-82MS 240 funciones', 15, 4, 15, 3, 25.00, 1),
('Pendrive Kingston DataTraveler Exodia 64GB USB 3.2', 16, 4, 40, 8, 30.00, 1),
('Mouse Inalámbrico Logitech M170 Gris', 18, 4, 12, 4, 35.00, 1),
('Pilas AA Duracell Blister x4 unidades', 20, 4, 100, 20, 40.00, 1);

-- Categoría: Limpieza (Id: 5)
-- Elite (Id: 22), Ayudín (Id: 24), Procenex (Id: 26)
INSERT INTO Productos (Nombre, MarcaId, CategoriaId, StockActual, StockMinimo, PorcentajeGanancia, Activo) VALUES 
('Papel Higiénico Elite Doble Hoja x4 rollos', 22, 5, 60, 15, 30.00, 1),
('Desinfectante de Ambientes Ayudín Aerosol 360ml', 24, 5, 35, 10, 35.00, 1),
('Limpiador de Pisos Procenex Lavanda 900ml', 26, 5, 50, 12, 25.00, 1);
GO

-- 7. Insertar algunos Precios de Compra iniciales
INSERT INTO PreciosCompra (ProductoId, PrecioCompra) VALUES 
(1, 1000.00), -- Ecolápiz Faber
(2, 150.00),  -- Bic
(3, 4000.00), -- Juego Geom. Pizzini
(4, 800.00),  -- Tijera Maped
(5, 1500.00), -- Repuesto Rivadavia
(6, 1200.00), -- Univ Exito
(7, 600.00),  -- Gloria
(8, 1400.00), -- Ecol Ledesma
(9, 4500.00), -- Resma Ledesma
(10, 4800.00),-- Resma Boreal
(11, 6500.00),-- Resma DoubleA
(12, 12000.00),-- Casio
(13, 3500.00),-- USB Kingston
(14, 5500.00),-- Mouse Logi
(15, 1200.00),-- Pilas Dura
(16, 800.00), -- Elite
(17, 1000.00),-- Ayudin
(18, 700.00);  -- Procenex
GO

-- 8. Relacionar Productos con Proveedores en ProductoProveedor
-- Distribuidora Ledesma vende productos Ledesma, Faber y Bic (Ids: 1, 2, 5, 8, 9)
INSERT INTO ProductoProveedor (ProductoId, ProveedorId) VALUES 
(1, 1), (2, 1), (5, 1), (8, 1), (9, 1);
-- Papelera San Martín vende repuestos, cuadernos, resmas y tijeras (Ids: 4, 5, 6, 7, 10, 11)
INSERT INTO ProductoProveedor (ProductoId, ProveedorId) VALUES 
(4, 2), (5, 2), (6, 2), (7, 2), (10, 2), (11, 2);
-- Pizzini Mayorista vende Pizzini (Id: 3)
INSERT INTO ProductoProveedor (ProductoId, ProveedorId) VALUES 
(3, 4);
GO
