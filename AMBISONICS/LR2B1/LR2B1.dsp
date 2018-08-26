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

   azi = (30.0 * (ma.PI / 180.0));
   elv = (00.0 * (ma.PI / 180.0));

WL(L) = (L) * 0.707;
XL(L) = (L) * cos(azi) * cos(elv);
YL(L) = (L) * sin(azi) * cos(elv);
ZL(L) = (L) * sin(elv);

WR(R) = (R) * 0.707;
XR(R) = (R) * cos(-azi) * cos(elv);
YR(R) = (R) * sin(-azi) * cos(elv);
ZR(R) = (R) * sin(elv);

process(L,R,s3,s4) = .707 * (WL(L) + WR(R)), .707 * (XL(L) + XR(R)), .707 * (YL(L) + YR(R)), .707 * (ZL(L) + ZR(R));
