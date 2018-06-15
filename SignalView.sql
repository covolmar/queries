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
Wert AS riflex_signal_default_value,

MFE0.MFEText_0 AS riflex_signal_mfe,
MFE1.MFEText_1 AS riflex_signal_mfe_1,
MFE2.MFEText_2 AS riflex_signal_mfe_2,
MFE3.MFEText_3 AS riflex_signal_mfe_3,
MFE4.MFEText_4 AS riflex_signal_mfe_4,
MFE5.MFEText_5 AS riflex_signal_mfe_5,
MFE6.MFEText_6 AS riflex_signal_mfe_6,
MFE7.MFEText_7 AS riflex_signal_mfe_7,
S.KommentarText,

CASE WHEN HatZeit = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_time,
CASE WHEN HatBackup = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_backup,
CASE WHEN HatPrivileg = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_priority,
CASE WHEN HatImpulsBefehl = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_impuls,
CASE WHEN HatRedundanz = 1 THEN NULL ELSE 'x' END AS riflex_signal_flag_not_redundant,
DavosVerdichtung AS riflex_signal_davos_compression, DavosIntervall AS riflex_signal_davos_interval,
DavosElemente AS riflex_signal_davos_elements, S.Id AS SignalId
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
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_0, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 0
) MFE0
ON MFE0.Signal_Id = S.Id
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
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_3, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 3
) MFE3
ON MFE2.Signal_Id = MFE3.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_4, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 4
) MFE4
ON MFE3.Signal_Id = MFE4.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_5, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 5
) MFE5
ON MFE4.Signal_Id = MFE5.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_6, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 6
) MFE6
ON MFE5.Signal_Id = MFE6.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_7, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 7
) MFE7
ON MFE6.Signal_Id = MFE7.Signal_Id