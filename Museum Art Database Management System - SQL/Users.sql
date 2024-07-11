-- Drop and create roles
DROP ROLE IF EXISTS db_admin@localhost, read_access@localhost, employee@localhost;
CREATE ROLE db_admin@localhost, read_access@localhost, employee@localhost;

-- Grant privileges
GRANT ALL PRIVILEGES ON ART_MUSEUM.* TO db_admin@localhost;
GRANT SELECT ON ART_MUSEUM.* TO read_access@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON ART_MUSEUM.* TO employee@localhost;

-- Drop and create users
DROP USER IF EXISTS test_admin@localhost, guest@localhost, test_employee@localhost;

CREATE USER test_admin@localhost IDENTIFIED WITH mysql_native_password BY 'Qwerty2003';
GRANT db_admin@localhost TO test_admin@localhost;
SET DEFAULT ROLE ALL TO test_admin@localhost;

CREATE USER test_employee@localhost IDENTIFIED WITH mysql_native_password BY 'Qwerty2003';
GRANT employee@localhost TO test_employee@localhost;
SET DEFAULT ROLE ALL TO test_employee@localhost;

CREATE USER guest@localhost;
GRANT read_access@localhost TO guest@localhost;
SET DEFAULT ROLE ALL TO guest@localhost;
