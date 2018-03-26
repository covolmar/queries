SELECT * FROM Signal S
INNER JOIN Variable V
ON S.Id = V.SignalId
order by SignalId

SELECT * FROM Signal
WHERE Id = 592

SELECT * FROM Variable

SELECT * FROM SignalFullName

USE Tagesthal213

SELECT S.Id, MAX(AO0), MAX(AO1), MAX(AO2), MAX(AO3), MAX(S.Name), MAX(BEREICH), MAX(BAUWERK), MAX(FUNKTION), MAX(ELEMENT), MAX(S.IndexText), MAX(ST.Name)
FROM Signal S
INNER JOIN(
	SELECT KKS0.Name AS AO0, KKS0.Bezeichnung AS BEREICH,
	KKS1.Name AS AO1, KKS1.Bezeichnung AS BAUWERK,
	KKS2.Name AS AO2, KKS2.Bezeichnung AS FUNKTION,
	KKS3.Name AS AO3, KKS3.Bezeichnung AS ELEMENT,
	KKS3.Id AS KKS3_ID
	FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
	WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
	AND KKS1.Id = KKS2.ParentAnlagenObjektId
	AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId
INNER JOIN SignalTyp ST
ON ST.Id = S.TypId
LEFT OUTER JOIN Variable V
ON V.SignalId = S.Id
GROUP BY S.Id
ORDER BY S.Id








SELECT S.Id, AO0, AO1, AO2, AO3, S.Name AS SO, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS INDEX_TEXT, ST.Name AS Typ
FROM Signal S
INNER JOIN(
	SELECT KKS0.Name AS AO0, KKS0.Bezeichnung AS BEREICH,
	KKS1.Name AS AO1, KKS1.Bezeichnung AS BAUWERK,
	KKS2.Name AS AO2, KKS2.Bezeichnung AS FUNKTION,
	KKS3.Name AS AO3, KKS3.Bezeichnung AS ELEMENT,
	KKS3.Id AS KKS3_ID
	FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
	WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
	AND KKS1.Id = KKS2.ParentAnlagenObjektId
	AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId
INNER JOIN SignalTyp ST
ON ST.Id = S.TypId
JOIN Variable V
ON V.SignalId = S.Id
order by S.Id




