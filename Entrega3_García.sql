DROP SCHEMA IF EXISTS supply_fau;
CREATE SCHEMA IF NOT EXISTS supply_fau;

USE supply_fau;

-- TABLAS

-- Tabla de materiales del depósito
CREATE TABLE materials (
	material_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	part_number VARCHAR(45) NOT NULL,
	serial_number VARCHAR(45),
	material_name VARCHAR(45) NOT NULL,
	stock INT NOT NULL
);


-- Tabla de personal que trabaja en el depósito
CREATE TABLE depot_personnel (
    depot_personnel_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    personnel_name VARCHAR(30) NOT NULL
);


-- Tabla de materiales recibidos
CREATE TABLE entry (
	entry_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	material_id INT NOT NULL,
	entered_date DATE NOT NULL,
	entered_quantity INT NOT NULL,
	depot_personnel_id INT,
	FOREIGN KEY (material_id) REFERENCES materials(material_id),
	FOREIGN KEY (depot_personnel_id) REFERENCES depot_personnel(depot_personnel_id)
);


-- Tabla de materiales solicitados y requeridos para su compra
CREATE TABLE orders (
	order_number INT NOT NULL PRIMARY KEY UNIQUE,
	entry_id INT NOT NULL,
	order_date DATE NOT NULL,
	required_quantity INT NOT NULL,
	FOREIGN KEY (entry_id) REFERENCES entry(entry_id)
);


-- Tabla de mecánicos que retiran los materiales
CREATE TABLE workers (
    worker_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    worker_name VARCHAR(60) NOT NULL UNIQUE,
    work_section VARCHAR(10) NOT NULL
);


-- Tabla de materiales entregados
CREATE TABLE outbound  (
    out_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    material_id INT NOT NULL,
    worker_id INT NOT NULL,
    retirement_date DATE NOT NULL,
    retirement_quantity INT NOT NULL,
    depot_personnel_id INT,
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (worker_id) REFERENCES workers(worker_id),
    FOREIGN KEY (depot_personnel_id) REFERENCES depot_personnel(depot_personnel_id)
);


-- Tabla de registro de mantenimiento de aeronaves
CREATE TABLE maintenance_log (
    log_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    material_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    description TEXT,
    worker_id INT NOT NULL,
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
);


-- Tabla de aeronaves
CREATE TABLE aircraft (
    aircraft_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    platform VARCHAR(5) NOT NULL,
    registration VARCHAR(6) NOT NULL UNIQUE,
    status VARCHAR(15) NOT NULL,
    description TEXT,
    worker_id INT NOT NULL,
    FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
    -- worker_id representa al trabajador encargado de la aeronave
);


-- Tabla de depositos disponibles y su capacidad
CREATE TABLE deposit (
    deposit_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    deposit_name VARCHAR(60) NOT NULL UNIQUE,
	max_capacity INT,
    deposit_type VARCHAR(25)
);


-- Tabla de registro de auditorías
CREATE TABLE audits_inspections_log (
    audit_inspection_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    deposit_id INT NOT NULL,
    audit_date DATE NOT NULL,
    results TEXT,
    corrective_actions TEXT,
    FOREIGN KEY (deposit_id) REFERENCES deposit(deposit_id)
);


-- Tabla de ubicaciones de cada material en su respectivo deposito
CREATE TABLE materials_in_deposit (
    material_in_deposit_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    material_id INT NOT NULL,
    deposit_id INT NOT NULL,
    storage_location VARCHAR(15) NOT NULL,
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (deposit_id) REFERENCES deposit(deposit_id)
);


-- Tabla de registro de estado de aeronaves
CREATE TABLE aircraft_status (
    status_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    aircraft_id INT NOT NULL,
    status VARCHAR(15) NOT NULL,
    description TEXT,
    worker_id INT NOT NULL,
    change_date TIMESTAMP NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id),
    FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
);



-- INSERCIÓN DE DATOS

