USE [C:\TEMP\MARCO.COVOLAN\WINKPWORK\COM_2_12_PID_16456\DB\WINKP.MDF]


SELECT KKS0, KKS1, KKS2, KKS3, S.Name AS KKS4, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS SIGNAL_INDEX, S.Id AS SIGNAL_ID
FROM Signal S
INNER JOIN(
	SELECT KKS0.Name AS KKS0, KKS0.Bezeichnung AS BEREICH, 
	KKS1.Name AS KKS1, KKS1.Bezeichnung AS BAUWERK,
	KKS2.Name AS KKS2, KKS2.Bezeichnung AS FUNKTION,
	KKS3.Name AS KKS3, KKS3.Bezeichnung AS ELEMENT,
	KKS3.Id AS KKS3_ID -- JOIN REFERENCE WITH SIGNAL TABLE!!!
	FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
	WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
	AND KKS1.Id = KKS2.ParentAnlagenObjektId
	AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId


SELECT DISTINCT First.MFEText AS MFETEXT_0, Second.MFEText AS MFETEXT_1, Third.MFEText AS MFETEXT_2, First.SignalId AS SIGNAL_ID
FROM MFEText First, MFEText Second, MFEText Third
WHERE First.Nummer = 0
AND Second.Nummer = 1
AND Third.Nummer = 2
ORDER BY SIGNAL_ID


SELECT R.MFEText, F.MFEText, R.SignalId
FROM MFEText R, MFEText F
WHERE R.Nummer = 0 AND F.Nummer = 1 AND R.SignalId = F.SignalId

SELECT R.MFEText, F.MFEText, R.SignalId
FROM MFEText R, MFEText F
WHERE R.Nummer BETWEEN 0 AND 3
AND R.SignalId = F.SignalId


-- Signal Name View---------------------------------------------------------------------------------------

SELECT KKS0, KKS1, KKS2, KKS3, S.Name AS KKS4, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS SIGNAL_INDEX, S.Id AS SIGNAL_ID
FROM Signal S
INNER JOIN(
	SELECT KKS0.Name AS KKS0, KKS0.Bezeichnung AS BEREICH, 
	KKS1.Name AS KKS1, KKS1.Bezeichnung AS BAUWERK,
	KKS2.Name AS KKS2, KKS2.Bezeichnung AS FUNKTION,
	KKS3.Name AS KKS3, KKS3.Bezeichnung AS ELEMENT,
	KKS3.Id AS KKS3_ID -- JOIN REFERENCE WITH SIGNAL TABLE!!!
	FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
	WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
	AND KKS1.Id = KKS2.ParentAnlagenObjektId
	AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId

-- Signal Name View---------------------------------------------------------------------------------------


---------------------------------- MFE-VIEW--------------------------------------------------

SELECT MFE0.MFEText_0, MFE1.MFEText_1, MFE2.MFEText_2, MFE0.Signal_Id
FROM 
(
	SELECT MFEText AS MFEText_0, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 0
) MFE0
	LEFT OUTER JOIN
	(
		SELECT MFEText AS MFEText_1, SignalId AS Signal_Id 
		FROM MFEText
		WHERE Nummer = 1
	) MFE1
		ON MFE0.Signal_Id = MFE1.Signal_Id
		LEFT OUTER JOIN 
		(
			SELECT MFEText AS MFEText_2, SignalId AS Signal_Id 
			FROM MFEText
			WHERE Nummer = 2
		) MFE2
			ON MFE1.Signal_Id = MFE2.Signal_Id

----------------------------------------------------------------------------------------------------------



SELECT KKS0, KKS1, KKS2, KKS3, KKS4, BEREICH, BAUWERK, FUNKTION, ELEMENT, SIGNAL_INDEX,
MFEText_0, MFEText_1, MFEText_2
FROM SignalNameMitBezeichnungen B
INNER JOIN SignalMFETextView T ON T.Signal_Id = B.SIGNAL_ID 



--MONSTER

SELECT * FROM HWModul


SELECT MFEText, SignalId
FROM MFEText
WHERE Nummer BETWEEN 0 AND 3

SELECT * FROM MFEText

SELECT * FROM AnlagenObjekt

SELECT * FROM Signal


--SELECT KKS3.Id, KKS3.Name AS KKS3, SO.Name
--FROM AnlagenObjekt KKS3
--INNER JOIN Signal SO on SO.AnlagenObjektId = KKS3.Id



