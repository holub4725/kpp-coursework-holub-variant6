DROP DATABASE IF EXISTS road_defects;
CREATE DATABASE road_defects;
USE road_defects;

-- Таблиця локацій
CREATE TABLE location (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(40) NOT NULL,
    name VARCHAR(160) NOT NULL,
    district VARCHAR(120) NOT NULL
);

-- Таблиця бригад
CREATE TABLE crew (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(40) NOT NULL,
    name VARCHAR(160) NOT NULL,
    members_count INT NOT NULL
);

-- Таблиця дефектів
CREATE TABLE defect (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    location_id BIGINT NOT NULL,
    description VARCHAR(500) NOT NULL,
    state VARCHAR(30) NOT NULL,
    f1 DOUBLE NOT NULL,
    f2 DOUBLE NOT NULL,
    f3 DOUBLE NOT NULL,
    integral_index DOUBLE NOT NULL,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

-- Таблиця нарядів на роботи
CREATE TABLE work_order (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    defect_id BIGINT NOT NULL,
    crew_id BIGINT NOT NULL,
    description VARCHAR(500) NOT NULL,
    planned_date VARCHAR(10),
    FOREIGN KEY (defect_id) REFERENCES defect(id),
    FOREIGN KEY (crew_id) REFERENCES crew(id)
);

-- Початкові локації (м. Полтава)
INSERT INTO location (code, name, district) VALUES
                                                ('PLT-RD-01', 'вул. Соборності, ділянка біля Корпусного парку', 'Шевченківський район, Полтава'),
                                                ('PLT-RD-02', 'вул. Європейська, ділянка біля автовокзалу', 'Київський район, Полтава');

-- Початкові бригади
INSERT INTO crew (code, name, members_count) VALUES
                                                 ('PLT-CR-01', 'Полтавська дорожня бригада №1 (ямковий ремонт)', 6),
                                                 ('PLT-CR-02', 'Полтавська дорожня бригада №2 (відновлення покриття)', 5);

-- Початкові дефекти (стани: ЗАЯВЛЕНО, ПЕРЕВІРЕНО, РЕМОНТ_ЗАПЛАНОВАНО, УСУНЕНО)
INSERT INTO defect (location_id, description, state, f1, f2, f3, integral_index) VALUES
                                                                                     (1, 'Глибока вибоїна в асфальтобетонному покритті правої смуги', 'РЕМОНТ_ЗАПЛАНОВАНО', 80.0, 70.0, 60.0, 71.5),
                                                                                     (2, 'Сітка тріщин і просідання дорожнього полотна біля зупинки', 'ПЕРЕВІРЕНО', 50.0, 60.0, 40.0, 51.0);

-- Початкові наряди на роботи
INSERT INTO work_order (defect_id, crew_id, description, planned_date) VALUES
                                                                           (1, 1, 'Фрезерування країв вибоїни та укладання гарячого асфальтобетону', '2026-11-25'),
                                                                           (2, 2, 'Обстеження ділянки та підготовка матеріалів для локального ремонту', '2026-11-27');