-- Inserción a la tabla 'materials'
INSERT INTO materials (part_number, material_name, serial_number, stock) VALUES
	('LN65019-05035', 'BOLT', '', 79),
	('LN65019-05025', 'BOLT', '', 0),
	('LN65019-05030', 'BOLT', '', 150),
	('LN65019-05015', 'BOLT', '', 174),
	('LN65019-05050', 'BOLT', '', 50),
	('LN65019-05010', 'BOLT', '', 241),
	('212-41205-9', 'BUSHING', '', 27),
	('212-41202-6', 'BUSHING', '', 39),
	('212-41208-7', 'BUSHING', '', 20),
	('212-41208-3', 'BUSHING', '', 24),
	('212-41209-6', 'BUSHING', '', 47),
	('212-41207-1', 'BUSHING', '', 40),
	('LN9484M8', 'NUT', '', 120),
	('LN9484M3', 'NUT', '', 102),
	('LN9484M4', 'NUT', '', 88),
	('LN9484M1', 'NUT', '', 30),
	('LN9484M7', 'NUT', '', 25),
	('LN9484M2', 'NUT', '', 23),
	('MS29513-117', 'PACKING', '', 95),
	('MS29513-239', 'PACKING', '', 44),
	('MS29513-879', 'PACKING', '', 75),
	('MS29513-963', 'PACKING', '', 68),
	('MS29513-752', 'PACKING', '', 123),
	('MS29513-136', 'PACKING', '', 75),
	('MS29513-158', 'PACKING', '', 98),
	('MS29513-225', 'PACKING', '', 57),
	('MS29513-197', 'PACKING', '', 13),
	('MS29513-009', 'PACKING', '', 54),
	('LN9439M5X10', 'SCREW', '', 62),
	('LN9439M3X16', 'SCREW', '', 188),
	('LN9439M5X12', 'SCREW', '', 129),
	('LN9439M4X28', 'SCREW', '', 75),
	('LN9439M4X24', 'SCREW', '', 65),
	('LN9439M4X30', 'SCREW', '', 91),
	('LN9036-02048', 'WASHER', '', 37),
	('LN9036-09043', 'WASHER', '', 82),
	('LN9036-72009', 'WASHER', '', 42),
	('AN6235-1A', 'FILTER', '', 62),
	('AN6235-2A', 'FILTER', '', 93),
	('AN6235-3A', 'FILTER', '', 78),
	('897390-8', 'FUEL PUMP', 'P-144C',1),
	('51509-002', 'STATIC VOLTAGE', '5327', 1),
	('5006484-2', 'BREAK ASSY', 'MAY-12361', 1),
	('5006484-2', 'BREAK ASSY', 'NOV-93214', 1),
	('10552E', 'HEATER-OIL TO FUEL', '4887', 1),
	('10552E', 'HEATER-OIL TO FUEL', '2506', 1),
	('23079-005', 'STARTER GENERATOR', '1518', 1),
	('23079-005', 'STARTER GENERATOR', '1564', 1),
	('777-1492-002', 'RECEIVER ADF', '2930', 1),
	('622-2855-001', 'TRANSCEIVER', '9588', 1);	


-- Inserción a la tabla 'depot_personnel'
INSERT INTO depot_personnel (personnel_name) VALUES
    ('Juan Martínez'),
    ('María López'),
    ('Pedro Ramírez');


-- Inserción a la tabla 'entry'
INSERT INTO entry (material_id, entered_date, entered_quantity, depot_personnel_id) VALUES
	(3, '2023-03-15', 30, 1),
	(5, '2023-07-02', 75, 1),
	(8, '2023-05-23', 45, 3),
	(10, '2023-10-04', 50, 2),
	(32, '2023-08-18', 70, 2),
	(15, '2023-01-26', 95, 2),
	(39, '2023-09-07', 65, 3),
	(20, '2023-04-12', 85, 2),
	(42, '2023-06-29', 55, 1),
	(3, '2023-02-11', 80, 1),
	(7, '2023-11-05', 60, 3),
	(9, '2023-12-30', 35, 1),
	(12, '2023-08-02', 40, 2),
	(15, '2023-03-21', 25,1),
	(27, '2023-05-08', 100, 2),
	(21, '2023-07-14', 55, 2),
	(24, '2023-09-28', 50, 2),
	(27, '2023-04-04', 70, 3),
	(30, '2023-06-18', 45, 1),
	(33, '2023-10-13', 85, 3);


