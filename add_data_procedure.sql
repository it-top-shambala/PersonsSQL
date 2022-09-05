DELIMITER |
CREATE PROCEDURE procedure_add_name(IN first_name TEXT)
BEGIN
    SELECT @is_name := COUNT(name_id) FROM table_names WHERE name = first_name;
    IF @is_name = 0 THEN
        INSERT INTO table_names(name) VALUE (first_name);
    END IF;
END |

DELIMITER |
CREATE PROCEDURE procedure_add_family(IN last_name TEXT)
BEGIN
    SELECT @is_family := COUNT(family_id) FROM table_families WHERE family = last_name;
    IF @is_family = 0 THEN
        INSERT INTO table_families(family) VALUE (last_name);
    END IF;
END |

DELIMITER |
CREATE PROCEDURE procedure_add_patronymic(IN patronymic_ TEXT)
BEGIN
    SELECT @is_patronymic := COUNT(patronymic_id) FROM table_patronymics WHERE patronymic = patronymic_;
    IF @is_patronymic = 0 THEN
        INSERT INTO table_patronymics(patronymic) VALUE (patronymic_);
    END IF;
END |

DELIMITER |
CREATE PROCEDURE procedure_add_data(IN last_name TEXT, IN first_name TEXT, IN patronymic_ TEXT)
BEGIN
    CALL procedure_add_family(last_name);
    CALL procedure_add_name(first_name);
    CALL procedure_add_patronymic(patronymic_);

    INSERT INTO table_persons(name_id, family_id, patronymic_id)
        VALUE ((SELECT name_id FROM table_names WHERE name = first_name),
               (SELECT family_id FROM table_families WHERE family = last_name),
               (SELECT patronymic_id FROM table_patronymics WHERE patronymic = patronymic_));
END |

/*
SELECT @is_name := COUNT(name_id) FROM table_names WHERE name = 'first_name';
SELECT @is_name;
*/

CALL procedure_add_data('Starinin', 'Andrey', 'Nikolaevich');