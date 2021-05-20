
-- Number and Probability of Strokes by Age
 SELECT (CASE WHEN age between 0 and 17 THEN 'Young' WHEN age between 18 and 59 THEN 'Adult' ELSE 'Senior' END) AS age, SUM(stroke) AS Total_Strokes, COUNT(age) AS Total_People, ROUND(SUM(stroke)*100/COUNT(age),2) AS PercentChance_of_Stroke
 FROM Project..strokedata_health
 GROUP BY (CASE WHEN age between 0 and 17 THEN 'Young' WHEN age between 18 and 59 THEN 'Adult' ELSE 'Senior' END) 
 ORDER BY SUM(stroke) ASC

 -- Number and Probability of Strokes by Smoking Habits Between Different Genders
 SELECT gender, smoking_status, SUM(stroke) AS Total_Strokes_Smoked, COUNT(gender) AS Total_People, ROUND(SUM(stroke)*100/COUNT(gender),2) AS Percent_Chance_Stroke
 FROM Project..strokedata_health
 WHERE smoking_status LIKE '%smoked%' OR smoking_status LIKE '%smokes%' OR smoking_status LIKE '%never%'
 GROUP BY gender, smoking_status
 ORDER BY smoking_status
 

 -- Number and Probability of Strokes by Marriage Status Between Genders
 SELECT gender, ever_married, SUM(stroke) AS Total_Strokes_Married, COUNT(gender) AS Total_People, ROUND(SUM(stroke)*100/COUNT(gender),2) AS Percent_Chance_Stroke
 FROM Project..strokedata_personal 
 GROUP BY gender, ever_married
 ORDER BY ever_married

 -- Relationship between marriage, bmi (body mass index), and stroke
 SELECT x.ever_married, (CASE WHEN y.bmi between 0 and 18.4 THEN 'Underweight' WHEN y.bmi between 18.5 and 24.9 THEN 'Normal' 
 WHEN y.bmi between 25.0 and 29.9 THEN 'Overweight' WHEN y.bmi>29.9 THEN 'Obese' ELSE NULL END) AS bmi,
 SUM(x.stroke) AS Total_Strokes, COUNT(x.gender) AS Total_People, ROUND(SUM(x.stroke)*100/COUNT(x.gender),2) AS Percent_Chance_Stroke
 
 FROM Project..strokedata_personal x JOIN Project..strokedata_health y ON x.id=y.id

 WHERE y.bmi IS NOT NULL

 GROUP BY x.ever_married, (CASE WHEN y.bmi between 0 and 18.4 THEN 'Underweight' WHEN y.bmi between 18.5 and 24.9 THEN 'Normal' 
 WHEN y.bmi between 25.0 and 29.9 THEN 'Overweight' WHEN y.bmi>29.9 THEN 'Obese' ELSE NULL END)

 ORDER BY ROUND(SUM(x.stroke)*100/COUNT(x.gender),2)
 
