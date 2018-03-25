//-------------------------------------------------
// STONE
//-------------------------------------------------

declare name "STONE";
declare version "0.1";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Spherical Technologies set of filters for STONE loudspeaker";

import("stdfaust.lib");
import("filters.lib");
import("analyzers.lib");

vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -70, 10));
envelop			= abs : max(ba.db2linear(-70)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);

STONE = hgroup("S.T.ONE",
hgroup("LFU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RFD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("LBD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RBU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ));

//process = STONE :> analyzer(3,(35,75,125,250,500,1000,2000,4000,8000,16000,32000));
process = STONE ;
