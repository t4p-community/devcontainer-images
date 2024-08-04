DROP TABLE IF EXISTS color;

CREATE TABLE color (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  hexcode VARCHAR NOT NULL
);

CREATE OR REPLACE PROCEDURE insert_color(
  IN p_name VARCHAR,
  IN p_hexcode VARCHAR,
  OUT p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO color (name, hexcode)
  VALUES (p_name, p_hexcode)
  RETURNING id INTO p_id;
END;
$$;

CREATE OR REPLACE PROCEDURE update_color(
  p_id INT,
  p_name VARCHAR,
  p_hexcode VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE color
  SET name = p_name, hexcode = p_hexcode
  WHERE id = p_id;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_color(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM color WHERE id = p_id;
END;
$$;

CALL insert_color('red', 'FF0000', NULL);
CALL insert_color('orange', 'FF7F00', NULL);
CALL insert_color('yellow', 'FFFF00', NULL);
CALL insert_color('green', '00FF00', NULL);
CALL insert_color('blue', '0000FF', NULL);
CALL insert_color('indigo', '4B0082', NULL);
CALL insert_color('violet', '9400D3', NULL);


