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

gain(x) = x : db2linear : smooth(0.999);

mid = ((_+_)/2)*(gain(vslider("[1] mid [unit:dB]", 0, -70, 0, 0.1)));
side = ((_-_)/2)*(gain(vslider("[2] side [unit:dB]", 0, -70, 0, 0.1)));

process(L,R) = (L,R)<:hgroup("S.T.ONE",(
  (mid + side),
  (mid - side),
  (side),
  (-side)
  ));
