USE aseguradora; 
-- Clientes con polizas activas
SELECT c.Nombre, p.ID_Poliza, p.Fecha_Inicio, p.Fecha_Fin, p.Estado
FROM Clientes c
JOIN Polizas p ON c.ID_Cliente = p.ID_Cliente
WHERE p.Estado = 'Activa';

-- Suma total de pagos realizados por cada cliente

SELECT c.Nombre, SUM(pg.Monto) AS TotalPagado
FROM Clientes c
JOIN Polizas p ON c.ID_Cliente = p.ID_Cliente
JOIN Pagos pg ON p.ID_Poliza = pg.ID_Poliza
WHERE pg.Estado = 'Pagado'
GROUP BY c.Nombre;

-- Cantidad de reclamaciones por tipo de seguro

SELECT ts.Nombre_Seguro, COUNT(r.ID_Reclamacion) AS TotalReclamaciones
FROM Tipos_Seguro ts
JOIN Polizas p ON ts.ID_Tipo_Seguro = p.ID_Tipo_Seguro
JOIN Reclamaciones r ON p.ID_Poliza = r.ID_Poliza
GROUP BY ts.Nombre_Seguro;

-- Clientes con mas de 2 reclamaciones

SELECT c.Nombre, COUNT(r.ID_Reclamacion) AS Reclamaciones
FROM Clientes c
JOIN Polizas p ON c.ID_Cliente = p.ID_Cliente
JOIN Reclamaciones r ON p.ID_Poliza = r.ID_Poliza
GROUP BY c.Nombre
HAVING COUNT(r.ID_Reclamacion) > 2;

-- Prima promedio por tipo de seguro

SELECT ts.Nombre_Seguro, AVG(p.Prima) AS PromedioPrima
FROM Tipos_Seguro ts
JOIN Polizas p ON ts.ID_Tipo_Seguro = p.ID_Tipo_Seguro
GROUP BY ts.Nombre_Seguro;

-- Clientes que no tienen polizas

SELECT Nombre, DNI
FROM Clientes
WHERE ID_Cliente NOT IN (SELECT DISTINCT ID_Cliente FROM Polizas);

-- Ultimo pago de cada poliza

SELECT p.ID_Poliza, MAX(pg.Fecha) AS UltimoPago
FROM Pagos pg
JOIN Polizas p ON pg.ID_Poliza = p.ID_Poliza
GROUP BY p.ID_Poliza;

-- Clientes con reclamaciones mayores al promedio de su poliza

SELECT c.Nombre, r.Monto, p.ID_Poliza
FROM Clientes c
JOIN Polizas p ON c.ID_Cliente = p.ID_Cliente
JOIN Reclamaciones r ON p.ID_Poliza = r.ID_Poliza
WHERE r.Monto > (
    SELECT AVG(Monto)
    FROM Reclamaciones
    WHERE ID_Poliza = p.ID_Poliza
);

-- Polizas que caducan en los proximos 30 dias

SELECT ID_Poliza, Fecha_Fin
FROM Polizas
WHERE Fecha_Fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);


-- Polizas sin pagos registrados

SELECT p.ID_Poliza, c.Nombre
FROM Polizas p
JOIN Clientes c ON p.ID_Cliente = c.ID_Cliente
WHERE p.ID_Poliza NOT IN (
    SELECT DISTINCT ID_Poliza FROM Pagos
);





