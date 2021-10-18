CREATE TABLE rented_rooms (
  id                SERIAL PRIMARY KEY,
  room_id           INT REFERENCES rooms(id),
  user_id           INT REFERENCES users(id),
  occupy_date       DATE,
  vacate_date       DATE,
  request_approved  BOOLEAN DEFAULT FALSE
);