-- SOCCER_SQL_001
SELECT COUNT(*) 테이블의수   
FROM TAB;
-- SOCCER_SQL_002
SELECT team_name "전체 축구팀 목록"
FROM team
ORDER BY team_name desc
;
-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()
SELECT DISTINCT NVL2(position,position,'신입') as "포지션"
FROM player;
-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼
SELECT P.PLAYER_NAME 이름
FROM PLAYER P
WHERE P.TEAM_ID LIKE 'K02'
    AND P.POSITION LIKE 'GK' 
;
-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT position 포지션, player_name 이름
FROM player
WHERE team_id LIKE (
        SELECT t.team_id
        FROM team t
        WHERE t.region_name LIKE '수원')
    AND height >= 170
    AND player_name LIKE '고%'
;
-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함
SELECT SUBSTR(PLAYER_NAME,2,2) 테스트값
FROM PLAYER
;
-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
SELECT player_name ||'선수' 이름, NVL2(height,height,'0')||'cm'키, NVL2(weight,weight,'0') || 'kg' 몸무게
FROM player
WHERE team_id LIKE 'K02'
ORDER BY height DESC
;
-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
SELECT player_name ||'선수' 이름,
    NVL2(height,height,'0')||'cm'키,
    NVL2(weight,weight,'0') || 'kg' 몸무게 ,
    ROUND((weight /(height*height/10000)),2) BMI비만지수
FROM player
WHERE team_id = (
        SELECT t.team_id
        FROM team t
        WHERE t.region_name LIKE '수원')
ORDER BY height DESC
;
-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순
SELECT t.team_name, p.position, p.player_name
FROM team t INNER JOIN player p ON t.team_id like p.team_id
WHERE p.team_id in(
        SELECT t.team_id
        FROM team t
        WHERE t.team_name IN ('삼성블루윙즈','시티즌')
        )
    AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name
;
-- SOCCER_SQL_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순
SELECT p.height || 'cm' 키 ,t.team_name 팀명, p.player_name 이름
FROM team t
    JOIN player p ON t.team_id LIKE p.team_id
WHERE p.team_id IN(
        SELECT t.team_id
        FROM team t
        WHERE t.team_name IN ('삼성블루윙즈','시티즌')
    )
    AND (p.height BETWEEN 180 AND 183)
ORDER BY p.height,t.team_name, p.player_name
;
-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
SELECT t.team_name 팀, p.player_name 이름
FROM player p JOIN team t ON p.team_id LIKE t.team_id
WHERE p.position IS NULL
ORDER BY t.team_name, p.player_name
;
-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력
SELECT t.team_name 팀명, s.stadium_name 스타디움
FROM team t JOIN stadium s ON s.stadium_id LIKE t.stadium_id
ORDER BY t.team_name
;
-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 재경
SELECT t.team_name 팀명, st.stadium_name 스타디움,
    sc.awayteam_id 원정팀ID, sc.sche_date 스케쥴날짜
FROM ((stadium st
    JOIN team t ON t.stadium_id LIKE st.stadium_id)
    JOIN schedule sc ON st.stadium_id LIKE sc.stadium_id)
WHERE sc.sche_date = 20120317
;


-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
SELECT p.player_name 선수명,
    p.position 포지션,
    t.region_name||' '||t.team_name 팀명,
    st.stadium_name 스타디움,
    sc.sche_date 스케쥴날짜
FROM team t
    JOIN player p ON t.team_id LIKE p.team_id
    JOIN stadium st ON t.stadium_id LIKE st.stadium_id
    JOIN schedule sc ON st.STADIUM_ID LIKE sc.stadium_id  
WHERE p.position LIKE 'GK'
    AND t.team_id LIKE (
                        SELECT team_id
                        FROM team t
                        WHERE team_name LIKE '스틸러스'
                        )
    AND sc.sche_date = 20120317
