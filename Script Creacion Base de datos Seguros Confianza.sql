-- Crear base de datos
CREATE DATABASE IF NOT EXISTS aseguradora;
USE aseguradora;

-- Tabla: CLIENTES
CREATE TABLE Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);

-- Tabla: TIPOS_SEGURO
CREATE TABLE Tipos_Seguro (
    ID_Tipo_Seguro INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Seguro VARCHAR(100) NOT NULL,
    Cobertura TEXT,
    Prima_Base DECIMAL(10, 2) NOT NULL
);

-- Tabla: POLIZAS
CREATE TABLE Polizas (
    ID_Poliza INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    ID_Tipo_Seguro INT NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Prima DECIMAL(10, 2) NOT NULL,
    Estado ENUM('Activa', 'Vencida', 'Cancelada') NOT NULL DEFAULT 'Activa',
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Tipo_Seguro) REFERENCES Tipos_Seguro(ID_Tipo_Seguro)
);

-- Tabla: RECLAMACIONES
CREATE TABLE Reclamaciones (
    ID_Reclamacion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Poliza INT NOT NULL,
    Fecha DATE NOT NULL,
    Descripcion TEXT,
    Estado ENUM('Pendiente', 'Aprobada', 'Rechazada') NOT NULL DEFAULT 'Pendiente',
    Monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Poliza) REFERENCES Polizas(ID_Poliza)
);

-- Tabla: AGENTES
CREATE TABLE Agentes (
    ID_Agente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Comision DECIMAL(5, 2), -- Porcentaje: ej. 15.25%
    Estado ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo'
);

-- Tabla: PAGOS
CREATE TABLE Pagos (
    ID_Pago INT AUTO_INCREMENT PRIMARY KEY,
    ID_Poliza INT NOT NULL,
    Fecha DATE NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Estado ENUM('Pendiente', 'Pagado', 'Retrasado') NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (ID_Poliza) REFERENCES Polizas(ID_Poliza)
);
