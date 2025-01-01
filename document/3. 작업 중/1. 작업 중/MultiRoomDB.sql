SET SQL_SAFE_UPDATES = 0; 
drop database multiroom;
-- 데이터베이스 생성
create database multiroom;

use multiroom;

-- 유저 테이블 생성
CREATE TABLE IF NOT EXISTS Users (		# 유저
    id VARCHAR(50) NOT NULL PRIMARY KEY,        #아이디
    password VARCHAR(255) NOT NULL,              #비밀번호
    email VARCHAR(255) NOT NULL, 	      		#이메일, 아디,비번찾을때 사용
    name VARCHAR(255) NOT NULL, 				#이름, 아디,비번찾을때 사용       
    user_type ENUM('유저', '관리자')NOT NULL		#추후 관리자예정시
);

-- 방 테이블 생성
CREATE TABLE IF NOT EXISTS Rooms (		#방
    room_id INT AUTO_INCREMENT PRIMARY KEY,		#방 식별 id
    room_pic VARCHAR(255),								#방 사진
    room_name VARCHAR(255) NOT NULL,			#방 이름
    max_capacity INT NOT NULL,					#최대 수용 가능 인원
    location VARCHAR(255),						#위치
    service VARCHAR(255),						#부가서비스
    room_password VARCHAR(255),					#방의 비밀번호
    hourly_rate int NOT NULL,					#시간당 가격
    details VARCHAR(255)						#방 설명
);

-- 방 시간 테이블 생성
CREATE TABLE IF NOT EXISTS Room_Schedules (	#방_시간, 정규화결과(그럼에도 최소성이 별로인듯)
    room_id INT NOT NULL,					#방번호
    date DATE NOT NULL,						#날짜
    time ENUM('오전', '오후', '야간') NOT NULL,	#시간패키지, 시간단위시 1시간단위로 enum 예정....?
    available BOOLEAN NOT NULL,				#예약 가능한지
    PRIMARY KEY (room_id, date, time),		#primay key가 3개,,,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE 	# 외래키 room_id, 방삭제시 연쇄삭제되게
);

-- 예약 테이블 생성
CREATE TABLE IF NOT EXISTS Reservations ( #예약 
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,  #예약번호
    room_id INT NOT NULL,  							#방번호
    user_id VARCHAR(50) NOT NULL,					#예약한 아이디
    reservation_date DATE NOT NULL,								#예약한 날짜
    reservation_time ENUM('오전', '오후', '야간') NOT NULL,			#예약한 시간 패키지
    total_price int NOT NULL,						#총 금액 , 파생속성(시간*방 시간당가격) 
    dateOfReservation DATE,							#신청일
    people int,									#예약인원
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    UNIQUE (room_id, user_id, reservation_date, reservation_time) 			#중복 예약 방지
);


-- 샘플 데이터 삽입
INSERT INTO Users (id, password, email,name, user_type) VALUES 
('hankyul', '5d2e1e4c9436e030433dbd06dea8d631b14919be5f9229bd24365d1b486d28d9','hankyul@naver.com' ,'이한결', '유저'), #9540
('user', 'a5dd24b2f08a686fd386c22c3ff8ee281ef2fbff1fde7008668cda3decfa4669','123@gmail.com','김유저', '유저'),     	#user
('manager', 'bd4e0d485272933247d79456292b917dd946cff01367391ac3e5fc1ab9b57381','weud@naver.com','이관자', '관리자');	#manager

insert into Rooms (room_pic,room_name,max_capacity,location,service,room_password,hourly_rate,details) values
('/1/','종로구 1호점',50,'세종로','흡연실/주차장/승강기/자판기',1234,40000,'야간 및 주말 대관 가능하며 예약시 선결제 진행부탁드립니다'),
('/2/','강남구 11호점',22,'강남구','주차장/흡연금지/음식물반입금지',5678,91000,'유니크한 사옥형 건물로 신축급 회의실과 발렛 가능'),
('/3/','강남구 20호점',20,'강남구','회의실/파티룸보유',1234,120000,'접근성 좋은 깔끔한 회의실과 파티룸'),
('/4/','용산구 1호점',40,'용산','카페테리아/미팅룸보유',1234,65000,'실내 인테리어가 고급스로운 회의실');

