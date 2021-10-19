CREATE TABLE rooms (
  id              SERIAL PRIMARY KEY,
  user_id         INT REFERENCES users(id),
  title           VARCHAR(30)
);