//-------------------------------------------------
// UHJ LR STEREO TO PLANAR B-FORMAT DECODER
//-------------------------------------------------

declare name "UHJ2BFMT";
declare version "1.0";
declare author "Giuseppe Silvi";
declare copyright "Giuseppe Silvi 2018";
declare license "BSD";
declare reference "giuseppesilvi.com";
declare description "Gerzon's UHJ to Planar B-Format DECODER";

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

mid(L,R) = 0.5 * (L + R);
sid(L,R) = 0.5 * (L - R);

W1(L,R) = 0.982 * (sid(L,R)) + hilbertf2(0.164 * (mid(L,R)));
X1(L,R) = 0.419 * (sid(L,R)) - hilbertf2(0.828 * (mid(L,R)));
Y1(L,R) = 0.763 * (mid(L,R)) + hilbertf2(0.385 * (sid(L,R)));

// using L0 and R0 to balancing I/O for vst production
process(L,R,L0,R0) = W1(L,R), X1(L,R), Y1(L,R), 0.0;
