
SELECT t.team_name, p.position, p.player_name
FROM player p 
INNER JOIN team t ON t.team_id LIKE p.team_id
WHERE p.team_id IN('K02','K10')
    AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name
;

--9
SELECT p.height || 'cm' Ű ,
    t.team_name ����, 
    p.player_name �̸�
FROM team t 
INNER JOIN player p ON t.team_id like p.team_id
WHERE p.team_id in('K02','K10')
    AND p.height BETWEEN 180 AND 183
ORDER BY height,t.team_name, p.player_name
;
--18
SELECT 
    p.player_name �����̸�,
    t.team_name ����,
    p.position ������,
    p.back_no ���ȣ
FROM player p 
    JOIN team t ON p.team_id LIKE t.team_id
WHERE p.PLAYER_NAME LIKE '��ȣ��'
;
--19
SELECT ROUND(avg(p.HEIGHT),2) ���Ű    
FROM player p 
    JOIN team t ON p.TEAM_ID = t.TEAM_ID
WHERE 
    t.team_name LIKE '��Ƽ��'
    AND p.position LIKE 'MF'
;
--20
SELECT
    (SELECT count(*)
     FROM schedule sc1
     WHERE sc1.sche_date LIKE '201201%' 
     ) "1�� ����"
     
FROM schedule sc 
WHERE 
    sc.sche_date LIKE '201201%' 
;

SELECT
    (SELECT count(*)
     FROM schedule sc1
     WHERE sc1.sche_date LIKE '201202%' 
     ) "2�� ����"
     
FROM schedule sc 
WHERE 
    sc.sche_date LIKE '201202%' 
;
--20
SELECT SC1.SCHE_DATE "1�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201201%'
;
SELECT count(*) "���� ����"
FROM schedule sc2
WHERE sc2.sche_date LIKE '201202%'
;
SELECT  COUNT(SC3.SCHE_DATE) 
FROM schedule sc3
WHERE sc3.sche_date LIKE '201203%'
;
SELECT count(*) "4�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201204%'
;
SELECT count(*) "5�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201205%'
;
SELECT count(*) "6�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201206%'
;
SELECT count(*) "7�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201207%'
;
SELECT count(*) "8�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201208%'
;
SELECT count(*) "9�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201209%'
;
SELECT count(*) "10�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201210%'
;
SELECT count(*) "11�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201211%'
;
SELECT count(*) "12�� ����"
FROM schedule sc1
WHERE sc1.sche_date LIKE '201212%'
;
 