-- Inserción a la tabla 'orders'
INSERT INTO orders (order_number, entry_id, order_date, required_quantity) VALUES
	(1072300001, 7, '2022-01-03', 100),
	(1072300002, 15, '2022-01-10', 300),
	(1072300003, 6, '2022-02-06', 400),
	(1072300004, 18, '2022-02-17', 140),
	(1072300005, 20, '2022-03-18', 100),
	(1072300006, 1, '2022-04-17', 200),
	(1072300007, 12, '2022-05-04', 150),
	(1072300008, 19, '2022-05-07', 320),
	(1072300009, 3, '2022-05-23', 105),
	(1072300010, 16, '2022-05-26', 500),
	(1072300011, 8, '2022-06-21', 350),
	(1072300012, 10, '2022-07-01', 220),
	(1072300013, 9, '2022-07-31', 108),
	(1072300014, 17, '2022-08-14', 270),
	(1072300015, 5, '2022-09-03', 100),
	(1072300016, 11, '2022-09-08', 270),
	(1072300017, 4, '2022-09-14', 200),
	(1072300018, 13, '2022-09-25', 120),
	(1072300019, 14, '2022-09-28', 240),
	(1072300020, 2, '2022-10-04', 300);


-- Inserción a la tabla 'workers'
INSERT INTO workers (worker_name, work_section) VALUES
    ('José Pérez', 'C-212'),
    ('María González', 'C-212'),
    ('Carlos López', 'C-212'),
    ('Ana Rodríguez', 'C-212'),
    ('Luis Martínez', 'C-212'),
    ('Sofía Sánchez', 'KC-130'),
    ('Miguel Romero', 'KC-130'),
    ('Carmen García', 'KC-130'),
    ('Laura Fernández', 'KC-130'),
    ('Juan Martín', 'KC-130'),
    ('Patricia Jiménez', 'C-120'),
    ('Pedro Díaz', 'C-120'),
    ('Lucía Torres', 'C-120'),
    ('Javier Ruiz', 'C-120'),
    ('Elena González', 'C-120');


-- Inserción a la tabla 'outbound'
INSERT INTO outbound (material_id, retirement_date, retirement_quantity, worker_id, depot_personnel_id) VALUES
  (3, '2023-09-15', 100, 7, 2),
  (28, '2023-04-02', 14, 15, 2),
  (35, '2023-02-21', 12, 3, 3),
  (4, '2023-08-12', 10, 12, 1),
  (22, '2023-06-01', 17, 2, 1),
  (8, '2023-03-04', 19, 5, 2),
  (19, '2023-01-17', 4, 11, 2),
  (9, '2023-10-19', 15, 2, 3),
  (33, '2023-07-29', 7, 9, 1),
  (7, '2023-05-30', 8, 14, 1),
  (14, '2023-12-06', 13, 8, 1),
  (16, '2023-11-08', 3, 1, 2),
  (27, '2023-09-02', 5, 1, 3),
  (32, '2023-04-23', 18, 9, 3),
  (20, '2023-08-26', 9, 15, 3),
  (11, '2023-01-08', 2, 6, 2),
  (30, '2023-06-24', 11, 7, 1),
  (25, '2023-07-12', 16, 3, 1),
  (1, '2023-03-15', 1, 14, 3),
  (29, '2023-05-05', 20, 6, 1);


