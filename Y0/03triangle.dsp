// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

phasor(f)    = f/fconstant(int fSamplingFreq, <math.h>) : (+,1.0:fmod) ~ _ ;
triangle(f)  = phasor(f) : -(0.5) : abs : *(2) : -(1);        // mista con applicazione parziale
process      = triangle(hslider("frequenza", 440, 20, 20000, 1)) * hslider("level", 0, 0, 1, 0.01);
