-- Bài tập 2.3 
-- 1. Tạo bảng DEPT
CREATE TABLE dept (
    deptno NUMBER(2) CONSTRAINT pk_dept PRIMARY KEY,
    dname  VARCHAR2(14),
    loc    VARCHAR2(13)
);

-- 2. Tạo bảng EMP
CREATE TABLE emp (
    empno    NUMBER(4) CONSTRAINT pk_emp PRIMARY KEY,
    ename    VARCHAR2(10),
    job      VARCHAR2(9),
    mgr      NUMBER(4),
    hiredate DATE,
    sal      NUMBER(7,2),
    comm     NUMBER(7,2),
    deptno   NUMBER(2) CONSTRAINT fk_deptno REFERENCES dept(deptno)
);

-- 3. Tạo bảng Mức lương (SALGRADE)
CREATE TABLE salgrade (
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);

-- Chèn bảng DEPT
INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

-- Chèn bảng EMP
INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',     7902, TO_DATE('17-12-1980','DD-MM-YYYY'), 800,  NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN',  7698, TO_DATE('20-02-1981','DD-MM-YYYY'), 1600, 300,  30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN',  7698, TO_DATE('22-02-1981','DD-MM-YYYY'), 1250, 500,  30);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',   7839, TO_DATE('02-04-1981','DD-MM-YYYY'), 2975, NULL, 20);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN',  7698, TO_DATE('28-09-1981','DD-MM-YYYY'), 1250, 1400, 30);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',   7839, TO_DATE('01-05-1981','DD-MM-YYYY'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',   7839, TO_DATE('09-06-1981','DD-MM-YYYY'), 2450, NULL, 10);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',   7566, TO_DATE('19-04-1987','DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT', NULL, TO_DATE('17-11-1981','DD-MM-YYYY'), 5000, NULL, 10);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN',  7698, TO_DATE('08-09-1981','DD-MM-YYYY'), 1500, 0,    30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',     7788, TO_DATE('23-05-1987','DD-MM-YYYY'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',     7698, TO_DATE('03-12-1981','DD-MM-YYYY'), 950,  NULL, 30);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',   7566, TO_DATE('03-12-1981','DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',     7782, TO_DATE('23-01-1982','DD-MM-YYYY'), 1300, NULL, 10);

-- Chèn bảng SALGRADE
INSERT INTO salgrade VALUES (1, 700,  1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
INSERT INTO salgrade VALUES (5, 3001, 9999);

-- Xác nhận lưu dữ liệu
COMMIT;

-- Câu 1: Chọn toàn bộ thông tin trong bảng SALGRADE
SELECT * FROM salgrade;

-- Câu 2: Chọn toàn bộ thông tin trong bảng EMP
SELECT * FROM emp;

-- Câu 3: Hiển thị danh sách các nghề nghiệp không trùng lặp và sắp xếp theo tên
SELECT DISTINCT job FROM emp ORDER BY job;

-- Câu 4: Tính tổng thu nhập trong một năm (Lương + Hoa hồng)
SELECT ename, (sal + NVL(comm, 0)) * 12 AS remuneration FROM emp;

-- Câu 5: Hiển thị chuỗi thông tin chi tiết dạng "Who, what and when"
SELECT ename || ' HAS HELD THE POSITION OF ' || job || 
       ' IN DEPT ' || deptno || 
       ' SINCE ' || TO_CHAR(hiredate, 'DD-MM-YYYY') AS "Who, what and when"
FROM emp;

-- Câu 6: Xem cấu trúc bảng emp
DESC emp;

-- Câu 7: Hiển thị bảng kèm định dạng tiền tệ ($) và tiêu đề cột chuẩn (Salary / Hire Date)
SELECT 
    ename AS "Employee Name",
    TO_CHAR(sal, '$99,999.00') AS "Salary",
    TO_CHAR(hiredate, 'DD-MM-YYYY') AS "Hire Date"
FROM emp;

-- Bài tập 3.3
-- Câu 1: Chọn nhân viên trong bảng EMP có mức lương từ 1000 đến 2000 (chọn các trường ENAME, DEPTNO, SAL)[cite: 22, 114]
SELECT ename, deptno, sal 
FROM emp 
WHERE sal BETWEEN 1000 AND 2000;

-- Câu 2: Hiển thị mã phòng ban, tên phòng ban, sắp xếp theo thứ tự tên phòng ban[cite: 22, 114]
SELECT deptno, dname 
FROM dept 
ORDER BY dname;

-- Câu 3: Hiển thị danh sách những nhân viên làm tại phòng 10 và 20 theo thứ tự A, B, C[cite: 22, 114]
SELECT * 
FROM emp 
WHERE deptno IN (10, 20) 
ORDER BY ename;

-- Câu 4: Hiển thị tên và nghề nghiệp những nhân viên làm nghề thư ký (CLERK) tại phòng 20[cite: 22, 114]
SELECT ename, job 
FROM emp 
WHERE job = 'CLERK' AND deptno = 20;

-- Câu 5: Hiển thị tất cả những nhân viên mà tên có các ký tự TH và LL[cite: 23, 115]
SELECT ename 
FROM emp 
WHERE ename LIKE '%TH%' OR ename LIKE '%LL%';

-- Câu 6: Hiển thị tên nhân viên, nghề nghiệp, lương của những nhân viên có giám đốc quản lý[cite: 23, 115]
SELECT ename, job, sal 
FROM emp 
WHERE mgr IS NOT NULL;

-- Câu 7: Hiển thị tên nhân viên, mã phòng ban, ngày gia nhập công ty sao cho gia nhập công ty trong năm 1983[cite: 23, 115]
SELECT ename, deptno, hiredate 
FROM emp 
WHERE TO_CHAR(hiredate, 'YYYY') = '1983';

-- Câu 8: Hiển thị lương một năm (ANUAL_SAL), thưởng sao cho lương lớn hơn thưởng và nghề nghiệp là SALESMAN, sắp theo thứ tự lương giảm dần và tên tăng dần[cite: 23, 115]
SELECT sal * 12 AS ANUAL_SAL, comm 
FROM emp 
WHERE sal > comm AND job = 'SALESMAN' 
ORDER BY sal DESC, ename ASC;

-- Bài tập 4.5
-- Câu 1: Liệt kê tên nhân viên, mã phòng ban và lương nhân viên được tăng 15% (PCTSAL)
SELECT deptno, ename, sal * 1.15 AS pctsal 
FROM emp;

-- Câu 2: Hiển thị tên đệm dấu sao bên phải và nghề nghiệp đệm dấu sao bên trái (EMPLOYEE_AND_JOB)
SELECT RPAD(ename, 9, '*') || LPAD(job, 12, '*') AS employee_and_job 
FROM emp;

-- Câu 3: Hiển thị tên nhân viên kèm theo nghề nghiệp viết hoa chữ cái đầu trong ngoặc tròn (EMPLOYEE)
SELECT ename || ' (' || INITCAP(job) || ')' AS employee 
FROM emp;

-- Câu 4: Hiển thị tên, mã phòng ban và nghề nghiệp đổi tên thành Salesperson cho các salesman thuộc phòng 30
SELECT ename, deptno, 
       CASE 
           WHEN job = 'SALESMAN' THEN 'Salesperson' 
           ELSE INITCAP(job) 
       END AS job 
FROM emp 
WHERE deptno = 30;

-- Câu 5: Tìm ngày thứ 6 đầu tiên cách 2 tháng so với ngày hiện tại (Định dạng: 09 February 1990)
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 2), 'FRIDAY'), 'DD Month YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') AS first_friday 
FROM dual;