-- Inserción a la tabla 'maintenance_log'
INSERT INTO maintenance_log (material_id, maintenance_date, description, worker_id) VALUES
    (39, '2023-01-15', 'Reemplazo de filtro de aire', 1),
    (14, '2023-02-10', 'Inspección y ajuste del tren de aterrizaje', 9),
    (41, '2023-02-18', 'Cambio de bomba de combustible', 4),
    (50, '2023-03-05', 'Reparación de aviónica', 6),
    (30, '2023-03-12', 'Mantenimiento preventivo', 5),
    (42, '2023-05-06', 'Reemplazo de componentes eléctricos', 11),
    (10, '2023-06-10', 'Inspección y ajuste de sistemas hidráulicos', 3),
    (43, '2023-06-25', 'Cambio de neumáticos', 7),
    (48, '2023-07-18', 'Calibración de instrumentos de vuelo', 11),
    (3, '2023-08-02', 'Reemplazo de ventanas de cabina', 13),
    (27, '2023-09-15', 'Mantenimiento de hélice', 10),
    (49, '2023-09-30', 'Verificación de sistemas de comunicación', 9),
    (1, '2023-10-20', 'Reparación de fuselaje', 7);


-- Inserción a la tabla 'aircraft'
INSERT INTO aircraft (platform, registration, status, description, worker_id) VALUES
    ('C-212', 'FAU532', 'Operativo', 'Aeronave C-212 en estado operativo', 1),
    ('C-212', 'FAU534', 'Inoperativo', 'Aeronave C-212 en estado inoperativo por falta de materiales', 1),
    ('C-212', 'FAU535', 'En Inspección', 'Aeronave C-212 en proceso de inspección de tren de aterrizaje', 2),
    ('C-212', 'FAU536', 'Operativo', 'Aeronave C-212 en estado operativo', 2),
    ('C-120', 'FAU550', 'Operativo', 'Aeronave C-120 en estado operativo', 11),
    ('C-120', 'FAU553', 'Inoperativo', 'Aeronave C-120 en estado inoperativo por rotura de parabrisas',11),
    ('C-130', 'FAU591', 'Operativo', 'Aeronave KC-130 en estado operativo', 6),
    ('C-130', 'FAU592', 'Operativo', 'Aeronave KC-130 en estado operativo', 6),
    ('C-130', 'FAU594', 'Inoperativo', 'Aeronave KC-130 en estado inoperativo por vencimiento calendario', 7),
    ('C-130', 'FAU595', 'En Inspección', 'Aeronave KC-130 en proceso de inspección de 1500 horas', 7);


-- Inserción a la tabla 'deposit'
INSERT INTO deposit (deposit_name, max_capacity, deposit_type) VALUES
    ('Depósito I', 150, 'Materiales Fungibles'),
    ('Depósito II', 50, 'Materiales Fungibles'),
    ('Depósito III', 75, 'Materiales Reparables');


-- Inserción a la tabla 'audits_inspections'
INSERT INTO audits_inspections_log (deposit_id, audit_date, results, corrective_actions) VALUES
    (1, '2023-07-02', 'Auditoría exitosa', 'Ninguna acción requerida'),
    (1, '2023-05-01', 'Algunas áreas desordenadas', 'Limpiar y organizar áreas específicas'),
    (2, '2023-09-01', 'Buen estado general', 'Ninguna acción requerida'),
    (3, '2023-09-01', 'Algunas áreas desordenadas', 'Limpiar y organizar áreas específicas'),
    (2, '2023-03-01', 'Problemas de seguridad', 'Implementar medidas de seguridad adicionales'),
    (3, '2023-01-01', 'Auditoría exitosa', 'Ninguna acción requerida'),
    (1, '2023-01-01', 'Auditoría exitosa', 'Ninguna acción requerida');


