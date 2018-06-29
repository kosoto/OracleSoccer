
SELECT t.team_name, p.position, p.player_name
FROM player p 
INNER JOIN team t ON t.team_id LIKE p.team_id
WHERE p.team_id IN('K02','K10')
    AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name
;

--9
SELECT p.height || 'cm' 키 ,
    t.team_name 팀명, 
    p.player_name 이름
FROM team t 
INNER JOIN player p ON t.team_id like p.team_id
WHERE p.team_id in('K02','K10')
    AND p.height BETWEEN 180 AND 183
ORDER BY height,t.team_name, p.player_name
;
--18
SELECT 
    p.player_name 선수이름,
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 등번호
FROM player p 
    JOIN team t ON p.team_id LIKE t.team_id
WHERE p.PLAYER_NAME LIKE '최호진'
;
--19
SELECT ROUND(avg(p.HEIGHT),2) 평균키    
FROM player p 
    JOIN team t ON p.TEAM_ID = t.TEAM_ID
WHERE 
    t.team_name LIKE '시티즌'
    AND p.position LIKE 'MF'
;
--20
SELECT
    (SELECT count(*)
     FROM schedule sc1
     WHERE sc1.sche_date LIKE '201201%' 
     ) "1월 경기수"
     
FROM schedule sc 
WHERE 
    sc.sche_date LIKE '201201%' 
;

SELECT
    (SELECT count(*)
     FROM schedule sc1
     WHERE sc1.sche_date LIKE '201202%' 
     ) "2월 경기수"
     
FROM schedule sc 
WHERE 
    sc.sche_date LIKE '201202%' 
;
--20
SELECT SC1.SCHE_DATE "1월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201201%'
;
SELECT count(*) "월별 경기수"
FROM schedule sc2
WHERE sc2.sche_date LIKE '201202%'
;
SELECT  COUNT(SC3.SCHE_DATE) 
FROM schedule sc3
WHERE sc3.sche_date LIKE '201203%'
;
SELECT count(*) "4월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201204%'
;
SELECT count(*) "5월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201205%'
;
SELECT count(*) "6월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201206%'
;
SELECT count(*) "7월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201207%'
;
SELECT count(*) "8월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201208%'
;
SELECT count(*) "9월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201209%'
;
SELECT count(*) "10월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201210%'
;
SELECT count(*) "11월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201211%'
;
SELECT count(*) "12월 경기수"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201212%'
;
 



