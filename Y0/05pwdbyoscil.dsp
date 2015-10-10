// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

phasor(f)   = f/fconstant(int fSamplingFreq, <math.h>) : (+,1.0:fmod) ~ _ ;
osc(f)      = phasor(f) * 6.28318530718 : sin;
//control     = osc(hslider("controlfreq", 440, 0, 20, 1));
modulator(lo,hi,f) = (hi+lo)/2 + (hi-lo)*osc(f)/2;

pwdm(p,f)    = phasor(f) : >(p) : *(2) : -(1);        // mista con applicazione parziale

// process      = pwdm(hslider("pulse",0.5,0.99,0,0.01), hslider("frequenza", 440, 20, 20000, 1)) * hslider("level", 0, 0, 1, 0.01);

process      = pwdm(pulse, freq) * level
  with {
    pulse = modulator(0.1, 0.9, 0.1);
    freq  = hslider("frequenza", 440, 20, 20000, 1);
    level = hslider("level", 0, 0, 1, 0.01);
};