-- Inserción a la tabla 'materials_in_deposit'
INSERT INTO materials_in_deposit (material_id, deposit_id, storage_location) VALUES
    (1, 1, '1/A/1/A'),
    (2, 1, '1/A/1/B'),
    (3, 1, '1/A/1/C'),
    (4, 1, '1/A/2/A'),
    (5, 1, '1/A/2/B'),
    (6, 1, '1/A/2/C'),
    (7, 1, '2/A/1/A'),
    (8, 1, '2/A/1/B'),
    (9, 1, '2/A/1/C'),
    (10, 1, '2/A/2/A'),
    (11, 1, '2/A/2/B'),
    (12, 1, '2/A/2/C'),
    (13, 1, '3/A/1/A'),
    (14, 1, '3/A/1/B'),
    (15, 1, '3/B/1/A'),
    (16, 1, '3/B/1/B'),
    (17, 1, '3/C/1/A'),
    (18, 1, '3/C/1/B'),
    (19, 2, '4/A/1/A'),
    (20, 2, '4/A/1/B'),
    (21, 2, '4/A/1/C'),
    (22, 2, '4/A/2/A'),
    (23, 2, '4/A/2/B'),
    (24, 2, '4/A/2/C'),
    (25, 2, '4/B/1/A'),
    (26, 2, '4/B/1/B'),
    (27, 2, '4/B/1/C'),
    (28, 2, '4/B/1/D'),
    (29, 2, '5/A/1/A'),
    (30, 2, '5/A/1/B'),
    (31, 2, '5/A/1/C'),
    (32, 2, '5/A/2/A'),
    (33, 2, '5/A/2/B'),
    (34, 2, '5/A/2/C'),
    (35, 2, '6/A/1/A'),
    (36, 2, '6/A/1/B'),
    (37, 2, '6/A/1/C'),
    (38, 2, '6/A/2/A'),
    (39, 2, '6/A/2/B'),
    (40, 2, '6/A/2/C'),
    (41, 3, '7/A/1/A'),
    (42, 3, '7/A/1/B'),
    (43, 3, '7/A/1/C'),
    (44, 3, '7/A/1/D'),
    (45, 3, '7/A/2/A'),
    (46, 3, '7/A/2/B'),
    (47, 3, '7/B/1/A'),
    (48, 3, '7/B/1/B'),
    (49, 3, '7/C/1/A'),
    (50, 3, '7/C/2/A');
    

-- Inserción a la tabla 'aircraft_status'
INSERT INTO aircraft_status (aircraft_id, status, description, worker_id, change_date) VALUES
    (1, 'Operativo', 'Avión listo para el despegue', 3, '2023-01-25 09:30:00'),
    (3, 'Inoperativo', 'Problema de motor detectado', 4, '2023-07-24 14:15:00'),
    (2, 'En Inspección', 'Realizando mantenimiento de rutina', 1, '2023-09-23 11:20:00'),
    (6, 'Operativo', 'Avión listo para el vuelo de entrenamiento', 2, '2023-10-22 08:45:00'),
    (8, 'Inoperativo', 'Necesita reparaciones de aviónica', 5, '2023-02-21 13:10:00'),
    (10, 'Operativo', 'Finalizó el mantenimiento preventivo', 3, '2023-06-20 09:30:00'),
    (5, 'Inoperativo', 'Problema eléctrico identificado', 4, '2023-04-19 14:15:00'),
    (7, 'Operativo', 'Listo para el vuelo de reconocimiento', 2, '2023-05-18 11:20:00'),
    (1, 'En Inspección', 'Inspección de seguridad en curso', 1, '2023-09-17 08:45:00'),
    (2, 'Operativo', 'Mantenimiento programado completo', 5, '2023-02-16 13:10:00'),
    (10, 'Inoperativo', 'Fallo en el tren de aterrizaje', 3, '2023-07-15 09:30:00'),
    (4, 'Operativo', 'Mantenimiento rutinario completado', 4, '2023-06-14 14:15:00'),
    (9, 'En Inspección', 'Realizando inspección exhaustiva', 1, '2023-11-13 11:20:00'),
	(7, 'Operativo', 'Listo para el vuelo de prueba de carga', 2, '2023-02-07 08:45:00'),
    (9, 'Inoperativo', 'Problema de comunicación detectado', 5, '2023-10-11 13:10:00');



-- VISTAS

-- Vista de la tabla materials y materials_in_deposit para mostrar los materiales en depósito y su respectiva ubicación.
CREATE VIEW materials_and_locations AS
SELECT M.material_id, M.part_number, M.serial_number, M.material_name, M.stock, MID.storage_location, D.deposit_name, D.deposit_type
FROM materials M
LEFT JOIN materials_in_deposit MID
ON M.material_id = MID.material_id
LEFT JOIN deposit D
ON MID.deposit_id = D.deposit_id;

SELECT * FROM materials_and_locations;


