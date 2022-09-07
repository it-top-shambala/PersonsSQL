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