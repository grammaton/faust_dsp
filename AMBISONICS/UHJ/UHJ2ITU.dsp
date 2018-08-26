//-------------------------------------------------
// UHJ LR STEREO TO ITU 5.0 DECODER
//-------------------------------------------------

declare name "UHJ2ITU";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Gerzon's UHJ to ITU 5.0 DECODER";

import("stdfaust.lib");

biquad(a1,a2,b0,b1,b2) = + ~ conv2(a1,a2) : conv3(b0,b1,b2)
  with{
    conv3(k0,k1,k2,x) = k0*x + k1*x'+ k2*x'';
    conv2(k0,k1,x) = k0*x + k1*x';
  };

hilbertf1 = biquad(-0.02569, 0.260502, -0.260502, 0.02569, 1) :
            biquad(1.8685, -0.870686, 0.870686, -1.8685, 1) ;
hilbertf2 = biquad(1.94632, -0.94657, 0.94657, -1.94632, 1) :
            biquad(0.83774, -0.06338, 0.06338, -0.83774, 1) ;

mid(L,R) = 0.5 * (L + R);
sid(L,R) = 0.5 * (L - R);

W1(L,R) = 0.982 * (sid(L,R)) + hilbertf2(0.164 * (mid(L,R)));
X1(L,R) = 0.419 * (sid(L,R)) - hilbertf2(0.828 * (mid(L,R)));
Y1(L,R) = 0.763 * (mid(L,R)) + hilbertf2(0.385 * (sid(L,R)));

//         W-gain                     X-gain                     Y-gain
LF(L,R) = (0.21426224 * (W1(L,R))) + (0.19218459 * (X1(L,R))) + (0.20409261 * (Y1(L,R)));
RF(L,R) = (0.21426400 * (W1(L,R))) + (0.19218379 * (X1(L,R))) - (0.20409362 * (Y1(L,R)));
CF(L,R) = (0.09993309 * (W1(L,R))) + (0.15577050 * (X1(L,R))) + (0.00000000 * (Y1(L,R)));
LS(L,R) = (0.44287748 * (W1(L,R))) - (0.27006948 * (X1(L,R))) + (0.30405695 * (Y1(L,R)));
RS(L,R) = (0.44287676 * (W1(L,R))) - (0.27006941 * (X1(L,R))) - (0.30405595 * (Y1(L,R)));

LFE(C0,SUB0,L0,R0) = 0.0;

process(L,R,C0,SUB0,L0,R0) = LF(L,R), RF(L,R), CF(L,R), LFE(C0,SUB0,L0,R0), LS(L,R), RS(L,R);
