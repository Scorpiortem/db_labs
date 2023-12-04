USE cd;
CREATE TABLE payments (
  payid INT PRIMARY KEY AUTO_INCREMENT,
  bookid INT,
  payment DECIMAL,
  FOREIGN KEY (bookid) REFERENCES bookings(bookid)
);