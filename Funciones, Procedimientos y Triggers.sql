-- Funciones, Procedimientos, y Triggers


-- Funcion para calcular la duracion de la poliza en dias
DELIMITER //
CREATE FUNCTION DuracionPoliza(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(fecha_fin, fecha_inicio);
END;
//
DELIMITER ;

-- Funcion para el total pagado de una poliza
DELIMITER //
CREATE FUNCTION TotalPagado(id_poliza INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(Monto) INTO total
    FROM Pagos
    WHERE ID_Poliza = id_poliza AND Estado = 'Pagado';
    RETURN IFNULL(total, 0.00);
END;
//
DELIMITER ;
