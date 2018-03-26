SELECT MFE0.MFEText_0 AS riflex_signal_mfe,
MFE1.MFEText_1 AS riflex_signal_mfe_1,
MFE2.MFEText_2 AS riflex_signal_mfe_2,
MFE3.MFEText_3 AS riflex_signal_mfe_3,
MFE4.MFEText_4 AS riflex_signal_mfe_4,
MFE5.MFEText_5 AS riflex_signal_mfe_5,
MFE6.MFEText_6 AS riflex_signal_mfe_6,
MFE7.MFEText_7 AS riflex_signal_mfe_7,
(SELECT KommentarText FROM Signal WHERE Id = MFE0.Signal_Id) AS riflex_signal_comment,
MFE0.Signal_Id AS SignalId
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