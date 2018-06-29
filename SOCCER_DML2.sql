-- SOCCER_SQL_001
SELECT COUNT(*) ���̺��Ǽ�   
FROM TAB;
-- SOCCER_SQL_002
SELECT team_name "��ü �౸�� ���"
FROM team
ORDER BY team_name desc
;
-- SOCCER_SQL_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- NVL2()
SELECT DISTINCT NVL2(position,position,'����') as "������"
FROM player;
-- SOCCER_SQL_004
-- ������(ID: K02)��Ű��
SELECT P.PLAYER_NAME �̸�
FROM PLAYER P
WHERE P.TEAM_ID LIKE 'K02'
    AND P.POSITION LIKE 'GK' 
;
-- SOCCER_SQL_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT position ������, player_name �̸�
FROM player
WHERE team_id LIKE (
        SELECT t.team_id
        FROM team t
        WHERE t.region_name LIKE '����')
    AND height >= 170
    AND player_name LIKE '��%'
;
-- SUBSTR('ȫ�浿',2,2) �ϸ�
-- �浿�� ��µǴµ�
-- ��2�� ������ġ, ��2�� ���ڼ��� ����
SELECT SUBSTR(PLAYER_NAME,2,2) �׽�Ʈ��
FROM PLAYER
;
-- SOCCER_SQL_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT player_name ||'����' �̸�, NVL2(height,height,'0')||'cm'Ű, NVL2(weight,weight,'0') || 'kg' ������
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;
-- SOCCER_SQL_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT player_name ||'����' �̸�,
    NVL2(height,height,'0')||'cm'Ű,
    NVL2(weight,weight,'0') || 'kg' ������ ,
    ROUND((weight /(height*height/10000)),2) BMI������
FROM player
WHERE team_id = (
        SELECT t.team_id
        FROM team t
        WHERE t.region_name LIKE '����')
ORDER BY height DESC
;
-- SOCCER_SQL_008
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- GK �������� ����
-- ����, ����� ��������
SELECT t.team_name, p.position, p.player_name
FROM team t INNER JOIN player p ON t.team_id like p.team_id
WHERE p.team_id in(
        SELECT t.team_id
        FROM team t
        WHERE t.team_name IN ('�Ｚ�������','��Ƽ��')
        )
    AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name
;
-- SOCCER_SQL_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
SELECT p.height || 'cm' Ű ,t.team_name ����, p.player_name �̸�
FROM team t
    JOIN player p ON t.team_id LIKE p.team_id
WHERE p.team_id IN(
        SELECT t.team_id
        FROM team t
        WHERE t.team_name IN ('�Ｚ�������','��Ƽ��')
    )
    AND (p.height BETWEEN 180 AND 183)
ORDER BY p.height,t.team_name, p.player_name
;
-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT t.team_name ��, p.player_name �̸�
FROM player p JOIN team t ON p.team_id LIKE t.team_id
WHERE p.position IS NULL
ORDER BY t.team_name, p.player_name
;
-- SOCCER_SQL_011
-- ���̸�, ��Ÿ��� �̸� ���
SELECT t.team_name ����, s.stadium_name ��Ÿ���
FROM team t JOIN stadium s ON s.stadium_id LIKE t.stadium_id
ORDER BY t.team_name
;
-- SOCCER_SQL_012
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- ���
SELECT t.team_name ����, st.stadium_name ��Ÿ���,
    sc.awayteam_id ������ID, sc.sche_date �����쳯¥
FROM ((stadium st
    JOIN team t ON t.stadium_id LIKE st.stadium_id)
    JOIN schedule sc ON st.stadium_id LIKE sc.stadium_id)
WHERE sc.sche_date = 20120317
;


-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
SELECT p.player_name ������,
    p.position ������,
    t.region_name||' '||t.team_name ����,
    st.stadium_name ��Ÿ���,
    sc.sche_date �����쳯¥
FROM team t
    JOIN player p ON t.team_id LIKE p.team_id
    JOIN stadium st ON t.stadium_id LIKE st.stadium_id
    JOIN schedule sc ON st.STADIUM_ID LIKE sc.stadium_id  
WHERE p.position LIKE 'GK'
    AND t.team_id LIKE (
                        SELECT team_id
                        FROM team t
                        WHERE team_name LIKE '��ƿ����'
                        )
    AND sc.sche_date = 20120317
ORDER BY p.player_name
;
-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT st.stadium_name ��Ÿ���,
    sc.sche_date ��⳯¥,
    t1.region_name||' '||t1.TEAM_NAME Ȩ��,
    t2.region_name||' '||t2.team_name ������,
    sc.home_score Ȩ������,
    sc.away_score ����������    
