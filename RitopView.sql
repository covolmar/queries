CREATE VIEW RitopView AS
SELECT S.KonfigurationId AS Konfiguration, V.StationId AS StationId,
CASE 
	WHEN Var.HatQuMMI = 1 THEN 'Q'
	WHEN Var.HatSeMMI = 1 THEN 'S'
	ELSE '' 
END AS Ritop_Q_S, 
V.Id AS VariablenId, V.SignalId AS SignalId
FROM VarQuSe Var
INNER JOIN Variable V
ON Var.VariableId = V.Id
LEFT OUTER JOIN Station S
ON Var.StaNr = S.Id