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

mid = hgroup("MID", ((_+_)/2)*(gain(vslider("[1] [unit:dB]", 0, -96, 6, 0.1))): parametric_eq_demo : vmeter);
side = hgroup("SIDE",((_-_)/2)*(gain(vslider("[2] [unit:dB]", 0, -96, 6, 0.1))): parametric_eq_demo : vmeter);

process(L,R) = (L,R)<:hgroup("S.T.ONE",(
  ((mid + side) : vmeter),
  ((mid - side) : vmeter),
  (side : vmeter),
  (side : neg : vmeter)
  ));
