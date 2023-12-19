-- Exercise 1: Using Joins - Question 1
-- Write and execute a SQL query to list
-- the school names, community names and average attendance
-- for communities with a hardship index of 98.
SELECT NAME_OF_SCHOOL, cps.COMMUNITY_AREA_NAME, AVERAGE_STUDENT_ATTENDANCE
FROM chicago_public_schools cps
LEFT JOIN chicago_socioeconomic_data csd ON cps.COMMUNITY_AREA_NUMBER = csd.COMMUNITY_AREA_NUMBER
WHERE HARDSHIP_INDEX = 98
;


-- Exercise 1: Using Joins - Question 2
-- Write and execute a SQL query to list all crimes that took place at a school.
-- Include case number, crime type and community name.
SELECT CASE_NUMBER, PRIMARY_TYPE, COMMUNITY_AREA_NAME, LOCATION_DESCRIPTION
FROM chicago_crime cc
LEFT JOIN chicago_socioeconomic_data csd ON cc.COMMUNITY_AREA_NUMBER = csd.COMMUNITY_AREA_NUMBER
WHERE LOCATION_DESCRIPTION LIKE '%school%'
;



-- Exercise 2: Creating a View - Question 1
-- Write and execute a SQL statement to create a view showing
-- the columns listed in the following table, with new column names
-- as shown in the second column.
-- 
-- Column name in CHICAGO_PUBLIC_SCHOOLS    |   Column name in view
-- -----------------------------------------+-----------------------
-- NAME_OF_SCHOOL                           |   School_Name
-- Safety_Icon                              |   Safety_Rating
-- Family_Involvement_Icon                  |   Family_Rating
-- Environment_Icon                         |   Environment_Rating
-- Instruction_Icon                         |   Instruction_Rating
-- Leaders_Icon                             |   Leaders_Rating
-- Teachers_Icon                            |   Teachers_Rating
-- 
CREATE OR REPLACE VIEW Chicago_Public_School_View AS
SELECT
    NAME_OF_SCHOOL AS School_Name,
    Safety_Icon AS Safety_Rating,
    Family_Involvement_Icon AS Family_Rating,
    Environment_Icon AS Environment_Rating,
    Instruction_Icon AS Instruction_Rating,
    Leaders_Icon AS Leaders_Rating,
    Teachers_Icon AS Teachers_Rating
FROM chicago_public_schools cps
;

-- Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM Chicago_Public_School_View;

-- Write and execute a SQL statement that returns
-- just the school name and leaders rating from the view.
SELECT School_Name, Leaders_Rating
FROM Chicago_Public_School_View;


-- Exercise 3: Creating a Stored Procedure - Question 1
-- Write the structure of a query to create or replace a
-- stored procedure called UPDATE_LEADERS_SCORE that takes
-- a in_School_ID parameter as an integer and
-- a in_Leader_Score parameter as an integer.
DELIMITER //
CREATE OR REPLACE
PROCEDURE update_leaders_score (IN in_School_ID INT, IN in_Leader_Score INT)
BEGIN
    UPDATE chicago_public_schools
    SET Leaders_Score = in_Leader_Score
    WHERE School_ID = in_Leader_Score;
END //
DELIMITER ;


















