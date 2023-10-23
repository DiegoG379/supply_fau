CREATE SCHEMA supply_fau;

USE supply_fau;

CREATE TABLE materials (
	material_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	part_number VARCHAR(45) NOT NULL,
	serial_number VARCHAR(45),
	material_name VARCHAR(45) NOT NULL,
	stock INT NOT NULL
);

INSERT INTO materials (part_number, material_name, serial_number, stock) VALUES
	('LN65019-05035', 'BOLT', '', 79),
	('LN65019-05025', 'BOLT', '', 125),
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

CREATE TABLE depot_personnel (
    depot_personnel_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    personnel_name VARCHAR(30) NOT NULL
);

INSERT INTO depot_personnel (personnel_name) VALUES
    ('Juan Martínez'),
    ('María López'),
    ('Pedro Ramírez');

CREATE TABLE entry (
	entry_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	material_id INT NOT NULL,
	entered_date DATE NOT NULL,
	entered_quantity INT NOT NULL,
	depot_personnel_id INT,
	FOREIGN KEY (material_id) REFERENCES materials(material_id),
	FOREIGN KEY (depot_personnel_id) REFERENCES depot_personnel(depot_personnel_id)
);

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

CREATE TABLE orders (
	order_number INT NOT NULL PRIMARY KEY UNIQUE,
	entry_id INT NOT NULL,
	order_date DATE NOT NULL,
	required_quantity INT NOT NULL,
	FOREIGN KEY (entry_id) REFERENCES entry(entry_id)
);

INSERT INTO orders (order_number, entry_id, order_date, required_quantity) VALUES
		(1072300001, 7, '2023-01-19', 25),
		(1072300002, 15, '2023-01-10', 30),
		(1072300003, 6, '2023-03-06', 40),
		(1072300004, 18, '2023-03-17', 14),
		(1072300005, 20, '2023-09-18', 10),
		(1072300006, 1, '2023-09-17', 20),
		(1072300007, 12, '2023-09-04', 15),
		(1072300008, 19, '2023-05-07', 32),
		(1072300009, 3, '2023-02-23', 15),
		(1072300010, 16, '2023-06-26', 5),
		(1072300011, 8, '2023-10-21', 35),
		(1072300012, 10, '2023-06-01', 22),
		(1072300013, 9, '2023-07-31', 18),
		(1072300014, 17, '2023-07-14', 27),
		(1072300015, 5, '2023-06-03', 10),
		(1072300016, 11, '2023-12-08', 27),
		(1072300017, 4, '2023-08-14', 20),
		(1072300018, 13, '2023-04-25', 12),
		(1072300019, 14, '2023-08-28', 24),
		(1072300020, 2, '2023-04-04', 30);

CREATE TABLE workers (
    worker_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    worker_name VARCHAR(60) NOT NULL UNIQUE,
    work_section VARCHAR(10) NOT NULL
);

INSERT INTO workers (worker_id, worker_name, work_section) VALUES
    (1, 'José Pérez', 'C-212'),
    (2, 'María González', 'C-212'),
    (3, 'Carlos López', 'C-212'),
    (4, 'Ana Rodríguez', 'C-212'),
    (5, 'Luis Martínez', 'C-212'),
    (6, 'Sofía Sánchez', 'KC-130'),
    (7, 'Miguel Romero', 'KC-130'),
    (8, 'Carmen García', 'KC-130'),
    (9, 'Laura Fernández', 'KC-130'),
    (10, 'Juan Martín', 'KC-130'),
    (11, 'Patricia Jiménez', 'C-120'),
    (12, 'Pedro Díaz', 'C-120'),
    (13, 'Lucía Torres', 'C-120'),
    (14, 'Javier Ruiz', 'C-120'),
    (15, 'Elena González', 'C-120');

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

INSERT INTO outbound (material_id, retirement_date, retirement_quantity, worker_id, depot_personnel_id) VALUES
  (12, '2023-09-15', 6, 7, 2),
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

CREATE TABLE maintenance_log (
    log_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    material_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    description TEXT,
    worker_id INT NOT NULL,
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
);

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

INSERT INTO aircraft (platform, registration, status, description, worker_id) VALUES
    ('C-212', 'FAU532', 'Operativo', 'Aeronave C-212 en estado operativo', 1),
    ('C-212', 'FAU534', 'Inoperativo', 'Aeronave C-212 en estado inoperativo', 1),
    ('C-212', 'FAU535', 'En Inspección', 'Aeronave C-212 en proceso de inspección', 2),
    ('C-212', 'FAU536', 'Operativo', 'Aeronave C-212 en estado operativo', 2),
    ('C-120', 'FAU550', 'Operativo', 'Aeronave C-120 en estado operativo', 11),
    ('C-120', 'FAU553', 'Inoperativo', 'Aeronave C-120 en estado inoperativo',11),
    ('C-130', 'FAU591', 'Operativo', 'Aeronave KC-130 en estado operativo', 6),
    ('C-130', 'FAU592', 'Operativo', 'Aeronave KC-130 en estado operativo', 6),
    ('C-130', 'FAU594', 'Inoperativo', 'Aeronave KC-130 en estado inoperativo', 7),
    ('C-130', 'FAU595', 'En Inspección', 'Aeronave KC-130 en proceso de inspección', 7);

CREATE TABLE deposit (
    deposit_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    deposit_name VARCHAR(60) NOT NULL UNIQUE,
	max_capacity INT,
    deposit_type VARCHAR(25)
);

INSERT INTO deposit (deposit_name, max_capacity, deposit_type) VALUES
    ('Depósito I', 1500, 'Materiales Fungibles'),
    ('Depósito II', 450, 'Materiales Fungibles'),
    ('Depósito III', 700, 'Materiales Reparables');

CREATE TABLE audits_inspections (
    audit_inspection_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    deposit_id INT NOT NULL,
    audit_date DATE NOT NULL,
    results TEXT,
    corrective_actions TEXT,
    FOREIGN KEY (deposit_id) REFERENCES deposit(deposit_id)
);

INSERT INTO audits_inspections (deposit_id, audit_date, results, corrective_actions) VALUES
    (1, '2023-01-02', 'Auditoría exitosa', 'Ninguna acción requerida'),
    (1, '2023-03-01', 'Algunas áreas desordenadas', 'Limpiar y organizar áreas específicas'),
    (2, '2023-05-01', 'Buen estado general', 'Ninguna acción requerida'),
    (2, '2023-07-01', 'Problemas de seguridad', 'Implementar medidas de seguridad adicionales'),
    (3, '2023-09-01', 'Auditoría exitosa', 'Ninguna acción requerida');

CREATE TABLE materials_in_deposit (
    material_in_deposit_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    material_id INT NOT NULL,
    deposit_id INT NOT NULL,
    storage_location VARCHAR(15) NOT NULL,
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (deposit_id) REFERENCES deposit(deposit_id)
);

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
