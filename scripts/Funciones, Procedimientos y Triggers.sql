-- Funciones, Procedimientos, y Triggers

-- FUNCIONES

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


-- PROCEDIMIENTOS


-- Procedimiento para registrar una nueva reclamacion

DELIMITER //
CREATE PROCEDURE RegistrarReclamacion(
    IN poliza_id INT,
    IN fecha DATE,
    IN descripcion TEXT,
    IN monto DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Reclamaciones (ID_Poliza, Fecha, Descripcion, Estado, Monto)
    VALUES (poliza_id, fecha, descripcion, 'Pendiente', monto);
END;
//
DELIMITER ;

-- Procedimiento para cancelar una poliza
DELIMITER //
CREATE PROCEDURE CancelarPoliza(IN poliza_id INT)
BEGIN
    UPDATE Polizas
    SET Estado = 'Cancelada'
    WHERE ID_Poliza = poliza_id;
END;
//
DELIMITER ;

-- TRIGGERS 

-- Trigger que se asegura que el monto de un pago no es negativo

DELIMITER //
CREATE TRIGGER comprobacion_negativos
BEFORE INSERT ON Pagos
FOR EACH ROW
BEGIN
    IF NEW.Monto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El monto del pago debe ser mayor a cero';
    END IF;
END;
//
DELIMITER ;

-- Trigger para que cada vez que se haga una nueva reclamacion actualiza la poliza asociada y cambia su estado a "En revision"

DELIMITER //
CREATE TRIGGER en_revision
AFTER INSERT ON Reclamaciones
FOR EACH ROW
BEGIN
    UPDATE Polizas
    SET Estado = 'En Revisión'
    WHERE ID_Poliza = NEW.ID_Poliza;
END;
//
DELIMITER ;




