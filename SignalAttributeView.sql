SELECT Wert AS riflex_signal_default_value,
CASE WHEN HatZeit = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_time,
CASE WHEN HatBackup = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_backup,
CASE WHEN HatPrivileg = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_priority,
CASE WHEN HatImpulsBefehl = 1 THEN 'x' ELSE NULL END AS riflex_signal_flag_impuls,
CASE WHEN HatRedundanz = 1 THEN NULL ELSE 'x' END AS riflex_signal_flag_not_redundant,
Id AS SignalId, DavosVerdichtung AS riflex_signal_davos_compression, DavosIntervall AS riflex_signal_davos_interval,
DavosElemente AS riflex_signal_davos_elements
FROM Signal