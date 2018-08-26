// --------------------------- First Order B-Format Ambisonic Encoder
// ------------------------------------------- made by Giuseppe Silvi

declare name "M2B1";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "First Order B-Format Ambisonic Encoder";

import("stdfaust.lib");

azi = (si.smoo(vslider("[1] [unit:deg]", 0.0, 0.0, 359.9, 0.1))) * ma.PI / 180;
elv = (si.smoo(vslider("[2] [unit:deg]", 0.0, 0.0, 359.9, 0.1))) * ma.PI / 180;

W(sig) = (sig) * 0.707;
X(sig) = (sig) * cos(azi) * cos(elv);
Y(sig) = (sig) * sin(azi) * cos(elv);
Z(sig) = (sig) * sin(elv);

process(sig,s2,s3,s4) = W(sig), X(sig), Y(sig), Z(sig);
