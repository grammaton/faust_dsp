// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

phasor(f)   = f/fconstant(int fSamplingFreq, <math.h>) : (+,1.0:fmod) ~ _ ;
osc(f)      = phasor(f) * 6.28318530718 : sin;
process     = osc(hslider("frequenza", 440, 20, 20000, 1)) * hslider("level", 0, 0, 1, 0.01);