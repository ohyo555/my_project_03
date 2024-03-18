DROP DATABASE IF EXISTS `Spring_OHJ_01`;
CREATE DATABASE `Spring_OHJ_01`;
USE `Spring_OHJ_01`;

# article 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    memberId INT(10) NOT NULL,
    boardId INT(10) NOT NULL,
    hitcount INT(10) NOT NULL DEFAULT 0 ,
    goodReactionPoint INT(10) NOT NULL DEFAULT 0 ,
    badReactionPoint INT(10) NOT NULL DEFAULT 0 ,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# testdata 생성

# article 데이터 대량 
INSERT INTO article(title, `body`, memberId, boardId, regDate, updateDate)
SELECT
    CONCAT('Title ', num),
    CONCAT('Body ', num),
    num % 7 + 1 AS memberId,
    num % 3 + 1 AS boardId,
    NOW() AS regDate,
    NOW() AS updateDate
FROM (
    SELECT
        (a.N + b.N * 10 + c.N * 100) AS num
    FROM
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    ) AS numbers;

SELECT A.*, M.loginId AS loginId, B.name AS `type`, CASE 
        WHEN M.authLevel = 1 THEN '골드'
        WHEN M.authLevel = 2 THEN '실버'
        WHEN M.authLevel = 7 THEN '관리자'
        ELSE '일반'  -- 다른 경우에 대한 기본값 설정 (optional)
    END AS userLevel
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
INNER JOIN board AS B
ON A.boardId = B.id
WHERE A.id = 1003
GROUP BY A.id
			
#---------------------------------------------------------------------------

# member 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(20) NOT NULL,
    birth DATE NOT NULL,
    mname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(20) NOT NULL,
    postcode CHAR(20),
    address CHAR(50),
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (1=골드, 2= 실버, 3=일반, 7=관리자)',
    membercode CHAR(20),
    fplayer CHAR(10),
    image CHAR(100) NOT NULL DEFAULT "/resource/profile.png",
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴 날짜'
);

# testdata 생성
INSERT INTO `member`
SET loginId = 'admin',
loginPw = 'admin',
birth = '2000-02-26',
mname = '관리자',
cellphoneNum = '01012341234',
email = 'aaa@gmail.com',
address = '대전광역시',
`authLevel` = 7,
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = '123',
loginPw = '123',
birth = '2000-02-26',
mname = '골드회원',
cellphoneNum = '01076070000',
email = '123@gmail.com',
address = '서울특별시',
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = '999',
loginPw = '999',
birth = '2000-02-26',
mname = '실버회원',
cellphoneNum = '01056780000',
email = 'zxzx@gmail.com',
address = '대구광역시',
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = 'test1',
loginPw = 'test1',
birth = '2000-02-26',
mname = '회원1',
cellphoneNum = '01043214321',
email = 'abcde@gmail.com',
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = 'test2',
loginPw = 'test2',
birth = '2000-02-26',
mname = '회원2',
cellphoneNum = '01098746513',
email = 'oioi@gmail.com',
regDate = NOW(),
updateDate = NOW();


#---------------------------------------------------------------------------

# membership 테이블 생성
CREATE TABLE membership(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    loginId CHAR(20) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED NOT NULL DEFAULT 3 COMMENT '권한 레벨 (1=골드, 2= 실버)',
    `type` CHAR(10) NOT NULL,
    membercode CHAR(20) NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    endStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '만료 여부 (0=만료 전, 1=만료 됨)',
    endDate DATE COMMENT '만료일'
);

#---------------------------------------------------------------------------

# schedule 테이블 생성
CREATE TABLE `schedule`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `date` CHAR(20) NOT NULL,
    num int(10) NOT NULL,
    stype CHAR(20) NOT NULL,
    `time` CHAR(20) NOT NULL,
    gym CHAR(20) NOT NULL,
    boradcasting CHAR(20) NOT NULL,
    `round` int(10) NOT NULL,
    info CHAR(20) NOT NULL,
);

select *
from `schedule`;
#---------------------------------------------------------------------------