-- Câu 6: Tìm thông tin tên nhân viên, ngày gia nhập công ty của phòng số 20 theo định dạng chữ đặc biệt
SELECT ename, 
       LOWER(TO_CHAR(hiredate, 'month', 'NLS_DATE_LANGUAGE=ENGLISH')) || ',' || 
       TO_CHAR(hiredate, 'DDSPTH YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') AS date_hired 
FROM emp 
WHERE deptno = 20;

-- Câu 7: Hiển thị tên nhân viên, ngày gia nhập công ty, ngày xét nâng lương (sau 1 năm), sắp xếp theo ngày xét
SELECT ename, 
       TO_CHAR(hiredate, 'DD-MM-YYYY') AS hiredate, 
       TO_CHAR(ADD_MONTHS(hiredate, 12), 'DD-MM-YYYY') AS review 
FROM emp 
ORDER BY ADD_MONTHS(hiredate, 12) ASC;

-- Câu 8: Hiển thị tên nhân viên và lương dưới dạng phân loại (On Target / BELOW 1500 / Giá trị lương)
SELECT ename, 
       CASE 
           WHEN job = 'SALESMAN' AND sal = 1500 THEN 'On Target'
           WHEN sal < 1500 THEN 'BELOW 1500'
           ELSE TO_CHAR(sal)
       END AS salary
