// A SIMPLE OSC GRABBED FROM FAUST WEBSITE

import("math.lib");

phasor(f)     = f/SR : (+,1.0:fmod) ~ _ ;
osc(f)        = phasor(f) *(2*PI) : sin;
square(f)  = phasor(f) : >(0.5) : *(2) : -(1);        // mista con applicazione parziale
sawtooth(f)   = phasor(f) * 2 - 1;
noise         = +(12345) ~ *(11035515245) : /(2147483647.0);

multiwave(v,f,m) =    (w==1)*osc(f)
                    + (w==2)*square(f)
                    + (w==3)*sawtooth(f)
                    + (w==4)*noise with {w = int(m+0.5);}
                    : *(v);

process = multiwave(
  hslider("level", 0, 0, 1, 0.01),
  hslider("freq[scale:log]", 440, 20, 20000, 1),
  vslider("wave[style:menu{'off':0;'sine':1;'square':2;'sawtooth':3;'noise':4}]",
    0, 0, 4, 0.01)
  )<: _,_;
  