FROM (((stadium st
    JOIN schedule sc ON st.stadium_id LIKE sc.stadium_id)
    JOIN team t1 ON t1.team_id LIKE sc.hometeam_id)
    JOIN team t2 ON t2.team_id LIKE sc.awayteam_id)
WHERE sc.home_score  >= sc.away_score +3
ORDER BY sc.sche_date
;
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
SELECT
  S.STADIUM_NAME,
  S.STADIUM_ID,
  S.SEAT_COUNT,
  S.HOMETEAM_ID,
  T.E_TEAM_NAME
FROM STADIUM S
  LEFT JOIN TEAM T
    ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY S.HOMETEAM_ID
;
-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- UNION VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;
-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
SELECT
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE
    exists (
        SELECT t1.team_id
        FROM team t1
        WHERE t1.team_id LIKE t.team_id
            AND t1.team_name in ('�Ｚ�������','�巡����')
    )  
;
-- SOCCER_SQL_018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�
SELECT
    p.player_name �����̸�,
    t.team_name ����,
    p.position ������,
    p.back_no ���ȣ
FROM player p
    JOIN team t ON p.team_id LIKE t.team_id
WHERE p.PLAYER_NAME LIKE '��ȣ��'
;
-- SOCCER_SQL_019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�? 174.87
SELECT ROUND(avg(p.HEIGHT),2) ���Ű    
FROM player p
    JOIN team t ON p.TEAM_ID LIKE t.TEAM_ID
WHERE
    t.team_name LIKE '��Ƽ��'
    AND p.position LIKE 'MF'
;
-- SOCCER_SQL_020
-- 2012�� ���� ������ ���Ͻÿ�
SELECT DISTINCT
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201201%'
     )  "1������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201202%'
     )  "2������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201203%'
     )  "3������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201204%'
     )  "4������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201205%'
     )  "5������",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201206%'
     )  "6������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201207%'
     )  "7������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201208%'
     )  "8������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201209%'
     )  "9������",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201210%'
     )  "10������",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201211%'
     )  "11������",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201212%'
     )  "12������"
FROM DUAL
;

-- SOCCER_SQL_021
-- 2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
-- ����� 1��:20��� �̷�������...
SELECT SUBSTR(sche_date,1,6) �������,
    COUNT(gubun) ����
FROM schedule 
WHERE gubun LIKE 'Y'
GROUP BY SUBSTR(sche_date,1,6)
ORDER BY SUBSTR(sche_date,1,6)
;

-- SOCCER_SQL_022
-- 2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��: ?   ������: ? �� ���
SELECT   
    ht.team_name Ȩ��,
    at.team_name ������
FROM schedule sc
    JOIN team ht ON sc.hometeam_id LIKE ht.TEAM_ID
    JOIN team at On sc.AWAYTEAM_ID LIKE at.TEAM_ID
WHERE
    sc.sche_date LIKE '20120914'
;
-- SOCCER_SQL_023
-- GROUP BY ���
-- ���� ������ ��
-- ������ũ 20��
-- �巡���� 19��...
SELECT
    (SELECT A.TEAM_NAME
     FROM TEAM A
     WHERE A.TEAM_ID LIKE T.TEAM_ID
    )
     ���̸�,
    COUNT(P.PLAYER_NAME)||'��' "���� ������ ��"
FROM TEAM T
    JOIN PLAYER P ON  T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
;
-- SOCCER_SQL_024
-- ������ ������(�ѱ� ǥ��) ���
-- ������ '����'���� ǥ��
SELECT
    T.TEAM_NAME ����,
    AVG(P.HEIGHT) "��Ű�� ���Ű"
FROM
    PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
WHERE
    P.POSITION LIKE 'GK'
GROUP BY
    T.TEAM_NAME
;
-- SOCCER_SQL_025
-- �Ｚ�������� Ű������  11������
-- 20������ ���
SELECT B.*
FROM (
    SELECT   
        ROWNUM NO,
        A.*
    FROM (
        SELECT          
             T.TEAM_NAME ����,
             P.PLAYER_NAME ������,
             P.POSITION ������,
             P.BACK_NO ��ѹ�,
             P.HEIGHT ||'CM' Ű
        FROM PLAYER P
            JOIN TEAM T
                ON P.TEAM_ID LIKE T.TEAM_ID
        WHERE
            T.TEAM_ID LIKE (
                    SELECT
                        T1.TEAM_ID
                    FROM
                        TEAM T1
                    WHERE
                        T1.TEAM_NAME LIKE '�Ｚ�������'
                    )
            AND P.HEIGHT IS NOT NULL  
            
        ORDER BY
            P.HEIGHT DESC    
        ) A
    ) B
WHERE B.NO BETWEEN 11 AND 20
;
-- SOCCER_SQL_026
-- ���� ��Ű���� ��� Ű����
-- ���� ���Ű�� ū ������ ? ��� ����
SELECT
    A.����    
