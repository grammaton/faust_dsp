//-------------------------------------------------
// AB MODULE WITH SHELVING
//-------------------------------------------------

declare name "abModule";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2017";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Gerzon's A-Format to B-Format matrix";

import("filters.lib");

vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -70, 10));
hmeter(x)		= attach(x, envelop(x) : hbargraph("[unit:dB]", -70, 10));

process(LFU, RFD, RBU, LBD) =
	hgroup("B-Format",
	hgroup("W", ((0.5 * (LFU + RFD + RBU + LBD)): highshelf(1,4,2500): vmeter)),
	hgroup("X", ((0.5 * (LFU + RFD - RBU - LBD)): highshelf(1,4,2500): vmeter)),
	hgroup("Y", ((0.5 * (LFU - RFD - RBU + LBD)): highshelf(1,4,2500): vmeter)),
	hgroup("Z", ((0.5 * (LFU - RFD + RBU - LBD)): highshelf(1,4,2500): vmeter)));