FROM emp;

-- Câu 9: Cho biết thứ của ngày hiện tại
SELECT TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE=VIETNAMESE') AS current_day 
FROM dual;

-- Câu 10: Đưa chuỗi dưới dạng nn/nn, kiểm tra nếu đúng khuôn dạng trả lời YES, ngược lại NO
SELECT '12/34' AS value, CASE WHEN REGEXP_LIKE('12/34', '^\d{2}/\d{2}$') THEN 'YES' ELSE 'NO' END AS valid FROM dual
UNION ALL
SELECT '01/1a', CASE WHEN REGEXP_LIKE('01/1a', '^\d{2}/\d{2}$') THEN 'YES' ELSE 'NO' END FROM dual
UNION ALL
SELECT '99\88', CASE WHEN REGEXP_LIKE('99\88', '^\d{2}/\d{2}$') THEN 'YES' ELSE 'NO' END FROM dual;

-- Câu 11: Hiển thị tên nhân viên, ngày gia nhập, ngày lĩnh lương (Thứ 6 sau ít nhất 15 ngày làm việc), sắp xếp theo ngày gia nhập
SELECT ename, 
       TO_CHAR(hiredate, 'DD-MM-YYYY') AS hiredate, 
       TO_CHAR(NEXT_DAY(hiredate + 15 - 1, 'FRIDAY'), 'DD-MM-YYYY') AS pay_day 
FROM emp 
ORDER BY hiredate ASC;

-- Bài tập 5.4
-- Câu 1: Hiển thị toàn bộ tên nhân viên và tên phòng ban làm việc sắp xếp theo tên phòng ban
SELECT e.ename, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
ORDER BY d.dname ASC;

-- Câu 2: Hiển thị tên nhân viên, vị trí địa lý, tên phòng với điều kiện lương > 1500
SELECT e.ename, d.loc, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
WHERE e.sal > 1500;

-- Câu 3: Hiển thị tên nhân viên, nghề nghiệp, lương và mức lương (grade)
SELECT e.ename, e.job, e.sal, s.grade 
FROM emp e 
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
ORDER BY s.grade ASC, e.sal ASC;

-- Câu 4: Hiển thị tên nhân viên, nghề nghiệp, lương và mức lương, với điều kiện mức lương = 3
SELECT e.ename, e.job, e.sal, s.grade 
FROM emp e 
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
WHERE s.grade = 3;

-- Câu 5: Hiển thị những nhân viên làm việc tại DALLAS
SELECT e.ename, d.loc, e.sal 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
WHERE d.loc = 'DALLAS';

-- Câu 6: Hiển thị tên nhân viên, nghề nghiệp, lương, mức lương, tên phòng trừ nhân viên làm nghề CLERK, sắp xếp giảm dần theo lương
SELECT e.ename, e.job, e.sal, s.grade, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
WHERE UPPER(e.job) != 'CLERK' 
ORDER BY e.sal DESC;

-- Câu 7: Hiển thị chi tiết nhân viên kiếm được 36,000/năm (lương 3000/tháng) hoặc nghề là CLERK
SELECT e.ename, e.job, e.sal * 12 AS anual_sal, d.dname, s.grade 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
WHERE (e.sal * 12) = 36000 OR UPPER(e.job) = 'CLERK';

