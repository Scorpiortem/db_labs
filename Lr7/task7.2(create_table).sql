USE cd;
DROP TABLE IF EXISTS payments;
CREATE TABLE IF NOT EXISTS payments (
  payid INT PRIMARY KEY AUTO_INCREMENT,
  bookid INT,
  payment DECIMAL DEFAULT 0,
  FOREIGN KEY (bookid) REFERENCES bookings(bookid)
);