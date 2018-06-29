--1
SELECT COUNT(*) ���̺��Ǽ�
FROM TAB;
--2
SELECT team_name ��ü�౸�����
FROM team
;
--3
SELECT DISTINCT position ������
FROM player
;
--4
SELECT DISTINCT NVL2(position,position,'����') ������
FROM player
;
--5
SELECT position ������, player_name �̸�
fROM player
WHERE position like 'MF'
    AND player_name like '��%'
    AND team_id LIKE 'K02'
    AND height >= 170
;
--6
SELECT player_name �̸�, NVL2(height,height,0) || 'cm' Ű, NVL2(weight,weight,0) ||'kg' ������
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
; 
--7
SELECT player_name �̸�, 
    NVL2(height,height,0) || 'cm' Ű, 
    NVL2(weight,weight,0) ||'kg' ������,
    ROUND((weight/((height/100)*(height/100))),2) BMI������
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
SELECT height || 'cm' Ű, team_name ����, player_name �̸�
FROM player p, team t
WHERE p.team_id Like t.team_id
    AND t.team_id in ('K02','K10')
    AND height BETWEEN 180 AND 183
ORDER BY height,t.team_name,p.player_name
;
