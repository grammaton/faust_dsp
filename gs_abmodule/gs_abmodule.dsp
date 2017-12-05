//-------------------------------------------------
// AB MODULE WITHOUT SHELVING
//-------------------------------------------------

declare name "abModule";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2017";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Gerzon's A-Format to B-Format matrix";

process(LFU, RFD, RBU, LBD) =
	(0.5 * (LFU + RFD + RBU + LBD)),
	(0.5 * (LFU + RFD - RBU - LBD)),
	(0.5 * (LFU - RFD - RBU + LBD)),
	(0.5 * (LFU - RFD + RBU - LBD));