-- Vista de aeronaves y su estado operativo así como el encargado de caga aeronave respectivamente
CREATE VIEW aircraft_workers AS
SELECT a.aircraft_id, a.platform, a.registration, a.status, a.description AS aircraft_description, w.worker_name
FROM aircraft AS a
JOIN workers AS w ON a.worker_id = w.worker_id;

SELECT * FROM aircraft_workers;


-- Vista de materiales recibidos, ingresados al sistema con el funcionario de depósito quien recibió dicho material. Así también como las cantidades solicitadas, recibidas y ordenado por fecha..
CREATE VIEW material_entry_info AS
SELECT M.material_id, M.part_number, M.material_name, M.stock, O.order_number, O.order_date, O.required_quantity, E.entered_date, E.entered_quantity, DP.personnel_name AS received_by
FROM materials AS M
INNER JOIN entry AS E ON M.material_id = E.material_id
INNER JOIN orders AS O ON E.entry_id = O.entry_id
INNER JOIN depot_personnel AS DP ON E.depot_personnel_id = DP.depot_personnel_id
ORDER BY E.entered_date;

SELECT * FROM material_entry_info;


-- Vista de materiales entregados, retirados del sistema con el funcionario de depósito quien abasteció dicho material. Así también como las cantidades entregadas y ordenado por fecha.
CREATE VIEW material_outbound_info AS
SELECT M.material_id, M.part_number, M.serial_number, M.material_name, M.stock, O.retirement_date, O.retirement_quantity, W.worker_name, DP.personnel_name AS delivered_by
FROM materials AS M
JOIN outbound AS O ON M.material_id = O.material_id
JOIN workers AS W ON O.worker_id = W.worker_id
JOIN depot_personnel AS DP ON O.depot_personnel_id = DP.depot_personnel_id
ORDER BY O.retirement_date;

SELECT * FROM material_outbound_info;


-- Vista de las auditorías realizadas en cada depósito y ordenadas por fecha.
CREATE VIEW deposit_audits AS
SELECT D.deposit_id, D.deposit_name, D.max_capacity, D.deposit_type, A.audit_date, A.results, A.corrective_actions
FROM deposit AS D
LEFT JOIN audits_inspections_log AS A ON D.deposit_id = A.deposit_id
ORDER BY A.audit_date;

SELECT * FROM deposit_audits;



-- FUNCIONES

-- Función que devuelve un texto con los materiales, cantidades y fechas de retiro por cada trabajador en base a su ID.
DELIMITER //
CREATE FUNCTION get_retired_materials_info_worker(workerId INT) RETURNS VARCHAR(4000)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(4000);
    SET result = '';

    SELECT GROUP_CONCAT(CONCAT('Material: ', m.material_name, ', Fecha del retiro: ', o.retirement_date, ', Cantidad retirada: ', o.retirement_quantity) SEPARATOR '\n')
    INTO result
    FROM outbound o
    INNER JOIN materials m ON o.material_id = m.material_id
    WHERE o.worker_id = workerId;

    RETURN result;
END; //

SELECT get_retired_materials_info_worker(7);