FROM (
    SELECT    
        (SELECT T1.TEAM_NAME
        FROM TEAM T1
        WHERE T1.TEAM_ID LIKE T.TEAM_ID) ����,
        AVG(P.HEIGHT) ���Ű    
    FROM PLAYER P
        JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
    WHERE
        P.POSITION LIKE 'GK'
    GROUP BY
        T.TEAM_ID
    ORDER BY
        AVG(P.HEIGHT) DESC
        ) A
WHERE ROWNUM = 1
;
-- SOCCER_SQL_027
-- �� ���ܺ� ������ ���Ű�� �Ｚ �����������
-- ���Ű���� ���� ���� �̸��� �ش� ���� ���Ű�� 
-- ���Ͻÿ� 
SELECT A.*
FROM (
    SELECT
        (SELECT T1.TEAM_NAME
        FROM TEAM T1
        WHERE T.TEAM_ID LIKE T1.TEAM_ID) ����,
        ROUND(AVG(P.HEIGHT),2) ���Ű
    FROM PLAYER P
        JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY T.TEAM_ID
    ORDER BY AVG(P.HEIGHT) DESC
     ) A
WHERE A.���Ű <   (SELECT AVG(P.HEIGHT)
                    FROM PLAYER P
                        JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
                    WHERE
                        T.TEAM_ID LIKE (SELECT S.TEAM_ID
                                      FROM TEAM S
                                      WHERE S.TEAM_NAME LIKE '�Ｚ�������'))
;
-- SOCCER_SQL_028
-- 2012�� ��� �߿��� �������� ���� ū ��� 
-- 20120317, ��ȭõ�� VS ������Ƽ��, 6�������
--CASE
--    WHEN (SC.HOME_SCORE - SC.AWAY_SCORE)>=0 THEN (SC.HOME_SCORE - SC.AWAY_SCORE)
--    ELSE (SC.HOME_SCORE - SC.AWAY_SCORE)*(-1)
--END 
SELECT A.*
FROM (
    SELECT
        HT.TEAM_NAME Ȩ��,
        AT.TEAM_NAME ������,
        CASE
            WHEN (SC.HOME_SCORE - SC.AWAY_SCORE)>=0 THEN (SC.HOME_SCORE - SC.AWAY_SCORE)
            ELSE (SC.HOME_SCORE - SC.AWAY_SCORE)*(-1)
        END  SCORE    
    FROM SCHEDULE SC
        JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
        JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
    WHERE
        SC.SCHE_DATE LIKE '2012%'
        AND SC.GUBUN LIKE 'Y'
    ORDER BY
        SCORE DESC
    ) A
WHERE
    A.SCORE LIKE (
        SELECT B.*
        FROM (SELECT       
                CASE
                    WHEN (SC.HOME_SCORE - SC.AWAY_SCORE)>=0 THEN (SC.HOME_SCORE - SC.AWAY_SCORE)
                    ELSE (SC.HOME_SCORE - SC.AWAY_SCORE)*(-1)
                END  SCORE    
            FROM SCHEDULE SC
                JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
                JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
            WHERE
                SC.SCHE_DATE LIKE '2012%'
                AND SC.GUBUN LIKE 'Y'
            ORDER BY
                ABS(SC.HOME_SCORE - SC.AWAY_SCORE) DESC) B
        WHERE ROWNUM = 1)
;
-- SOCCER_SQL_029
-- �¼����� ���� ��� ��Ÿ��� ���� �ű��
SELECT
    ROWNUM NO,
    A.*
FROM (
    SELECT
        S.STADIUM_NAME ��Ÿ���,
        S.SEAT_COUNT �¼���
    FROM STADIUM S
    ORDER BY
        S.SEAT_COUNT DESC
    ) A
;
-- SOCCER_SQL_030
-- 2012�� ���� �¸� ������ �����ű��
-- 
SELECT
    SC.SCHE_DATE,
    CASE
        WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
        WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN AT.TEAM_NAME
        ELSE NULL
    END �¸���

FROM SCHEDULE SC
    JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
    JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID   
;
SELECT
    A.�¸���,
    COUNT(A.�¸���) �¸�Ƚ��
FROM (  SELECT
        SC.SCHE_DATE,
        CASE
            WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
            WHEN SC.HOME_SCORE < SC.AWAY_SCORE THEN AT.TEAM_NAME
            ELSE NULL
        END �¸���

        FROM SCHEDULE SC
            JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
            JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID 
        WHERE SC.GUBUN LIKE 'Y'
            AND SC.SCHE_DATE LIKE '2012%') A
WHERE 
    �¸��� IS NOT NULL
GROUP BY
    A.�¸���
ORDER BY
    COUNT(A.�¸���) DESC
;

    