ORDER BY p.player_name
;
-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT st.stadium_name 스타디움,
    sc.sche_date 경기날짜,
    t1.region_name||' '||t1.TEAM_NAME 홈팀,
    t2.region_name||' '||t2.team_name 원정팀,
    sc.home_score 홈팀점수,
    sc.away_score 원정팀점수    
FROM (((stadium st
    JOIN schedule sc ON st.stadium_id LIKE sc.stadium_id)
    JOIN team t1 ON t1.team_id LIKE sc.hometeam_id)
    JOIN team t2 ON t2.team_id LIKE sc.awayteam_id)
WHERE sc.home_score  >= sc.away_score +3
ORDER BY sc.sche_date
;
-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
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
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;
-- SOCCER_SQL_017
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
SELECT
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE
    exists (
        SELECT t1.team_id
        FROM team t1
        WHERE t1.team_id LIKE t.team_id
            AND t1.team_name in ('삼성블루윙즈','드래곤즈')
    )  
;
-- SOCCER_SQL_018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까
SELECT
    p.player_name 선수이름,
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 등번호
FROM player p
    JOIN team t ON p.team_id LIKE t.team_id
WHERE p.PLAYER_NAME LIKE '최호진'
;
-- SOCCER_SQL_019
-- 대전시티즌의 MF 평균키는 얼마입니까? 174.87
SELECT ROUND(avg(p.HEIGHT),2) 평균키    
FROM player p
    JOIN team t ON p.TEAM_ID LIKE t.TEAM_ID
WHERE
    t.team_name LIKE '시티즌'
    AND p.position LIKE 'MF'
;
-- SOCCER_SQL_020
-- 2012년 월별 경기수를 구하시오
SELECT DISTINCT
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201201%'
     )  "1월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201202%'
     )  "2월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201203%'
     )  "3월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201204%'
     )  "4월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201205%'
     )  "5월경기수",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201206%'
     )  "6월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201207%'
     )  "7월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201208%'
     )  "8월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201209%'
     )  "9월경기수",
     (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201210%'
     )  "10월경기수",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201211%'
     )  "11월경기수",
    (SELECT COUNT(*)
     FROM SCHEDULE SC
     WHERE SC.SCHE_DATE LIKE '201212%'
     )  "12월경기수"
FROM DUAL
;

-- SOCCER_SQL_021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...
SELECT SUBSTR(sche_date,1,6) 경기일자,
    COUNT(gubun) 경기수
FROM schedule 
WHERE gubun LIKE 'Y'
GROUP BY SUBSTR(sche_date,1,6)
ORDER BY SUBSTR(sche_date,1,6)
;

-- SOCCER_SQL_022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력
SELECT   
    ht.team_name 홈팀,
    at.team_name 원정팀
FROM schedule sc
    JOIN team ht ON sc.hometeam_id LIKE ht.TEAM_ID
    JOIN team at On sc.AWAYTEAM_ID LIKE at.TEAM_ID
WHERE
    sc.sche_date LIKE '20120914'
;
-- SOCCER_SQL_023
-- GROUP BY 사용
-- 팀별 선수의 수
-- 아이파크 20명
-- 드래곤즈 19명...
SELECT
    (SELECT A.TEAM_NAME
     FROM TEAM A
     WHERE A.TEAM_ID LIKE T.TEAM_ID
    )
     팀이름,
    COUNT(P.PLAYER_NAME)||'명' "팀별 선수의 수"
FROM TEAM T
    JOIN PLAYER P ON  T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
;
-- SOCCER_SQL_024
-- 선수들 포지션(한글 표시) 목록
-- 없으면 '없음'으로 표시
SELECT
    T.TEAM_NAME 팀명,
    AVG(P.HEIGHT) "골키퍼 평균키"
FROM
    PLAYER P JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
WHERE
    P.POSITION LIKE 'GK'
GROUP BY
    T.TEAM_NAME
