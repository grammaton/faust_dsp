//-----------------------------------------------------------
// 2 tracks LR to S.T.ONE a-format through MS image control -
//-----------------------------------------------------------

declare name "lr2ms2stone";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2017";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "2 tracks LR to S.T.ONE a-format through MS image control";

import("effect.lib");
import("stdfaust.lib");

envelop			= abs : max(ba.db2linear(-96)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);

vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -96, 0));
hmeter(x)		= attach(x, envelop(x) : hbargraph("[unit:dB]", -96, 0));

gain(x) = x : db2linear : si.smoo;

mid = hgroup("MID", ((_+_)/2));
side = hgroup("SIDE",((_-_)/2));

STONE = hgroup("S.T.ONE",
hgroup("LFU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RFD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("LBD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RBU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ));

MS2STONE = (_,_)<: (mid + side), (mid - side), side, (side : neg ) : STONE;

process = MS2STONE;
