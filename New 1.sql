--1
SELECT COUNT(*) 테이블의수
FROM TAB;
--2
SELECT team_name 전체축구팀목록
FROM team
;
--3
SELECT DISTINCT position 포지션
FROM player
;
--4
SELECT DISTINCT NVL2(position,position,'신입') 포지션
FROM player
;
--5
SELECT position 포지션, player_name 이름
fROM player
WHERE position like 'MF'
    AND player_name like '고%'
    AND team_id LIKE 'K02'
    AND height >= 170
;
--6
SELECT player_name 이름, NVL2(height,height,0) || 'cm' 키, NVL2(weight,weight,0) ||'kg' 몸무게
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
; 
--7
SELECT player_name 이름, 
    NVL2(height,height,0) || 'cm' 키, 
    NVL2(weight,weight,0) ||'kg' 몸무게,
    ROUND((weight/((height/100)*(height/100))),2) BMI비만지수
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
; 
--8
SELECT t.team_name, p.position, p.player_name 
FROM team t INNER JOIN player p ON t.team_id LIKE p.team_id
WHERE t.team_id in ('K02','K10')
    AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name
;
--9
SELECT height || 'cm' 키, team_name 팀명, player_name 이름
FROM player p, team t
WHERE p.team_id Like t.team_id
    AND t.team_id in ('K02','K10')
    AND height BETWEEN 180 AND 183
ORDER BY height,t.team_name,p.player_name
;