;
-- SOCCER_SQL_025
-- 삼성블루윙즈에서 키순으로  11위부터
-- 20위까지 출력
SELECT B.*
FROM (
    SELECT   
        ROWNUM NO,
        A.*
    FROM (
        SELECT          
             T.TEAM_NAME 팀명,
             P.PLAYER_NAME 선수명,
             P.POSITION 포지션,
             P.BACK_NO 백넘버,
             P.HEIGHT ||'CM' 키
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
                        T1.TEAM_NAME LIKE '삼성블루윙즈'
                    )
            AND P.HEIGHT IS NOT NULL  
            
        ORDER BY
            P.HEIGHT DESC    
        ) A
    ) B
WHERE B.NO BETWEEN 11 AND 20
;
-- SOCCER_SQL_026
-- 팀별 골키퍼의 평균 키에서
-- 가장 평균키가 큰 팀명은 ? 울산 현대
SELECT
    A.팀명    
FROM (
    SELECT    
        (SELECT T1.TEAM_NAME
        FROM TEAM T1
        WHERE T1.TEAM_ID LIKE T.TEAM_ID) 팀명,
        AVG(P.HEIGHT) 평균키    
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
-- 각 구단별 선수들 평균키가 삼성 블루윙즈팀의
-- 평균키보다 작은 팀의 이름과 해당 팀의 평균키를 
-- 구하시오 
SELECT A.*
FROM (
    SELECT
        (SELECT T1.TEAM_NAME
        FROM TEAM T1
        WHERE T.TEAM_ID LIKE T1.TEAM_ID) 팀명,
        ROUND(AVG(P.HEIGHT),2) 평균키
    FROM PLAYER P
        JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY T.TEAM_ID
    ORDER BY AVG(P.HEIGHT) DESC
     ) A
WHERE A.평균키 <   (SELECT AVG(P.HEIGHT)
                    FROM PLAYER P
                        JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
                    WHERE
                        T.TEAM_ID LIKE (SELECT S.TEAM_ID
                                      FROM TEAM S
                                      WHERE S.TEAM_NAME LIKE '삼성블루윙즈'))
;
-- SOCCER_SQL_028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 
-- 20120317, 일화천마 VS 유나이티드, 6점차경기
--CASE
--    WHEN (SC.HOME_SCORE - SC.AWAY_SCORE)>=0 THEN (SC.HOME_SCORE - SC.AWAY_SCORE)
--    ELSE (SC.HOME_SCORE - SC.AWAY_SCORE)*(-1)
--END 
SELECT A.*
FROM (
    SELECT
        HT.TEAM_NAME 홈팀,
        AT.TEAM_NAME 원정팀,
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
-- 좌석수가 많은 대로 스타디움 순서 매기기
SELECT
    ROWNUM NO,
    A.*
FROM (
    SELECT
        S.STADIUM_NAME 스타디움,
        S.SEAT_COUNT 좌석수
    FROM STADIUM S
    ORDER BY
        S.SEAT_COUNT DESC
    ) A
;
-- SOCCER_SQL_030
-- 2012년 구단 승리 순으로 순위매기기
-- 
SELECT
    SC.SCHE_DATE,
    CASE
        WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
        WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN AT.TEAM_NAME
        ELSE NULL
    END 승리팀

FROM SCHEDULE SC
    JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
    JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID   
;
SELECT
    A.승리팀,
    COUNT(A.승리팀) 승리횟수
FROM (  SELECT
        SC.SCHE_DATE,
        CASE
            WHEN SC.HOME_SCORE > SC.AWAY_SCORE THEN HT.TEAM_NAME
            WHEN SC.HOME_SCORE < SC.AWAY_SCORE THEN AT.TEAM_NAME
            ELSE NULL
        END 승리팀

        FROM SCHEDULE SC
            JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
            JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID 
        WHERE SC.GUBUN LIKE 'Y'
            AND SC.SCHE_DATE LIKE '2012%') A
WHERE 
    승리팀 IS NOT NULL
GROUP BY
    A.승리팀
ORDER BY
    COUNT(A.승리팀) DESC
;

    
