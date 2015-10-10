// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

pwdm(p,f)    = phasor(f) : >(p) : *(2) : -(1);        // mista con applicazione parziale

// process      = pwdm(hslider("pulse",0.5,0.99,0,0.01), hslider("frequenza", 440, 20, 20000, 1)) * hslider("level", 0, 0, 1, 0.01);

process      = pwdm(pulse, freq) * level
  with {
    pulse = hslider("pulse",0.5, 0, 0.99,0.01);
    freq  = hslider("frequenza", 440, 20, 20000, 1);
    level = hslider("level", 0, 0, 1, 0.01);
};