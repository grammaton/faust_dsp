//------------------------------ high_shelf ------------------------------------

import("filter.lib");

O	= hslider("Order", 3, 1, 12, 1); // Order 1 3 5 7… Odd only
G	= hslider("Gain [unit:dB]", 0, -10, 10, 0.1);
F 	= hslider("Freq", 1000, 100, 10000, 1);

//-------------------------------------------------
// BA MODULE
//-------------------------------------------------

//process = _: highshelf(O,G,F): _;

//shelfed(W) = W: highshelf(O, G, F) : W ;

process(W, X, Y, Z) =	(0.5 * ( W + X + Y + Z)),
					(0.5 * ((W + X) - (Y - Z))),
					(0.5 * ((W - X) - (Y - Z))),
					(0.5 * ((W - X) - (Y + Z)));

//process(W, X, Y, Z) = 	W : highshelf(O,G,F): W,
//					X : highshelf(O,G,F): X,
//					Y : highshelf(O,G,F): Y,
//					Z : highshelf(O,G,F): Z;