-- Función que devuelve el estado y la descripción más recientes para una aeronave, según su aircraft_id.
DELIMITER //
CREATE FUNCTION latest_aircraft_status(aircraft_id_param INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE latest_status VARCHAR(255);
    
    SELECT CONCAT(status, ': ', description) INTO latest_status
    FROM aircraft_status
    WHERE aircraft_id = aircraft_id_param
    ORDER BY change_date DESC
    LIMIT 1;
    
    RETURN latest_status;
END; //

SELECT latest_aircraft_status(7);



-- STORED PROCEDURES

-- Este procedimiento registra los resultados de una auditoría en un depósito, incluyendo detalles y posibles acciones correctivas.
DELIMITER //
CREATE PROCEDURE record_audit_results(IN depositID INT, IN auditDate DATE, IN auditResults TEXT, IN correctiveActions TEXT)
BEGIN
    INSERT INTO audits_inspections_log (deposit_id, audit_date, results, corrective_actions) VALUES (depositID, auditDate, auditResults, correctiveActions);    
END //

CALL record_audit_results(3, '2023-10-23', 'Problemas de seguridad', 'Implementar medidas de seguridad adicionales');
SELECT * FROM audits_inspections_log ORDER BY audit_date DESC;


-- El procedimiento verifica si un material está registrado en el sistema a través de su número de parte y número de serie, mostrando su ubicación si está registrada.
DELIMITER //
CREATE PROCEDURE check_material_on_deposit(IN partNumber VARCHAR(45), IN serialNumber VARCHAR(45), OUT resultMessage VARCHAR(255))
BEGIN
    DECLARE materialID INT;
    DECLARE location VARCHAR(255);
    
    SELECT material_id INTO materialID FROM materials WHERE part_number = partNumber AND serial_number = serialNumber LIMIT 1;

    IF materialID IS NULL THEN
        SET resultMessage = 'Material no ingresado en el sistema.';
    ELSE
        SELECT storage_location INTO location FROM materials_in_deposit WHERE material_id = materialID LIMIT 1;
        IF location IS NOT NULL THEN
            SET resultMessage = CONCAT('Material ingresado en el sistema, ubicación: ', location);
        ELSE
            SET resultMessage = 'Material registrado en el sistema, sin ubicación registrada.';
        END IF;
    END IF;
END // 

CALL check_material_on_deposit ('23079-005', '1518', @resultMessage);
SELECT @resultMessage;



-- TRIGGERS

-- Después de una entrada, calcula y actualiza el stock de un material en la tabla materials agregando la cantidad de la entrada.
DELIMITER //
CREATE TRIGGER update_stock_after_entry
AFTER INSERT ON entry
FOR EACH ROW
BEGIN
    DECLARE stock_change INT;
    
    SET stock_change = NEW.entered_quantity;

    UPDATE materials
    SET stock = stock + stock_change
    WHERE material_id = NEW.material_id;
END; //

-- Verificación rápida del trigger
-- SELECT * FROM materials WHERE material_id = 9;
-- INSERT INTO entry (material_id, entered_date, entered_quantity, depot_personnel_id) VALUES (9, '2023-03-15', 30, 1)
-- SELECT * FROM materials WHERE material_id = 9;


-- Después de una salida, calcula y actualiza el stock de un material en la tabla materials restando la cantidad de la salida.
DELIMITER //
CREATE TRIGGER update_stock_after_outbound
AFTER INSERT ON outbound
FOR EACH ROW
BEGIN
    DECLARE stock_change INT;

    SET stock_change = NEW.retirement_quantity;

    UPDATE materials
    SET stock = stock - stock_change
    WHERE material_id = NEW.material_id;
END; //

-- Verificación rápida del trigger
-- SELECT * FROM materials WHERE material_id = 1;
-- INSERT INTO outbound (material_id, retirement_date, retirement_quantity, worker_id, depot_personnel_id) VALUES (1, '2023-09-15', 39, 7, 2)
-- SELECT * FROM materials WHERE material_id = 1;



-- INFORMES

-- Informe mensual de stock retirado del depósito en el año 2023
SELECT
    MONTH(O.retirement_date) AS mes,
    SUM(O.retirement_quantity) AS stock_retirado
FROM
    outbound O
WHERE
    YEAR(O.retirement_date) = 2023
GROUP BY
    MONTH(O.retirement_date)
ORDER BY
    MONTH(O.retirement_date);
   

-- Informe de Estado de Aeronaves
SELECT
    A.platform AS tipo_aeronave,
    SUM(CASE WHEN ASL.status = 'Operativo' THEN 1 ELSE 0 END) AS volando,
    SUM(CASE WHEN ASL.status = 'Inoperativo' THEN 1 ELSE 0 END) AS inoperativas,
    SUM(CASE WHEN ASL.status = 'En Inspección' THEN 1 ELSE 0 END) AS en_mantenimiento
FROM
    aircraft A
JOIN
    aircraft_status ASL ON A.aircraft_id = ASL.aircraft_id
WHERE
    ASL.change_date = (SELECT MAX(change_date) FROM aircraft_status WHERE aircraft_id = A.aircraft_id)
GROUP BY
    A.platform;
