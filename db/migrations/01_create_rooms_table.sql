CREATE TABLE rooms(id SERIAL PRIMARY KEY, user_id INT REFERENCES users(id), title VARCHAR(30), description VARCHAR(200), price MONEY NOT NULL, location VARCHAR(30));

