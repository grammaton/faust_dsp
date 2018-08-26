//-----------------------------------------------------------
// LR STEREO to B-Fortmat 1st Order
//-----------------------------------------------------------

declare name "LR2B1";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2017";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "LR STEREO to B-Fortmat 1st Order";

import("stdfaust.lib");

azi = (si.smoo(vslider("[1] [unit:deg]", 0.0, 0.0, 359.9, 0.1))) * ma.PI / 180;
elv = (si.smoo(vslider("[2] [unit:deg]", 0.0, 0.0, 359.9, 0.1))) * ma.PI / 180;

  W1(W) = W;
X1(X,Y) = (X) * cos(azi) - Y * sin(azi);
Y1(X,Y) = (Y) * cos(azi) - X * sin(azi);
  Z1(Z) = Z;


process(W,X,Y,Z) = W1(W), X1(X,Y), Y1(X,Y), Z1(Z);
