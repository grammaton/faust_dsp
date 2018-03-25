declare name 		"vumeter";
declare version 		"1.0";
declare author 		"Grame";
declare license 		"BSD";
declare copyright 	"(c)GRAME 2006";

//-------------------------------------------------
// Simple vumeter
//-------------------------------------------------

import("math.lib");
import("music.lib");

//envelop			= abs : max(ba.db2linear(-96)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);
// The M (momentary) response is the mean squared level averaged over a rectangular window of 400 ms.
// An R-128 compliant meter should also be able to store and show the max- imum of this measurement until reset by the user.
// The S (short term) response is the mean squared level averaged over a rectangular window of 3 seconds.
// R-128 requires this to be up- dated at least ten times per second.
// No such value is specified for the M response, but it seems reasonable to assume that at least the same update rate would be required.
// The I (integrated) response is an average over an extended period defined by the user using Start, Stop and Reset commands.
// It is detailed in the following section.


vmeter(x)		= attach(x, envelop(x) : vbargraph("[2][unit:dB]", -70, +5));
hmeter(x)		= attach(x, envelop(x) : hbargraph("[2][unit:dB]", -70, +5));

envelop			= abs : max ~ -(1.0/SR) : max(db2linear(-70)): linear2db;

//process 		= vgroup("vu meter", vmeter);
process 		= vmeter;
