-- PRUEBAS DE FUNCIONAMIENTO
USE aseguradora;
-- Prueba numero 1: alta de cliente
SELECT * FROM Clientes;

INSERT INTO Clientes (DNI, Nombre, Telefono, Email)
VALUES ('12345778A', 'Juan Pérez', '612345678', 'juan@example.com');

-- Prueba numero 2: Alta de tipo de seguro

INSERT INTO Tipos_Seguro (Nombre_Seguro, Cobertura, Prima_Base)
VALUES ('Seguro de Hogar', 'Daños por incendio, robo y agua', 300.00);
 

-- Prueba numero 3: Prueba de error referencial

INSERT INTO Polizas (ID_Cliente, ID_Tipo_Seguro, Fecha_Inicio, Fecha_Fin, Prima)
VALUES (99, 1, '2024-01-01', '2025-01-01', 320.00);


-- Prueba numero 4: Prueba de eliminacion de un cliente con una poliza activa

DELETE FROM Clientes WHERE ID_Cliente = 1;

-- Prueba numero 5: mostrar todos los datos de los pagos de una poliza

SELECT * FROM Pagos WHERE ID_Poliza = 1;

-- Prueba numero 6: Cancelar una poliza con el procedimiento almacenado correspondiente

call aseguradora.CancelarPoliza(1);

SELECT * FROM Polizas
WHERE ID_Poliza = 1;


-- Prueba numero 7: Prueba de trigger que evita que un pago tenga un monto negativo

INSERT INTO Pagos (ID_Poliza, Fecha, Monto, Estado)
VALUES (1, CURDATE(), -50.00, 'Pendiente');


-- Prueba numero 8: Comprobacion de funcionamiento del trigger que cada ve que se inserta una reclamacion cambia la poliza correspondiente a "En revision"

-- Insertar una reclamacion para la poliza 1

INSERT INTO Reclamaciones (ID_Poliza, Fecha, Descripcion, Estado, Monto)
VALUES (1, CURDATE(), 'Daño en el vehículo', 'Pendiente', 500.00);

-- Consultar el esta de la poliza

SELECT Estado FROM Polizas WHERE ID_Poliza = 1;

-- Prueba numero 9: Comprobar la funcion que calcula el total de los pagos a una poliza

SELECT aseguradora.TotalPagado(1) AS TotalPagado;

-- Prueba numero 10: Comprobar el funcionamiento de la funciona DuracionPoliza

-- uso de la funcion
SELECT DuracionPoliza('2024-01-01', '2025-01-01') AS Duracion_Dias;

-- Comprobacion manual

SELECT ID_Poliza, Fecha_Inicio, Fecha_Fin,
       DuracionPoliza(Fecha_Inicio, Fecha_Fin) AS Duracion_Dias
FROM Polizas
LIMIT 5;





