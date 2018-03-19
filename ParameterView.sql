CREATE VIEW ParameterView AS
SELECT S.KonfigurationId AS Konfiguration, Q.StaNr AS Station, Q.ParaNr AS ParaBlockNr, 
Q.ParaMin AS ParaMin, Q.ParaMax AS ParaMax, Q.ParaNKS AS Nachkommastellen, Q.VariableId AS VariablenId, V.SignalId AS SignalId
FROM VarQuSe Q
INNER JOIN Station S
ON S.Id = Q.StaNr
INNER JOIN Variable V
ON V.Id = Q.VariableId