insert into Room_Schedules values
(1,'2024-09-20','오전',true),
(1,'2024-09-20','오후',true),
(1,'2024-09-20','야간',true),
(1,'2024-09-21','오전',true),
(1,'2024-09-21','오후',true),
(1,'2024-09-21','야간',true),
(1,'2024-09-22','오전',true),
(1,'2024-09-22','오후',true),
(1,'2024-09-22','야간',true),
(1,'2024-09-23','오전',true),
(1,'2024-09-23','오후',true),
(1,'2024-09-23','야간',true),
(1,'2024-09-24','오전',true),
(1,'2024-09-24','오후',true),
(1,'2024-09-24','야간',true),
(1,'2024-09-25','오전',true),
(1,'2024-09-25','오후',true),
(1,'2024-09-25','야간',true),
(1,'2024-09-26','오전',true),
(1,'2024-09-26','오후',true),
(1,'2024-09-26','야간',true),

(2,'2024-09-20','오전',true),
(2,'2024-09-20','오후',true),
(2,'2024-09-21','오전',true),
(2,'2024-09-21','오후',true),
(2,'2024-09-22','오전',true),
(2,'2024-09-22','오후',true),
(2,'2024-09-24','오전',true),
(2,'2024-09-24','오후',true),
(2,'2024-09-24','야간',true),
(2,'2024-09-25','오전',true),
(2,'2024-09-25','오후',true),
(2,'2024-09-25','야간',true),
(2,'2024-09-26','오전',true),
(2,'2024-09-26','오후',true),
(2,'2024-09-26','야간',true),

(3,'2024-09-20','오전',true),
(3,'2024-09-20','오후',true),
(3,'2024-09-21','오전',true),
(3,'2024-09-21','오후',true),
(3,'2024-09-22','오전',true),
(3,'2024-09-22','오후',true),
(3,'2024-09-23','오전',true),
(3,'2024-09-23','오후',true),
(3,'2024-09-24','오전',true),
(3,'2024-09-24','오후',true),
(3,'2024-09-24','야간',true),
(3,'2024-09-25','오전',true),
(3,'2024-09-25','오후',true),
(3,'2024-09-25','야간',true),
(3,'2024-09-26','오전',true),
(3,'2024-09-26','오후',true),
(3,'2024-09-26','야간',true),

(4,'2024-09-20','오전',true),
(4,'2024-09-20','오후',true),
(4,'2024-09-20','야간',true),
(4,'2024-09-21','오전',true),
(4,'2024-09-21','오후',true),
(4,'2024-09-21','야간',true),
(4,'2024-09-22','오전',true),
(4,'2024-09-22','오후',true),
(4,'2024-09-22','야간',true),
(4,'2024-09-23','오전',true),
(4,'2024-09-23','오후',true),
(4,'2024-09-23','야간',true),
(4,'2024-09-24','오전',true),
(4,'2024-09-24','오후',true),
(4,'2024-09-24','야간',true),
(4,'2024-09-25','오전',true),
(4,'2024-09-25','오후',true),
(4,'2024-09-25','야간',true),
(4,'2024-09-26','오전',true),
(4,'2024-09-26','오후',true),
(4,'2024-09-26','야간',true);

-- 예약하면 작동하는 쿼리 2개
INSERT INTO Reservations (room_id, user_id, reservation_date, reservation_time, total_price,dateOfReservation,people)
values(1,'hankyul','2024-09-20','오전',3*(SELECT hourly_rate FROM Rooms WHERE room_id = 1),now(),10);
--    룸번호, 예약하는 사람 , 날짜 , 시간 , 시간당가격가져와서 *3(1패키지당 3시간이라고 가정함 )            ,예약시간, 사용인원
UPDATE Room_Schedules SET available = false WHERE room_id = 1 AND date = '2024-09-20' AND time = '오전';
--     << 룸 스케쥴 업데이트, 다른사람이 예약이 못하게 하기위함
--

use multiroom;
select * from Users;
select * from Rooms;
select * from Room_Schedules;
select * from Reservations;
