// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

phasor(f)    = f/fconstant(int fSamplingFreq, <math.h>) : (+,1.0:fmod) ~ _ ;
quadracs(f)  = phasor(f) > 0.5 : > : _,2 : * : _,1 :-;  // core syntax
quadraifx(f) = (phasor(f) > 0.5) * 2 - 1;               // infix
quadramix(f) = phasor(f) : >(0.5) : *(2) : -(1);        // mista con applicazione parziale
process      = quadramix(hslider("frequenza", 440, 20, 20000, 1)) * hslider("level", 0, 0, 1, 0.01);
