CREATE TABLE table_names(
    name_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE table_families(
    family_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    family TEXT NOT NULL
);

CREATE TABLE table_patronymics(
    patronymic_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    patronymic TEXT NOT NULL
);

CREATE TABLE table_persons(
    person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_id INT NOT NULL,
    family_id INT NOT NULL,
    patronymic_id INT NOT NULL,
    FOREIGN KEY (name_id) REFERENCES table_names(name_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (family_id) REFERENCES table_families(family_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (patronymic_id) REFERENCES table_patronymics(patronymic_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE VIEW view_persons AS
SELECT person_id,
       family AS 'last_name',
       name AS 'first_name',
       patronymic
FROM table_persons
JOIN table_families
    ON table_persons.family_id = table_families.family_id
JOIN table_names
    ON table_persons.name_id = table_names.name_id
JOIN table_patronymics
    ON table_persons.patronymic_id = table_patronymics.patronymic_id;