//-------------------------------------------------
// AB MODULE WITHOUT SHELVING
//-------------------------------------------------

process(LF, RF, LB, RB) =
	(0.5 * (LF + RF + LB + RB)),
	(0.5 * (LF + RF - LB - RB)),
	(0.5 * (LF - RF + LB - RB)),
	(0.5 * (LF - RF - LB + RB));