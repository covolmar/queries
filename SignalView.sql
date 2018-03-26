SELECT AO0 AS riflex_plant_object_name, 
AO1 AS riflex_plant_object_name_1,
AO2 AS riflex_plant_object_name_2,
AO3 AS riflex_plant_object_name_3,
S.Name AS riflex_signal_name,
BEREICH AS riflex_plant_object_description,
BAUWERK AS riflex_plant_object_description_1,
FUNKTION AS riflex_plant_object_description_2,
ELEMENT AS riflex_plant_object_description_3,
S.IndexText AS riflex_signal_description,
ST.Name AS riflex_signal_type,
(
	SELECT COUNT(*) 
	FROM Variable V
	WHERE V.SignalId = S.Id
) AS riflex_signal_variable_count,
S.Id AS SignalId
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
