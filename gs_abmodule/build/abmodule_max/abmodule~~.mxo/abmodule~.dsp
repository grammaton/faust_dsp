//-------------------------------------------------
// AB MODULE WITHOUT SHELVING
//-------------------------------------------------

process(LFU, RFD, RBU, LBD) =
	(0.5 * (LFU + RFD + RBU + LBD)),
	(0.5 * (LFU + RFD - RBU - LBD)),
	(0.5 * (LFU - RFD - RBU + LBD)),
	(0.5 * (LFU - RFD + RBU - LBD));