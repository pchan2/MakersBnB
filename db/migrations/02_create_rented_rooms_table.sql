CREATE TABLE rented_rooms(
  id SERIAL PRIMARY KEY, 
  oom_id INT REFERENCES rooms(id),
  user_id INT REFERENCES users(id),
  datetime TIMESTAMP
);
