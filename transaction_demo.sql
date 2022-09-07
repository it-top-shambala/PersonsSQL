DROP PROCEDURE add_;
DELIMITER |
CREATE PROCEDURE add_(IN last_name TEXT, IN first_name TEXT, IN patronymic_ TEXT)
BEGIN
    START TRANSACTION;
    INSERT INTO table_names(name) VALUE ('first_name');
    SET @name = (SELECT COUNT(*) FROM table_names WHERE table_names.name = 'first_name');
    IF @name > 1 THEN ROLLBACK;
    ELSE COMMIT;
    END IF;
END |

CALL add_('first_name', 'first_name', 'first_name');

DELIMITER |
CREATE PROCEDURE procedure_add_data_exception(IN last_name TEXT, IN first_name TEXT, IN patronymic_ TEXT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SELECT 'ERROR!';
        END;

    START TRANSACTION;
    CALL procedure_add_family(last_name);
    CALL procedure_add_name(first_name);
    CALL procedure_add_patronymic(patronymic_);

    INSERT INTO table_persons(name_id, family_id, patronymic_id)
        VALUE ((SELECT name_id FROM table_names WHERE name = first_name),
               (SELECT family_id FROM table_families WHERE family = last_name),
               (SELECT patronymic_id FROM table_patronymics WHERE patronymic = patronymic_));
    COMMIT;
END |

CALL procedure_add_data_exception('Starinin', 'Andrey', NULL);