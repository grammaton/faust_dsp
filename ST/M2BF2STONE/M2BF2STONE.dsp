// --------------------------- First Order B-Format Ambisonic Encoder
// ------------------------------------------- made by Giuseppe Silvi

declare name "m2BF2STONE";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Mono to First Order B-Format Ambisonic Encoder to S.T.ONE";

import("effect.lib");
import("stdfaust.lib");

envelop			= abs : max(ba.db2linear(-96)) : ba.linear2db : min(10)  : max ~ -(80.0/ma.SR);
vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -96, 0));

azi = (si.smoo(vslider("[1] [unit:deg]", 0, 0, 359, 0.1))) * ma.PI / 180;
elv = (si.smoo(vslider("[2] [unit:deg]", 0, 0, 359, 0.1))) * ma.PI / 180;

W = _ * 0.707;
X = _ * cos(azi) * cos(elv);
Y = _ * sin(azi) * cos(elv);
Z = _ * sin(elv);

INPUTS = _, !, !, !;

ENCODER =  _ <: _ * 0.707, _ * cos(azi) * cos(elv), _ * sin(azi) * cos(elv), _ * sin(elv);

BAMODULE(W, X, Y, Z) = (0.5 * ( W + X + Y + Z)),	(0.5 * ((W + X) - (Y - Z))), (0.5 * ((W - X) - (Y - Z))),	(0.5 * ((W - X) - (Y + Z)));

STONE = hgroup("S.T.ONE",
hgroup("LFU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RFD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("LBD", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ),
hgroup("RBU", _ : * (0.15) : highpass(2,160) : highshelf(1,12,2500) : peak_eq(-6,1500,1000) : lowshelf(1,-3,2500) : vmeter ));

process = INPUTS : ENCODER : BAMODULE : STONE;
