// --------------------------- First Order B-Format Ambisonic Encoder
// ------------------------------------------- made by Giuseppe Silvi

declare name "BFEI";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "First Order B-Format Ambisonic Encoder";

import("effect.lib");
import("stdfaust.lib");

envelop			= abs : max(ba.db2linear(-96)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);

vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -96, 0));

azi = (si.smoo(vslider("[1] [unit:dB]", 0, 0, 359, 0.1))) * ma.PI / 180;
elv = (si.smoo(vslider("[1] [unit:dB]", 0, 0, 359, 0.1))) * ma.PI / 180;

W = _ * 0.707;
X = _ * cos(azi) * cos(elv);
Y = _ * sin(azi) * cos(elv);
Z = _ * sin(elv);

process = _ <: W, X, Y, Z;
