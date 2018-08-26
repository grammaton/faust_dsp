//-------------------------------------------------
// PLANAR B-FORMAT TO UHJ LR STEREO ENCODER
//-------------------------------------------------

declare name "BFMT2UHJ";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Gerzon's Planar B-Format to UHJ Encoder";

import("stdfaust.lib");
import("filters.lib");

biquad(a1,a2,b0,b1,b2) = + ~ conv2(a1,a2) : conv3(b0,b1,b2)
  with{
    conv3(k0,k1,k2,x) = k0*x + k1*x'+ k2*x'';
    conv2(k0,k1,x) = k0*x + k1*x';
  };

hilbertf1 = biquad(-0.02569, 0.260502, -0.260502, 0.02569, 1) :
           biquad(1.8685, -0.870686, 0.870686, -1.8685, 1) ;
hilbertf2 = biquad(1.94632, -0.94657, 0.94657, -1.94632, 1) :
           biquad(0.83774, -0.06338, 0.06338, -0.83774, 1) ;

  sigma(W,X) = 0.9397 * (W) + 0.1856 * (X);
delta(W,X,Y) = hilbertf1(-0.3420 * (W) + 0.5099 * (X)) + (0.6555 * (Y));
  tau(W,X,Y) = hilbertf1(-0.1432 * (W) + 0.6512 * (X)) - (0.7071 * (Y));
   quelet(Z) = 0.9772 * (Z);

 left(W,X,Y,Z) = 0.5 * (sigma(W,X) + delta(W,X,Y));
right(W,X,Y,Z) = 0.5 * (sigma(W,X) - delta(W,X,Y));

// using 0.0 on ch 3 and 4 to balancing I/O for vst production
process(W,X,Y,Z) = left(W,X,Y,Z), right(W,X,Y,Z), 0.0, 0.0;
