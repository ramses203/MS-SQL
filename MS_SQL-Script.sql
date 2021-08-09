
USE tempdb; --새로운 DB를 생성/삭제 할때 위치(Master DB)
GO

CREATE DATABASE sqlDB;
GO

use tempdb;

USE tempdb;
DROP DATABASE sqlDB;

USE sqlDB;



CREATE TABLE userTbl -- 회원 테이블
(	userID char(8) NOT NULL PRIMARY KEY, -- 사용자 아이디
	name nvarchar(10) NOT NULL, -- 이름
	birthYear int NOT NULL, -- 출생년도
	addr nchar(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
	mobile1 char(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
	mobile2 char(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
	height smallint, -- 키
	mDate date -- 회원 가입일
);
GO
CREATE TABLE buyTbl -- 회원 구매 테이블
(	num int IDENTITY NOT NULL PRIMARY KEY, -- 순번(PK)
	userID char(8) NOT NULL --아이디(FK)
	FOREIGN KEY REFERENCES userTbl(userID),
	prodName nchar(6) NOT NULL, -- 물품명
	groupName nchar(4) , -- 분류
	price int NOT NULL, -- 단가
	amount smallint NOT NULL -- 수량
);
GO

select * from userTbl;
select * from buyTbl;

--MS-SQL은 자동 커밋 트랜잭션을 사용함.(Insert, Update, delete)


INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011','1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011','2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019','3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011','4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL ,NULL , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016','6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL ,NULL , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011','8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018','9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010','0000000', 176, '2013-5-5');
GO
INSERT INTO buyTbl VALUES('KBS', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES('JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES('BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl VALUES('KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl VALUES('BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl VALUES('SSK', '책' , '서적', 15, 5);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 2);
INSERT INTO buyTbl VALUES('EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
GO

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

USE tempdb;
BACKUP DATABASE sqlDB TO DISK = 'D:\MS-SQL\sqlDB2012.bak' WITH INIT ;


create table t_identity(   
a int identity not null Primary key,    -- identity : 자동증가(1,1)
b char(4) not null,    --한글 2자
c Nchar (4) not null,  --한글 4자 (총 8byte)
);

insert into t_identity values('서울', '서울부산');
insert into t_identity values('대구', '대구광주');
select * from t_identity;



/* -------------------------------
  Select 문
---------------------------------*/

USE sqlDB;
SELECT * FROM userTbl;

SELECT * FROM userTbl WHERE name = '김경호';

SELECT userID, name FROM userTbl WHERE birthYear >= 1970 AND height >= 182;

SELECT userID, name FROM userTbl WHERE birthYear >= 1970 OR height >= 182;

SELECT name, height FROM userTbl WHERE height >= 180 AND height <= 183;

SELECT name, height FROM userTbl WHERE height BETWEEN 180 AND 183;

SELECT name, addr FROM userTbl WHERE addr='경남' OR addr='전남' OR addr='경북';

SELECT name, addr FROM userTbl WHERE addr IN ('경남','전남','경북');

SELECT name, height FROM userTbl WHERE name LIKE '김%';

SELECT name, height FROM userTbl WHERE name LIKE '_종신';

SELECT name, height FROM userTBL WHERE height > 177;

SELECT name, height FROM userTbl
	WHERE height > (SELECT height FROM userTbl WHERE name = '김경호');

SELECT name, height FROM userTbl
	WHERE height >= (SELECT height FROM userTbl WHERE addr = '경남');

SELECT name, height FROM userTbl
	WHERE height >= ANY (SELECT height FROM userTbl WHERE addr = '경남');

SELECT name, height FROM userTbl
	WHERE height = ANY (SELECT height FROM userTbl WHERE addr = '경남');

SELECT name, height FROM userTbl
	WHERE height IN (SELECT height FROM userTbl WHERE addr = '경남');

SELECT name, mDate FROM userTbl ORDER BY mDate;

SELECT name, mDate FROM userTbl ORDER BY mDate DESC;

SELECT name, height FROM userTbl ORDER BY height DESC, name ASC;

SELECT addr FROM userTbl;

SELECT addr FROM userTbl ORDER BY addr;

SELECT DISTINCT addr FROM userTbl;

USE AdventureWorks;
SELECT CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth;

SELECT TOP(10) CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth;

SELECT TOP(SELECT COUNT(*)/100 FROM Sales.CreditCard ) CreditCardID
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth;

SELECT TOP(0.1) PERCENT CreditCardID, ExpYear, ExpMonth
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth;

SELECT TOP(0.1) PERCENT WITH TIES CreditCardID, ExpMonth, ExpYear
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth;

USE AdventureWorks
SELECT * FROM Sales.SalesOrderDetail TABLESAMPLE(5 PERCENT);

USE sqlDB;
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS;

SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS
	FETCH NEXT 3 ROWS ONLY;

USE sqlDB;
SELECT * INTO buyTbl2 FROM buyTbl;
SELECT * FROM buyTbl2;

USE sqlDB;
SELECT * INTO buyTbl2 FROM buyTbl;
SELECT * FROM buyTbl2;


/* -------------------------------
     집계함수 
---------------------------------*/

USE sqlDB;
SELECT userID, amount FROM buyTbl ORDER BY userID;

SELECT userID, SUM(amount) FROM buyTbl GROUP BY userID;

SELECT userID AS [사용자아이디], SUM(amount) AS [총구매개수]
	FROM buyTbl GROUP BY userID;

SELECT userID AS [사용자아이디], SUM(price*amount) AS [총구매액]
	FROM buyTbl GROUP BY userID;

USE sqlDB;
SELECT AVG(amount) AS [평균구매개수] FROM buyTbl ;

SELECT AVG(amount*1.0) AS [평균구매개수] FROM buyTbl ;
-- 또는
SELECT AVG(CAST(amount AS DECIMAL(10,6))) AS [평균구매개수]
	FROM buyTbl ;

SELECT userID, AVG(amount*1.0) AS [평균구매개수] FROM buyTbl
	GROUP BY userID;

SELECT name, MAX(height), MIN(height) FROM userTbl;

SELECT name, MAX(height), MIN(height) FROM userTbl GROUP BY Name;

SELECT name, height
	FROM userTbl
	WHERE height = (SELECT MAX(height)FROM userTbl)
		OR height = (SELECT MIN(height)FROM userTbl) ;

SELECT COUNT(*) FROM userTbl;

SELECT COUNT(mobile1) AS [휴대폰이 있는 사용자] FROM userTbl;



/* -------------------------------
집계함수
---------------------------------*/

USE sqlDB;
GO
SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl
	GROUP BY userID ;

SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl
	WHERE SUM(price*amount) > 1000
	GROUP BY userID ;

SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl
	GROUP BY userID
	HAVING SUM(price*amount) > 1000 ;

SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl
	GROUP BY userID
	HAVING SUM(price*amount) > 1000
	ORDER BY SUM(price*amount) ;

SELECT num, groupName, SUM(price * amount) AS [비용]
	FROM buyTbl
	GROUP BY ROLLUP (groupName, num);

SELECT groupName, SUM(price * amount) AS [비용]
	FROM buyTbl
	GROUP BY ROLLUP (groupName);

SELECT groupName, SUM(price * amount) AS [비용], GROUPING_ID(groupName) AS [추가행여부]
	FROM buyTbl
	GROUP BY ROLLUP(groupName) ;

USE sqlDB;
CREATE TABLE cubeTbl(prodName NCHAR(3), color NCHAR(2), amount INT);
GO
INSERT INTO cubeTbl VALUES('컴퓨터', '검정', 11);
INSERT INTO cubeTbl VALUES('컴퓨터', '파랑', 22);
INSERT INTO cubeTbl VALUES('모니터', '검정', 33);
INSERT INTO cubeTbl VALUES('모니터', '파랑', 44);
GO
SELECT prodName, color, SUM(amount) AS [수량합계]
	FROM cubeTbl
	GROUP BY CUBE (color, prodName);


/* -------------------------------
집계함수 고급(서브 쿼리)
---------------------------------*/

USE sqlDB;
SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl GROUP BY userID;

WITH abc(userID, total)
AS
	( SELECT userID, SUM(price*amount)
		FROM buyTbl GROUP BY userID )
SELECT * FROM abc ORDER BY total DESC ;

WITH cte_userTbl(addr, maxHeight)
AS
	( SELECT addr, MAX(height) FROM userTbl GROUP BY addr)
SELECT AVG(maxHeight*1.0) AS [각 지역별 최고키의 평균] FROM cte_userTbl;

SELECT * FROM userTbl
WITH abc(userID, total)
AS
	(SELECT userID, SUM(price*amount) FROM buyTbl GROUP BY userID )
SELECT * FROM abc ORDER BY total DESC ;


WITH
AAA(userID, total)
	AS
		(SELECT userID, SUM(price*amount) FROM buyTbl GROUP BY userID ),
BBB(sumtotal)
	AS
		(SELECT SUM(total) FROM AAA ),
CCC(sumavg)
	AS
		(SELECT sumtotal / (SELECT count(*) FROM buyTbl) FROM BBB)
SELECT * FROM CCC;


/* -------------------------------
       <실습4> 
---------------------------------*/

USE sqlDB;
CREATE TABLE empTbl (emp NCHAR(3), manager NCHAR(3), department NCHAR(3));
GO

INSERT INTO empTbl VALUES('나사장',NULL,NULL);
INSERT INTO empTbl VALUES('김재무','나사장','재무부');
INSERT INTO empTbl VALUES('김부장','김재무','재무부');
INSERT INTO empTbl VALUES('이부장','김재무','재무부');
INSERT INTO empTbl VALUES('우대리','이부장','재무부');
INSERT INTO empTbl VALUES('지사원','이부장','재무부');
INSERT INTO empTbl VALUES('이영업','나사장','영업부');
INSERT INTO empTbl VALUES('한과장','이영업','영업부');
INSERT INTO empTbl VALUES('최정보','나사장','정보부');
INSERT INTO empTbl VALUES('윤차장','최정보','정보부');
INSERT INTO empTbl VALUES('이주임','윤차장','정보부');

WITH empCTE(empName, mgrName, dept, level)
AS
(
	SELECT emp, manager, department , 0
		FROM empTbl
		WHERE manager IS NULL -- 상관이 없는 사람이 바로 사장
	UNION ALL
	SELECT AA.emp, AA.manager, AA.department, BB.level+1
		FROM empTbl AS AA INNER JOIN empCTE AS BB
			ON AA.manager = BB.empName
)
SELECT * FROM empCTE ORDER BY dept, level;

WITH empCTE(empName, mgrName, dept, level)
AS
(
	SELECT emp, manager, department , 0
		FROM empTbl
		WHERE manager IS NULL -- 사장
	UNION ALL
	SELECT AA.emp, AA.manager, AA.department, BB.level+1
		FROM empTbl AS AA INNER JOIN empCTE AS BB
			ON AA.manager = BB.empName
)
SELECT replicate(' ㄴ', level) + empName AS [직원이름], dept [직원부서]
	FROM empCTE ORDER BY dept, level

WITH empCTE(empName, mgrName, dept, level)
AS
(
	SELECT emp, manager, department , 0
		FROM empTbl
		WHERE manager IS NULL -- 사장
	UNION ALL
	SELECT AA.emp, AA.manager, AA.department, BB.level+1
		FROM empTbl AS AA INNER JOIN empCTE AS BB
			ON AA.manager = BB.empName
		WHERE level < 2
)
SELECT replicate(' ㄴ', level) + empName AS [직원이름], dept [직원부서]
	FROM empCTE ORDER BY dept, level


/* -------------------------------
  
---------------------------------*/

USE tempDB;
CREATE TABLE testTbl1 (id int, userName nchar(3), age int);
GO
INSERT INTO testTbl1 VALUES (1, '홍길동', 25);

INSERT INTO testTbl1(id, userName) VALUES (2, '한가인');

INSERT INTO testTbl1(userName, age, id) VALUES ('조인성', 29, 3);

USE tempdb;
CREATE TABLE testTbl2
	(id int IDENTITY,
	userName nchar(3),
	age int,
	nation nchar(4) DEFAULT '대한민국');
GO
INSERT INTO testTbl2 VALUES ('강동원', 27, DEFAULT);

SET IDENTITY_INSERT testTbl2 ON;
GO
INSERT INTO testTbl2(id, userName,age,nation) VALUES (11,'키아누',31, '미국');

INSERT INTO testTbl2 VALUES (12,'장만옥', 35, '중국');

SET IDENTITY_INSERT testTbl2 OFF;
INSERT INTO testTbl2 VALUES ('다꾸앙', 23, '일본');
SELECT * FROM testTbl2;

USE tempdb;
CREATE TABLE testTbl3
	(id int,
	userName nchar(3),
	age int,
	nation nchar(4) DEFAULT '대한민국');
GO

CREATE SEQUENCE idSEQ
	START WITH 1 -- 시작값
	INCREMENT BY 1 ; -- 증가값
GO

INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '강동원' ,27, DEFAULT);

INSERT INTO testTbl3 VALUES (11, '키아누' , 31, '미국');
GO
ALTER SEQUENCE idSEQ
	RESTART WITH 12; -- 시작값을 다시 설정
GO
INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '다꾸앙' , 23, '일본');
SELECT * FROM testTbl3;

CREATE TABLE testTbl4 (id INT);
GO
CREATE SEQUENCE cycleSEQ
	START WITH 100
	INCREMENT BY 100
	MINVALUE 100 -- 최소값
	MAXVALUE 300 -- 최대값
	CYCLE ; -- 반복설정
GO
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
GO
SELECT * FROM testTbl4;

CREATE SEQUENCE autoSEQ
	START WITH 1
	INCREMENT BY 1 ;
GO
CREATE TABLE testTbl5
(	id int DEFAULT (NEXT VALUE FOR autoSEQ) ,
	userName nchar(3)
) ;
GO
INSERT INTO testTbl5(userName) VALUES ('강동원');
INSERT INTO testTbl5(userName) VALUES ('키아누');
INSERT INTO testTbl5(userName) VALUES ('다꾸앙');
GO
SELECT * FROM testTbl5;

USE tempDB;
CREATE TABLE testTbl6 (id int, Fname nvarchar(50), Lname nvarchar(50));
GO
INSERT INTO testTbl6
	SELECT BusinessEntityID, FirstName, LastName
		FROM AdventureWorks.Person.Person ;

UPDATE testTbl6
	SET Lname = '없음'
	WHERE Fname = 'Kim';

USE sqlDB;
UPDATE buyTbl SET price = price * 1.5 ;

USE tempDB;
DELETE testTbl6 WHERE Fname = 'Kim';


/* -------------------------------
       <실습5> 
---------------------------------*/

USE tempDB;
SELECT * INTO bigTbl1 FROM AdventureWorks.Sales.SalesOrderDetail;
SELECT * INTO bigTbl2 FROM AdventureWorks.Sales.SalesOrderDetail;
SELECT * INTO bigTbl3 FROM AdventureWorks.Sales.SalesOrderDetail;
GO

DELETE FROM bigTbl1;
GO
DROP TABLE bigTbl2;
GO
TRUNCATE TABLE bigTbl3;