-- Câu 8: Hiển thị những phòng không có nhân viên nào làm việc
SELECT d.deptno, d.dname, d.loc 
FROM dept d 
LEFT JOIN emp e ON d.deptno = e.deptno 
WHERE e.empno IS NULL;

-- Câu 9: Hiển thị tên nhân viên, lương nhân viên, tên người quản lý và lương người quản lý
SELECT e.ename AS emp_name, e.sal AS emp_sal, m.ename AS mgr_name, m.sal AS mgr_sal 
FROM emp e 
JOIN emp m ON e.mgr = m.empno;

-- Câu 10: Như câu 9 nhưng hiển thị thêm thông tin của KING (sử dụng LEFT JOIN)
SELECT e.ename AS emp_name, e.sal AS emp_sal, m.ename AS mgr_name, m.sal AS mgr_sal 
FROM emp e 
LEFT JOIN emp m ON e.mgr = m.empno 
ORDER BY e.sal DESC;

-- Câu 11: Hiển thị nghề nghiệp được tuyển dụng vào năm 1981 và không được tuyển dụng vào năm 1994
SELECT DISTINCT job 
FROM emp 
WHERE TO_CHAR(hiredate, 'YYYY') = '1981' 
  AND job NOT IN (
      SELECT job 
      FROM emp 
      WHERE TO_CHAR(hiredate, 'YYYY') = '1994'
  );

-- Câu 12: Tìm những nhân viên gia nhập công ty trước giám đốc (người quản lý) của họ
SELECT e.ename AS emp_name, e.hiredate AS emp_hiredate, m.ename AS mgr_name, m.hiredate AS mgr_hiredate 
FROM emp e 
JOIN emp m ON e.mgr = m.empno 
WHERE e.hiredate < m.hiredate;

-- Câu 13: Tìm nhân viên, ngày gia nhập, tên người giám đốc và ngày gia nhập của người giám đốc đó
SELECT e.ename AS emp_name, e.sal AS emp_sal, m.ename AS mgr_name, m.sal AS mgr_sal 
FROM emp e 
JOIN emp m ON e.mgr = m.empno;

-- Câu 14: Tìm những nhân viên/mức lương cao nhất trong mỗi loại nghề nghiệp
SELECT job, MAX(sal) AS "MAX(SAL)" 
FROM emp 
GROUP BY job;

-- Câu 15: Tìm mức lương cao nhất trong mỗi phòng ban, sắp xếp theo thứ tự phòng ban
SELECT e.ename, e.job, e.deptno, e.sal 
FROM emp e 
WHERE (e.deptno, e.sal) IN (
    SELECT deptno, MAX(sal) 
    FROM emp 
    GROUP BY deptno
) 
ORDER BY e.deptno ASC;

-- Câu 16: Tìm nhân viên gia nhập vào từng phòng ban sớm nhất
SELECT e.ename, TO_CHAR(e.hiredate, 'DD-MM-YYYY') AS hiredate, e.deptno, e.sal 
FROM emp e 
WHERE (e.deptno, e.hiredate) IN (
    SELECT deptno, MIN(hiredate) 
    FROM emp 
    GROUP BY deptno
);

-- Câu 17: Hiển thị những nhân viên có mức lương lớn hơn lương trung bình của phòng ban mà họ làm việc
SELECT e.empno, e.ename, e.sal, e.deptno 
FROM emp e 
WHERE e.sal > (
    SELECT AVG(sal) 
    FROM emp 
    WHERE deptno = e.deptno
);

-- Câu 18: Hiển thị thông tin nhân viên, người quản lý, phòng ban và mức lương (grade) của người quản lý
SELECT e.empno AS emp_number, e.ename AS emp_name, e.sal AS emp_sal, 
       m.empno AS mgr_number, m.ename AS mgr_name, m.deptno AS mgr_dept, s.grade AS mgr_grade 
FROM emp e 
JOIN emp m ON e.mgr = m.empno 
JOIN salgrade s ON m.sal BETWEEN s.losal AND s.hisal;

-- Bài tập 6.4
-- CÂU 1: Hiển thị tên nhân viên, ngày gia nhập công ty nằm trong khoảng hai biến
-- runtime được nhập từ bàn phím (&first_date, &last_date).
SELECT ename, hiredate 
FROM emp 
WHERE hiredate BETWEEN TO_DATE('&first_date', 'DD-MM-YYYY') 
                   AND TO_DATE('&last_date', 'DD-MM-YYYY');

