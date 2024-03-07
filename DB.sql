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
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
memberId = 3,
boardId = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
memberId = 2,
boardId = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
memberId = 1,
boardId = 2;


INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목' + ,
`body` = '내용3',
memberId = 1,
boardId = 2;

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
    
SELECT COUNT(*) AS cnt
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
WHERE M.loginId = 'test1'
			
			
SELECT *
FROM article;  
SELECT *
FROM `member`; 
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
    address CHAR(50),
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (1=골드, 2= 실버, 3=일반, 7=관리자)',
    membercode CHAR(20),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴 날짜'
);

ALTER TABLE `member` ADD COLUMN fplayer INT(10) AFTER membercode;
ALTER TABLE `member` ADD COLUMN image LONGTEXT AFTER membercode;

ALTER TABLE `member`
DROP COLUMN image;

UPDATE `member` SET image = "/resource/profile.png" WHERE image IS NULL;
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
SET loginId = 'gold',
loginPw = 'gold',
birth = '2000-02-26',
mname = '골드회원',
cellphoneNum = '01076070000',
email = '123@gmail.com',
address = '서울특별시',
`authLevel` = 1,
membercode = '0123456',
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = 'silver',
loginPw = 'silver',
birth = '2000-02-26',
mname = '실버회원',
cellphoneNum = '01056780000',
email = 'zxzx@gmail.com',
address = '대구광역시',
`authLevel` = 2,
membercode = '07654321',
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = 'test1',
loginPw = 'test1',
birth = '2000-02-26',
mname = '회원1',
cellphoneNum = '01043214321',
email = 'abcde@gmail.com',
`authLevel` = 3,
regDate = NOW(),
updateDate = NOW();

INSERT INTO `member`
SET loginId = 'test2',
loginPw = 'test2',
birth = '2000-02-26',
mname = '회원2',
cellphoneNum = '01098746513',
email = 'oioi@gmail.com',
`authLevel` = 3,
regDate = NOW(),
updateDate = NOW();

drop table `member`;

select *
from `member`;

update `member`
set `authLevel` = 3
where loginId != 'admin';

#---------------------------------------------------------------------------

# membership 테이블 생성
CREATE TABLE membership(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    loginId CHAR(20) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (1=골드, 2= 실버)',
    membercode CHAR(20),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    endStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '만료 여부 (0=만료 전, 1=만료 됨)',
    endDate DATE COMMENT '만료일'
);

# testdata 생성
INSERT INTO membership
SET loginId = 'gold',
`authLevel` = 1,
membercode = '0123456',
regDate = NOW(),
updateDate = NOW(),
endDate = '2024-04-26';
end
INSERT INTO membership
SET loginId = 'silver',
`authLevel` = 2,
membercode = '07654321',
regDate = NOW(),
updateDate = NOW(),
endDate = '2024-04-26';

ALTER TABLE member ADD COLUMN `type` char(10) AFTER `authLevel`;

select *
from membership;

SELECT *
FROM `member`;

delete from membership
where loginId = 'test1';


SELECT `authLevel` FROM `member` WHERE loginId = 'test1'

update `member`
set `type` = '실버'
where id = 1 or id = 2;
#---------------------------------------------------------------------------

# team 테이블 생성
CREATE TABLE team(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tname CHAR(20) NOT NULL,
    address CHAR(50) NOT NULL,
    stadium CHAR(20) NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# testdata 생성
INSERT INTO team
SET tname = '정관장',
address = '대전광역시',
stadium = '대전충무체육관',
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = '흥국생명',
address = '인천광역시',
stadium = '인천삼산체육관',
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = 'GS칼텍스',
address = '서울특별시',
stadium = '장충체육관',
regDate = NOW(),
updateDate = NOW();

INSERT INTO team
SET tname = 'IBK기업은행',
address = '화성시',
stadium = '화성종합운동장',
regDate = NOW(),
updateDate = NOW();

select *
from team;
# schedule 테이블 생성
CREATE TABLE `schedule`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    team1 CHAR(20) NOT NULL,
    team2 CHAR(20) NOT NULL,
    `date` DATETIME NOT NULL,
    `round` int NOT NULL
);

# testdata 생성
INSERT INTO `schedule`
SET team1 = 1,
team2 = 2,
`date` = '2024-02-24',
`round` = 6;

INSERT INTO `schedule`
SET team1 = 3,
team2 = 4,
`date` = '2024-02-25',
`round` = 6;

#---------------------------------------------------------------------------

# game 테이블 생성
CREATE TABLE game(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tid int(10) NOT NULL,
    result TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '만료 여부 (0=패, 1=승)',
    `date` DATETIME NOT NULL,
    `round` INT(10) NOT NULL,
    sumset int(10) not null,
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
INSERT INTO game
SET tid = 1,
result = 1,
`date` = '2024-02-24',
`round` = 6,
sumset = 4,
getset = 3,
attack = 64,
attack_rate = 35.8,
blocking = 9,
serve = 3,
recieve = 38,
mistake = 20,
dig = 107
;

INSERT INTO game
SET tid = 2,
result = 0,
`date` = '2024-02-24',
`round` = 6,
sumset = 4,
getset = 1,
attack = 67,
attack_rate = 39.2,
blocking = 5,
serve = 3,
recieve = 37,
mistake = 24,
dig = 114
;

INSERT INTO game
SET tid = 3,
result = 1,
`date` = '2024-02-25',
`round` = 6,
sumset = 3,
getset = 3,
attack = 50,
attack_rate = 45,
blocking = 6,
serve = 4,
recieve = 26,
mistake = 12,
dig = 63
;

INSERT INTO game
SET tid = 4,
result = 1,
`date` = '2024-02-25',
`round` = 6,
sumset = 3,
getset = 0,
attack = 43,
attack_rate = 36.8,
blocking = 6,
serve = 3,
recieve = 33,
mistake = 14,
dig = 61
;

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

delete from board where id = 4;

# board TD 생성

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유';

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
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    memberId INT(10) UNSIGNED NOT NULL,
    commentId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'comment',
relId = 1,
`point` = 1;

#---------------------------------------------------------------------------

# coment 테이블 생성
CREATE TABLE `comment`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `comment` TEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    # `level` INT(10) UNSIGNED NOT NULL,
    goodReactionPoint int not null DEFAULT 0,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL
);

INSERT INTO `comment`
SET regDate = NOW(),
updateDate = NOW(),
`comment` = '댓글1',
memberId = 4,
relTypeCode = 'article',
relId = 1;

INSERT INTO `comment`
SET regDate = NOW(),
updateDate = NOW(),
`comment` = '댓글2',
memberId = 3,
relTypeCode = 'article',
relId = 1;

#---------------------------------------------------------------------------

# team 테이블 생성
drop table team
select *
from team;
CREATE TABLE team(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tname CHAR(20) NOT NULL,
    stadium CHAR(20) NOT NULL,
    address CHAR(50) not null,
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

# team 테이블 생성
DROP TABLE player
SELECT image
FROM player
where id = 1;
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
image = 'https://kovostoragedev.blob.core.windows.net/kovo-prod/player/female/kgc/shoulder/%E1%84%87%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%B3%E1%86%AB%E1%84%8C%E1%85%B5%E1%86%AB_%E1%84%82%E1%85%AE%E1%84%81%E1%85%B5.png',
regDate = NOW(),
updateDate = NOW();

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



###############################################

SHOW FULL COLUMNS FROM `member`;
DESC `member`;

SELECT *
FROM article;

SELECT *
FROM `member`;

SELECT LAST_INSERT_ID();