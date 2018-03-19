CREATE VIEW SignalMitBezeichnung AS
SELECT AO0, AO1, AO2, AO3, S.Name AS SO, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS INDEX_TEXT
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