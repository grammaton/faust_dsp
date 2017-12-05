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

import("filters.lib");

process(LFU, RFD, RBU, LBD) =
	((0.5 * (LFU + RFD + RBU + LBD)): highshelf(1,4,2500)),
	((0.5 * (LFU + RFD - RBU - LBD)): highshelf(1,4,2500)),
	((0.5 * (LFU - RFD - RBU + LBD)): highshelf(1,4,2500)),
	((0.5 * (LFU - RFD + RBU - LBD)): highshelf(1,4,2500));

	//-------------`(fi.)high_shelf`--------------
	// First-order "high shelf" filter (gain boost|cut above some frequency).
	// `high_shelf` is a standard Faust function.
	//
	// #### Usage
	//
	// ```
	// _ : highshelf(N,Lpi,fx) : _
	// _ : high_shelf(L0,fx) : _ // default case (order 3)
	// _ : highshelf_other_freq(N,Lpi,fx) : _
	// ```
	//
	// Where:
	//
	// * `N`: filter order 1, 3, 5, ... (odd only).
	// * `Lpi`: desired level (dB) between fx and SR/2 (boost Lpi>0 or cut Lpi<0)
	// * `fx`: -3dB frequency of highpass band (L0>0) or lower band (L0<0)
	//        (Use highshelf_other_freq() below to find the other one.)
	//
	// The gain at dc is constrained to be 1.
	// See `lowshelf` documentation above for more details on shelf shape.
	//--------------------------------------------------------------
