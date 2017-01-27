//-------------------------------------------------
// AB MODULE WITHOUT SHELVING
//-------------------------------------------------

declare name "abModule";
declare version "1.0";
declare author "Giuseppe Silvi";
declare license "BSD";
declare copyright "(c)Giuseppe Silvi 2017";

process(LFU, RFD, RBU, LBD) =
	(0.5 * (LFU + RFD + RBU + LBD)),
	(0.5 * (LFU + RFD - RBU - LBD)),
	(0.5 * (LFU - RFD - RBU + LBD)),
	(0.5 * (LFU - RFD + RBU - LBD));
