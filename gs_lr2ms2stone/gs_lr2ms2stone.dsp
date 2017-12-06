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

vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -70, 10));
hmeter(x)		= attach(x, envelop(x) : hbargraph("[unit:dB]", -70, 10));

envelop			= abs : max(ba.db2linear(-70)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);

gain(x) = x : db2linear : smooth(0.999);

mid = hgroup("MID", ((_+_)/2)*(gain(vslider("[1] [unit:dB]", 0, -70, 0, 0.1))): vmeter);
side = hgroup("SIDE",((_-_)/2)*(gain(vslider("[2] [unit:dB]", 0, -70, 0, 0.1))): vmeter);

process(L,R) = (L,R)<:hgroup("S.T.ONE",(
  ((mid + side): vmeter),
  ((mid - side): vmeter),
  ((side): vmeter),
  ((-side): vmeter)
  ));
