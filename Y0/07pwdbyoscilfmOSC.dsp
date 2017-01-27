// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

phasor(f)   = f/fconstant(int fSamplingFreq, <math.h>) : (+,1.0:fmod) ~ _ ;
osc(f)      = phasor(f) * 6.28318530718 : sin;

modulator(lo,hi,f) = (hi+lo)/2 + (hi-lo)*osc(f)/2;

pwdm(p,f)    = phasor(f) : >(p) : *(2) : -(1);        // mista con applicazione parziale

process      = vgroup("controls", pwdm(pulse, freq) * level)
  with {
    pulse = modulator(0.1, 0.9, fm)
    with { fm = hslider("modulation",1,0.1,100,0.01); };
    freq  = hslider("frequenza", 440, 20, 20000, 1);
    level = hslider("level", 0, 0, 1, 0.01);
};