-- CÂU 2: Hiển thị tên nhân viên, nghề nghiệp, lương, mã giám đốc, mã phòng ban
-- với điều kiện nghề nghiệp bằng biến nhập từ bàn phím (&job).
SELECT ename, job, sal, mgr, deptno 
FROM emp 
WHERE UPPER(job) = UPPER('&job');

-- CÂU 3: Định nghĩa một biến tính thu nhập một năm của nhân viên. Dùng biến này
-- để tìm những nhân viên có thu nhập lớn hơn hoặc bằng $30000.
-- Định nghĩa biến đại diện cho biểu thức thu nhập 1 năm
DEFINE annual_income = "(sal + NVL(comm, 0)) * 12"

SELECT ename, &annual_income AS annual_sal 
FROM emp 
WHERE &annual_income >= 30000;

-- Hủy định nghĩa biến sau khi thực thi
UNDEFINE annual_income;

-- CÂU 4: Định nghĩa một biến là khoảng thời gian nhân viên làm trong công ty.
-- Hiển thị tên nhân viên và quãng thời gian làm việc theo tên nhập vào (&emp_name).
-- Đưa ra định dạng mẫu: "X YEAR Y MONTHS"
SELECT ename, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate) / 12) || ' YEAR ' || 
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hiredate), 12)) || ' MONTHS' AS "LENGTH OF SERVICE"
FROM emp 
WHERE UPPER(ename) = UPPER('&emp_name');

-- Bài tập 7.7
-- CÂU 1: Tạo bảng PROJECT với các cột, khóa chính PROJID và ràng buộc 
-- CHECK (P_END_DATE > P_START_DATE)
CREATE TABLE project (
    projid        NUMBER(4) CONSTRAINT pk_project PRIMARY KEY,
    p_desc        VARCHAR2(20),
    p_start_date  DATE,
    p_end_date    DATE,
    budget_amount NUMBER(7,2),
    max_no_staff  NUMBER(2),
    CONSTRAINT chk_p_dates CHECK (p_end_date > p_start_date)
);

-- CÂU 2: Tạo bảng ASSIGNMENTS với PROJID là FK tới PROJECT, EMPNO là FK tới EMP
CREATE TABLE assignments (
    projid       NUMBER(4) NOT NULL,
    empno        NUMBER(4) NOT NULL,
    a_start_date DATE,
    a_end_date   DATE,
    bill_amount  NUMBER(4,2),
    assign_type  VARCHAR2(2),
    CONSTRAINT fk_assign_projid FOREIGN KEY (projid) REFERENCES project(projid),
    CONSTRAINT fk_assign_empno  FOREIGN KEY (empno)  REFERENCES emp(empno)
);

-- CÂU 3: Thêm cột COMMENTS kiểu LONG vào bảng PROJECT (hoặc PROJECTS) 
-- và cột HOURS kiểu NUMBER vào bảng ASSIGNMENTS
ALTER TABLE project ADD (comments LONG);

ALTER TABLE assignments ADD (hours NUMBER);

-- CÂU 4: Sử dụng view USER_OBJECTS hiển thị tất cả các đối tượng user sở hữu
SELECT object_name, object_type, created, status 
FROM user_objects;

-- CÂU 5: Thêm ràng buộc duy nhất (UNIQUE) cho tổ hợp 2 cột (PROJID, EMPNO) 
-- trong bảng ASSIGNMENTS
ALTER TABLE assignments 
ADD CONSTRAINT uk_proj_emp UNIQUE (projid, empno);

-- CÂU 6: Xem các thông tin về các ràng buộc trong USER_CONSTRAINTS
SELECT constraint_name, constraint_type, table_name, status 
FROM user_constraints;

-- CÂU 7: Xem trong USER hiện tại có tất cả bao nhiêu bảng (Sử dụng USER_TABLES)
SELECT COUNT(*) AS total_tables 
FROM user_tables;

