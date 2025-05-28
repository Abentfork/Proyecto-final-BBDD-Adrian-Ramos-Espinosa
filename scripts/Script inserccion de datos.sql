USE aseguradora;
-- 1. CLIENTES
INSERT INTO Clientes (ID_Cliente, DNI, Nombre, Telefono, Email)
VALUES 
(1, '12345678A', 'Juan Pérez', '600123456', 'juanp@gmail.com'),
(2, '23456789B', 'María López', '600234567', 'mlopez@gmail.com'),
(3, '34567890C', 'Carlos Ruiz', '600345678', 'cruiz@gmail.com');

-- 2. TIPOS_SEGURO
INSERT INTO Tipos_Seguro (ID_Tipo_Seguro, Nombre_Seguro, Cobertura, Prima_Base)
VALUES 
(1, 'Hogar', 'Daños, incendios, robos', 300.00),
(2, 'Coche', 'Accidentes, robo, terceros', 450.00),
(3, 'Vida', 'Fallecimiento, invalidez', 600.00);

-- 3. POLIZAS
INSERT INTO Polizas (ID_Poliza, ID_Cliente, ID_Tipo_Seguro, Fecha_Inicio, Fecha_Fin, Prima, Estado)
VALUES 
(1, 1, 1, '2024-01-01', '2025-01-01', 320.00, 'Activa'),
(2, 2, 2, '2024-03-01', '2025-03-01', 470.00, 'Activa'),
(3, 3, 3, '2023-06-15', '2024-06-15', 610.00, 'Vencida');

-- 4. RECLAMACIONES
INSERT INTO Reclamaciones (ID_Reclamacion, ID_Poliza, Fecha, Descripcion, Estado, Monto)
VALUES 
(1, 1, '2024-02-10', 'Daño por agua', 'Pendiente', 1200.00),
(2, 2, '2024-04-20', 'Accidente de tráfico', 'Procesado', 2500.00),
(3, 3, '2024-01-05', 'Cobro por invalidez', 'Aprobado', 10000.00);

-- 5. AGENTES
INSERT INTO Agentes (ID_Agente, Nombre, Email, Comision, Estado)
VALUES 
(1, 'Luis Torres', 'ltorres@aseg.com', 5.50, 'Activo'),
(2, 'Ana Gómez', 'agomez@aseg.com', 6.00, 'Activo'),
(3, 'Pedro Díaz', 'pdiaz@aseg.com', 4.75, 'Inactivo');

-- 6. PAGOS
INSERT INTO Pagos (ID_Pago, ID_Poliza, Fecha, Monto, Estado)
VALUES 
(1, 1, '2024-01-05', 320.00, 'Pagado'),
(2, 2, '2024-03-10', 470.00, 'Pagado'),
(3, 3, '2023-06-20', 610.00, 'Pendiente');

