//-------------------------------------------------
// ZOOM H2N + Z to First Order B-Format
//-------------------------------------------------

declare name "h2nZproc";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2017";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "zoom h2n + Z to First Order B-Format";

import("effect.lib");
import("stdfaust.lib");

envelop			= abs : max(ba.db2linear(-96)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);
vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -70, 10));
hmeter(x)		= attach(x, envelop(x) : hbargraph("[unit:dB]", -70, 10));

gain(x) = x : db2linear : smooth(0.999);

fmid = hgroup("Front MID",((_+_)/2)*(gain(vslider("[1] fM [unit:dB]", 0, -70, 0, 0.1))):vmeter);
side = hgroup("SIDE",((_-_)/2)*(gain(vslider("[2] S [unit:dB]", 0, -70, 0, 0.1))):vmeter);
rmid = hgroup("Rear MID",((_+_)/2)*(gain(vslider("[3] rM [unit:dB]", 0, -70, 0, 0.1))):vmeter);

W = hgroup("W",((_+_)/2):hmeter);
X = hgroup("X",((_-_)/2):hmeter);
Y = hgroup("Y",_:hmeter);

process(L,R,Ls,Rs,Z) = hgroup("Double M/S",((L,R)<:(fmid, side),((Ls,Rs):rmid)))<:_,!,_,_,!,_,!,_,!:W,X,Y,hgroup("Z",Z:hmeter);
