CREATE SCHEMA supply_fau;

CREATE TABLE materials (
material_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
part_number VARCHAR(45) NOT NULL UNIQUE,
serial_number VARCHAR(45) UNIQUE,
material_name VARCHAR(45) NOT NULL,
storage_location VARCHAR(15) NOT NULL,
stock INT NOT NULL
);

CREATE TABLE entry (
entry_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
material_id INT NOT NULL,
entered_date DATE NOT NULL,
entered_quantity INT NOT NULL,
FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE outbound  (
out_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
material_id INT NOT NULL,
retirement_date DATE NOT NULL,
retirement_quantity INT NOT NULL,
FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE orders (
order_number INT NOT NULL PRIMARY KEY UNIQUE,
entry_id INT NOT NULL,
order_date DATE NOT NULL,
required_quantity INT NOT NULL,
FOREIGN KEY (entry_id) REFERENCES entry(entry_id)
);

CREATE TABLE workers (
supply_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
out_id INT NOT NULL UNIQUE,
worker_name VARCHAR(60) NOT NULL,
work_section VARCHAR(10) NOT NULL,
FOREIGN KEY (out_id) REFERENCES outbound(out_id)
);