-- Bài tập 8.3
-- CÂU 1: Thêm dữ liệu vào bảng PROJECT (PROJECTS)
INSERT INTO project (projid, p_desc, p_start_date, p_end_date, budget_amount, max_no_staff)
VALUES (1, 'WRITE C030 COURSE', TO_DATE('02-01-1988', 'DD-MM-YYYY'), TO_DATE('07-01-1988', 'DD-MM-YYYY'), 500, 1);

-- CÂU 2: Thêm dữ liệu vào bảng ASSIGNMENTS
INSERT INTO assignments (projid, empno, a_start_date, a_end_date, bill_amount, assign_type, hours)
VALUES (1, 7369, TO_DATE('01-01-1988', 'DD-MM-YYYY'), TO_DATE('03-01-1988', 'DD-MM-YYYY'), 50.00, 'WR', 15);

-- CÂU 3: Cập nhật trường ASSIGN_TYPE từ 'WT' thành 'WR'
UPDATE assignments 
SET assign_type = 'WR' 
WHERE assign_type = 'WT';

-- CÂU 4: Nhập thêm số liệu vào các bảng PROJECT và ASSIGNMENTS
-- 1. Thêm dự án mới (PROJID = 2) vào bảng PROJECT
INSERT INTO project (projid, p_desc, p_start_date, p_end_date, budget_amount, max_no_staff)
VALUES (2, 'PROOF READ NOTES', TO_DATE('01-01-1989', 'DD-MM-YYYY'), TO_DATE('10-01-1989', 'DD-MM-YYYY'), 600, 1);

-- 2. Thêm phân công công việc mới cho EMPNO = 7902 thuộc PROJID = 1
INSERT INTO assignments (projid, empno, a_start_date, a_end_date, bill_amount, assign_type, hours)
VALUES (1, 7902, TO_DATE('04-01-1988', 'DD-MM-YYYY'), TO_DATE('07-01-1988', 'DD-MM-YYYY'), 55.00, 'WR', 20);

-- 3. Thêm phân công công việc mới cho EMPNO = 7844 thuộc PROJID = 2
INSERT INTO assignments (projid, empno, a_start_date, a_end_date, bill_amount, assign_type, hours)
VALUES (2, 7844, TO_DATE('01-01-1989', 'DD-MM-YYYY'), TO_DATE('10-01-1989', 'DD-MM-YYYY'), 45.50, 'PF', 30);

-- Xác nhận lưu các thay đổi vào cơ sở dữ liệu
COMMIT;

-- Bài tập 9.3
-- CÂU 1: Tạo Index trên cột PROJID cho bảng ASSIGNMENTS (hoặc ASSIGNMENT)
CREATE INDEX idx_assign_projid ON assignments(projid);

-- CÂU 2: Hiển thị danh sách nhân viên thuộc sự quản lý của người có tên 
-- được nhập vào từ bàn phím (&manager_name).
SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
FROM emp e
JOIN emp m ON e.mgr = m.empno
WHERE UPPER(m.ename) = UPPER('&manager_name');

-- Bài tập 10.2
-- Câu 1: Tạo view AGGREDATES hiển thị các giá trị thống kê theo phòng ban
CREATE OR REPLACE VIEW aggredates AS
SELECT 
    deptno, 
    AVG(sal) AS average, 
    MAX(sal) AS maximun, 
    MIN(sal) AS minimun, 
    SUM(sal) AS sum
FROM emp
GROUP BY deptno;

-- Kiểm tra kết quả view
SELECT * FROM aggredates;

-- Câu 2: Tạo view v_assignments_check kiểm soát dữ liệu nhập vào bảng ASSIGNMENTS
CREATE OR REPLACE VIEW v_assignments_check AS
SELECT 
    a.projid, 
    a.empno, 
    a.a_start_date, 
    a.a_end_date, 
    a.bill_amount AS bill_rate, 
    a.assign_type, 
    a.hours
