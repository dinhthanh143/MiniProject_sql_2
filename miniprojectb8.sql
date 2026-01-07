create database miniproject2;
use miniproject2;
-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày

select guest_name, phone 
from guests;

select room_type 
from rooms
group by room_type;

select room_type, price_per_day
from rooms
group by room_type, price_per_day
order by price_per_day asc
;

select room_type, price_per_day
from rooms
where price_per_day > 1000000
group by room_type, price_per_day
;

select * from bookings
where check_in between '2023-12-31' and '2025-01-01';

select room_type, count(*) from rooms
group by room_type, price_per_day;

select g.guest_name, r.room_type, b.check_in
from guests g
inner join bookings b  
on g.guest_id = b.guest_id
inner join rooms r
on  r.room_id  = b.room_id
;

select g.guest_name, count(b.guest_id) as booked_times
from guests g
inner join bookings b
on g.guest_id = b.guest_id
group by g.guest_name
;

select g.guest_name, count(b.guest_id) as booked_times
from guests g
inner join bookings b
on g.guest_id = b.guest_id
group by g.guest_name
having booked_times >=2
;



select room_type, price_per_day 
from rooms
where price_per_day > (
	select avg(price_per_day)
    from rooms
)
; 


select g.guest_name, count(b.guest_id) as booked_times
from guests g
left join bookings b
on g.guest_id = b.guest_id
group by g.guest_name
having booked_times < 1
;




