-- 7번
SELECT EMP_ID, EMP_NAME, JOB_NAME, ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))) 나이, 
TO_CHAR(NVL(SALARY * (12 + (BONUS * 12)), SALARY * 12), 'L999,999,999') 보너스포함연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE (JOB_CODE, ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))))
IN (SELECT JOB_CODE, MIN(ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))))
FROM EMPLOYEE GROUP BY JOB_CODE)
ORDER BY 나이 DESC;


-- 6번
SELECT EMP_ID 사번, EMP_NAME 이름, NVL(DEPT_TITLE, '소속없음') 부서명, 
JOB_NAME 직급명, TO_CHAR(HIRE_DATE, 'YY/MM/DD') 입사일
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE) 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE ENT_YN = 'N'
GROUP BY DEPT_TITLE)
ORDER BY HIRE_DATE;


-- 5번
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 2) = '77'
AND SUBSTR(EMP_NO, 8, 1) = '2')


-- 4번
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
FROM EMPLOYEE WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2000);


-- 3번 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE 
FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND EMP_NAME <> '노옹철';


-- 2번
SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (
				SELECT MAX(SALARY)
				FROM EMPLOYEE
				WHERE HIRE_DATE >= (SELECT HIRE_DATE FROM EMPLOYEE
									WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2000));

-- 1번							
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE								
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
AND EMP_NAME <> '전지연';						
										
