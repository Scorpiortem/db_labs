USE cd;
CREATE TABLE payments (
  payid INT PRIMARY KEY,
  bookid INT,
  payment DECIMAL,
  FOREIGN KEY (bookid) REFERENCES bookings(bookid)
);