# game 테이블 생성
CREATE TABLE game(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tid INT(10) NOT NULL,
    result TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '만료 여부 (0=패, 1=승)',
    `date` DATETIME NOT NULL,
    `round` INT(10) NOT NULL,
    sumset INT(10) NOT NULL,
    getset INT(10) NOT NULL,
    attack INT(10) NOT NULL,
    attack_rate INT(10) NOT NULL,
    blocking INT(10) NOT NULL,
    serve INT(10) NOT NULL,
    recieve INT(10) NOT NULL,
    mistake INT(10) NOT NULL,
    dig INT(10) NOT NULL
);

# testdata 생성

#---------------------------------------------------------------------------

# board 테이블 생성
CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free(자유), QnA(질의응답) ...',
    `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
    delDate DATETIME COMMENT '삭제 날짜'
);

# board TD 생성

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질의응답';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'Myboard',
`name` = '나의게시판';

#---------------------------------------------------------------------------

# reactionPoint 테이블 생성

select *
from reactionPoint
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

#---------------------------------------------------------------------------

# coment 테이블 생성
CREATE TABLE `comment`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `comment` TEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    goodReactionPoint INT NOT NULL DEFAULT 0,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

#---------------------------------------------------------------------------

# team 테이블 생성

CREATE TABLE team(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tname CHAR(20) NOT NULL,
    stadium CHAR(20) NOT NULL,
    address CHAR(50) NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# testdata 생성
INSERT INTO team
SET tname = '정관장',
stadium = '대전충무체육관',
address = '대전광역시 중구 대종로 373',
latitude = 36.3179809,
longitude = 127.4304347,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = '흥국생명',
stadium = '인천산삼월드체육관',
address = '인천광역시 부평구 삼산동 체육관로 60',
latitude = 37.5076162,
longitude = 126.7376084,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = '현대건설',
stadium = '수원실내체육관',
address = '경기도 수원시 장안구 조원동 775',
latitude = 37.2983182,
longitude = 127.0090137,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = 'IBK기업은행',
stadium = '화성종합경기타운 실내체육관',
address = '경기도 화성시 향남읍 도이리 226-27',
latitude = 37.1382754,
longitude = 126.9227018,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = '한국도로공사',
stadium = '김천실내체육관',
address = '경상북도 김천시 삼락동 운동장길 1',
latitude = 36.1430267,
longitude = 128.0868359,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = '페퍼저축은행',
stadium = '페퍼스타디움',
address = '광주광역시 서구 화정동 금화로 278',
latitude = 35.1352826,
longitude = 126.8789211,
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = 'GS칼텍스',
stadium = '장충체육관',
address = '서울특별시 중구 동호로 241',
latitude = 37.5581571,
longitude = 127.0068191,
regDate = NOW(),
updateDate = NOW();

#---------------------------------------------------------------------------

# player 테이블 생성

CREATE TABLE player(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    pname CHAR(20) NOT NULL,
    `position` CHAR(20) NOT NULL,
    `number` INT(10) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE,
    image CHAR(200) NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# Outside Hitter: 외곽 공격수
# Middle Blocker: 중앙 블로커
# Opposite Hitter (Right Side Hitter): 상대편 공격수 (오른쪽 공격수)
# Setter: 세터
# Libero: 리베로

# testdata 생성
INSERT INTO player
SET pname = '이소영',
`position` = 'Outside Hitter',
`number` = 1,
startDate = '2021-04-15',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8B%E1%85%B5%E1%84%89%E1%85%A9%E1%84%8B%E1%85%A7%E1%86%BC_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '안예림',
`position` = 'Setter',
`number` = 2,
startDate = '2023.08.25',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%8B%E1%85%A8%E1%84%85%E1%85%B5%E1%86%B7_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '염혜선',
`position` = 'Setter',
`number` = 3,
startDate = '2019.06.14',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8B%E1%85%A7%E1%86%B7%E1%84%92%E1%85%A8%E1%84%89%E1%85%A5%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '김세인',
`position` = 'Outside Hitter',
`number` = 4,
startDate = '2023.08.25',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%80%E1%85%B5%E1%86%B7%E1%84%89%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '노란',
`position` = 'LIBERO',
`number` = 5,
startDate = '2018.07.03',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%82%E1%85%A9%E1%84%85%E1%85%A1%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '박은진',
`position` = 'MIDDLE BLOCKER',
`number` = 6,
startDate = '2018.10.23',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_t08.png',
regDate = NOW(),
updateDate = NOW();
UPDATE player SET image = "https://www.kgcsports.com/images/volleyball/2324_new/player_list_t08.png" WHERE pname = '박은진';


INSERT INTO player
SET pname = '이예솔',
`position` = 'OPPOSITE SPIKER',
`number` = 7,
startDate = '2018.10.23',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A8%E1%84%89%E1%85%A9%E1%86%AF_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '메가',
`position` = 'OPPOSITE SPIKER',
`number` = 8,
startDate = '2023.10.16',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%86%E1%85%A6%E1%84%80%E1%85%A1_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '서유경',
`position` = 'LIBERO',
`number` = 9,
startDate = '2020.10.07',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%89%E1%85%A5%E1%84%8B%E1%85%B2%E1%84%80%E1%85%A7%E1%86%BC_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '박혜민',
`position` = 'OUTSIDE HITTER',
`number` = 10,
startDate = '2021.07.01',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%87%E1%85%A1%E1%86%A8%E1%84%92%E1%85%A8%E1%84%86%E1%85%B5%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '곽선옥',
`position` = 'OUTSIDE HITTER',
`number` = 11,
startDate = '2023.9.23',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_n231.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '한송이',
`position` = 'MIDDLE BLOCKER',
`number` = 12,
startDate = '2017.06.08',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_fa01.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '정수지',
`position` = 'LIBERO',
`number` = 13,
startDate = '2023.09.26',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_n233.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '김채나',
`position` = 'SETTER',
`number` = 14,
startDate = '2021.12.23',
image = 'https://www.kgcsports.com/images//volleyball/2324_new/player_list_khw21.png?ver=2.2',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '이선우',
`position` = 'OUTSIDE HITTER',
`number` = 15,
startDate = '2020.10.07',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8B%E1%85%B5%E1%84%89%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%AE_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '정호영',
`position` = 'MIDDLE BLOCKER',
`number` = 17,
startDate = '2019.10.18',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_n191.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '이지수',
`position` = 'MIDDLE BLOCKER',
`number` = 18,
startDate = '2021.09.29',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_new21.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '강다연',
`position` = 'OUTSIDE HITTER',
`number` = 19,
startDate = '2023.09.26',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%80%E1%85%A1%E1%86%BC%E1%84%83%E1%85%A1%E1%84%8B%E1%85%A7%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '최효서',
`position` = 'LIBERO',
`number` = 20,
startDate = '2023.10.16',
image = 'https://www.kgcsports.com/images/volleyball/2324_new/player_list_c03.png',
regDate = NOW(),
updateDate = NOW();

INSERT INTO player
SET pname = '지아',
`position` = 'OUTSIDE HITTER',
`number` = 77,
startDate = '2023.10.16',
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%8C%E1%85%B5%E1%84%8B%E1%85%A1_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();


###############################################
SELECT m.*, pname, `number` as pnumber, `position`
			FROM `member` AS m
			INNER JOIN player AS p
			ON m.fplayer = p.id
			WHERE loginId = '333';
			
UPDATE `comment` AS C
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON C.id = RP_SUM.relId
SET C.goodReactionPoint = RP_SUM.goodReactionPoint;

SHOW FULL COLUMNS FROM `member`;
DESC `member`;

SELECT C.*, M.loginId AS loginId, M.image AS image, SUM(C.goodreactionPoint) AS `sum`
			FROM `comment` AS C
			INNER JOIN `member` AS M
			ON C.memberId = M.id
			WHERE C.relId = 1
			GROUP BY C.id
			
SELECT *
FROM article; 
 
SELECT *
FROM `comment`; 

select *
from reactionpoint;
SELECT *
FROM `member`; 

select p.id
from player AS p
inner join `member` as m
on m.fplayer = p.id
where m.id = 3

SELECT *
FROM team; 

SELECT *
FROM board;

select *
from player;
 

SELECT LAST_INSERT_ID();