FROM assignments a
JOIN project p ON a.projid = p.projid
WHERE a.projid < 2000
  AND p.p_start_date < p.p_end_date
  AND a.empno IS NOT NULL
  AND a.assign_type IN ('PS', 'WT', 'ED')
  AND (
        (a.assign_type = 'PS' AND a.bill_amount < 50) OR
        (a.assign_type = 'WT' AND a.bill_amount < 60) OR
        (a.assign_type = 'ED' AND a.bill_amount < 70)
      )
WITH CHECK OPTION CONSTRAINT chk_assignment_violation;

-- Câu 3: Định nghĩa bảng MESSAGES
CREATE TABLE messages (
    numcol1  NUMBER(9,2),
    numcol2  NUMBER(9,2),
    charcol1 VARCHAR2(60),
    charcol2 VARCHAR2(60),
    datecol1 DATE,
    datecol2 DATE
);

-- Bài tập 12.5
-- CÂU 1: Viết PL/SQL tìm kiếm các hàng trong bảng EMP với job truyền vào từ ngoài (&1)
-- và đưa thông báo thích hợp vào bảng MESSAGES.
DECLARE
    v_job   emp.job%TYPE := '&1';
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_count FROM emp WHERE UPPER(job) = UPPER(v_job);
    
    INSERT INTO messages (numcol1, charcol1, datecol1)
    VALUES (v_count, 'Tim thay ' || v_count || ' nhan vien co nghe nghiep: ' || UPPER(v_job), SYSDATE);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cau 1: Da ghi nhan ' || v_count || ' ban ghi vao bang MESSAGES.');
END;
/

-- CÂU 2: Ghi dữ liệu vào bảng MESSAGES với NUMCOL1 từ 1 đến 10.
-- Bỏ qua giá trị 6 và 8, thoát vòng lặp sau giá trị 10, sau đó Commit.
BEGIN
    FOR i IN 1..15 LOOP
        IF i > 10 THEN
            EXIT;
        END IF;
        
        IF i = 6 OR i = 8 THEN
            CONTINUE;
        END IF;
        
        INSERT INTO messages (numcol1, charcol2, datecol1)
        VALUES (i, 'Inserted row thu ' || i, SYSDATE);
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cau 2: Da chen du lieu va commit thanh cong.');
END;
/

-- CÂU 3: Liệt kê ENAME, HIREDATE, SAL theo &EMPLOYEE_NO, sau đó kiểm tra điều kiện
-- và ghi kết quả vào bảng messages cột charcol1.
DECLARE
    v_ename    emp.ename%TYPE;
    v_hiredate emp.hiredate%TYPE;
    v_sal      emp.sal%TYPE;
    v_msg      VARCHAR2(200);
BEGIN
    SELECT ename, hiredate, sal 
    INTO v_ename, v_hiredate, v_sal 
    FROM emp 
    WHERE empno = &EMPLOYEE_NO;
    
    v_msg := 'NV: ' || v_ename;
    IF v_sal > 1200 THEN
        v_msg := v_msg || ' - Luong > 1200';
    END IF;
    
    IF INSTR(UPPER(v_ename), 'T') > 0 THEN
        v_msg := v_msg || ' - Ten co chu T';
    END IF;
    
    IF TO_CHAR(v_hiredate, 'MM') = '10' OR UPPER(TO_CHAR(v_hiredate, 'MON')) = 'DEC' THEN
        v_msg := v_msg || ' - Gia nhap dung thang yeu cau';
    END IF;
    
    INSERT INTO messages (numcol1, charcol1, datecol1)
    VALUES (&EMPLOYEE_NO, v_msg, v_hiredate);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cau 3: ' || v_msg);
END;
/

-- CÂU 4: Vòng lặp v từ 1 đến 10 thực hiện UPDATE messages SET numcol2=100 WHERE numcol1 = v;
-- Nếu bất kỳ lần update nào có số lượng row > 1 thì exit khỏi vòng lặp.
DECLARE
    v_row_updated NUMBER;
BEGIN
    FOR v IN 1..10 LOOP
        UPDATE messages 
        SET numcol2 = 100 
        WHERE numcol1 = v;
        
        v_row_updated := SQL%ROWCOUNT;
        
        IF v_row_updated > 1 THEN
            EXIT;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cau 4: Da hoan tat cap nhat va kiem tra dieu kien rowcount.');
END;
/

--