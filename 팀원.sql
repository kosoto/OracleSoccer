--�� ���̺� ����
CREATE TABLE TEAMZ(
    TEAM_ID VARCHAR2(10) PRIMARY KEY,
    TEAM_NAME VARCHAR(20)
)
;
--�� ���̺� ä���
INSERT INTO TEAMZ
VALUES('ATEAM','����Ƽ��');

INSERT INTO TEAMZ
VALUES('HTEAM','��ī��');

INSERT INTO TEAMZ
VALUES('CTEAM','������');

INSERT INTO TEAMZ
VALUES('STEAM','�����');
--���� ���̺� ����
CREATE TABLE TEAMW(
    MEM_ID VARCHAR2(10) PRIMARY KEY,
    TEAM_ID VARCHAR2(10),
    MEM_NAME VARCHAR2(10),
    MEM_AGE DECIMAL
)
;
--���� ���̺� FK �߰�
ALTER TABLE TEAMW
ADD CONSTRAINT TEAMW_FK_TEAM_ID 
FOREIGN KEY (TEAM_ID) REFERENCES TEAMZ(TEAM_ID);
SELECT * FROM TEAMW;
--���� ���̺� ä���
--A��
INSERT INTO TEAMW VALUES
(
   'A1', 'ATEAM', '����',34 
);
INSERT INTO TEAMW VALUES
(
   'A2', 'ATEAM', '����',35 
);
INSERT INTO TEAMW VALUES
(
   'A3', 'ATEAM', '����',21 
);
INSERT INTO TEAMW VALUES
(
   'A4', 'ATEAM', '����',29 
);
INSERT INTO TEAMW VALUES
(
   'A5', 'ATEAM', '����',25 
);
--H��
INSERT INTO TEAMW VALUES
(
   'H1', 'HTEAM', '����',26 
);
INSERT INTO TEAMW VALUES
(
   'H2', 'HTEAM', '����',26 
);
INSERT INTO TEAMW VALUES
(
   'H3', 'HTEAM', '��',27 
);
INSERT INTO TEAMW VALUES
(
   'H4', 'HTEAM', '���',30 
);
INSERT INTO TEAMW VALUES
(
   'H5', 'HTEAM', '�ܾ�',26 
);
--C��
INSERT INTO TEAMW VALUES
(
   'C1', 'CTEAM', '������',32 
);
INSERT INTO TEAMW VALUES
(
   'C2', 'CTEAM', '����ȣ',31 
);
INSERT INTO TEAMW VALUES
(
   'C3', 'CTEAM', '����',29 
);
INSERT INTO TEAMW VALUES
(
   'C4', 'CTEAM', '����',23 
);
INSERT INTO TEAMW VALUES
(
   'C5', 'CTEAM', '����',30 
);
--S��
INSERT INTO TEAMW VALUES
(
   'S1', 'STEAM', '��ȣ',27 
);
INSERT INTO TEAMW VALUES
(
   'S2', 'STEAM', '����',26 
);
INSERT INTO TEAMW VALUES
(
   'S3', 'STEAM', '�̽�',29 
);
INSERT INTO TEAMW VALUES
(
   'S4', 'STEAM', '����',26 
);
INSERT INTO TEAMW VALUES
(
   'S5', 'STEAM', '����',30 
);
--���� ���̺� ��Ȱ COLUMN �߰�
ALTER TABLE TEAMW 
ADD ROLL VARCHAR2(20)  
;
--���� ���̺� ��Ȱ �ο�
UPDATE TEAMW
SET ROLL = 
    CASE 
        WHEN MEM_NAME IN ('��ȣ','����','������','����') THEN '����'
        ELSE '����'
    END
WHERE ROLL IS NULL
;

--COUNT() ������
--SUM() ���� ������
--MAX() ���� ���� �ִ�ġ
--MIN() ���� ���� �ּ�ġ
--AVG() ���� ���� ���
SELECT
    (SELECT ZZ.TEAM_NAME
    FROM TEAMZ ZZ
    WHERE ZZ.TEAM_ID LIKE W.TEAM_ID
       -- AND zz.team_id LIKE w.team_id
    ) ����, 
    COUNT(W.MEM_ID) "���� ��",
    SUM(W.MEM_AGE) "���� ������",
    MAX(W.MEM_AGE) "���� ���� �ִ�ġ",
    MIN(W.MEM_AGE) "���� ���� �ּ�ġ",
    AVG(W.MEM_AGE) "���� ���� ���",
    (SELECT W1.MEM_NAME 
     FROM TEAMW W1             
     WHERE W1.ROLL LIKE '����'
         AND W.TEAM_ID LIKE W1.TEAM_ID) "����"
FROM TEAMW W 
    JOIN TEAMZ Z ON W.TEAM_ID LIKE Z.TEAM_ID
GROUP BY 
    W.TEAM_ID
--HAVING AVG(W.MEM_AGE) >= 28   
ORDER BY SUM(W.MEM_AGE) DESC
;


--SQL�� Switch
--SELECT 
--    PLAYER_NAME,    
--    CASE
--        WHEN POSITION IS NULL THEN '����'
--        WHEN POSITION LIKE 'GK' THEN '��Ű��'
--        WHEN POSITION LIKE 'MF' THEN '�̵��ʴ�'
--        WHEN POSITION LIKE 'DF' THEN '�����'
--        WHEN POSITION LIKE 'FW' THEN '���ݼ�'
--        ELSE POSITION
--    END ������
--FROM
--    PLAYER
--WHERE
--    TEAM_ID LIKE 'K08'
--ORDER BY ������ 
--;    
