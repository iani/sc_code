//:
4.do{
	Synth(
		\lfpar,
		[
			\freq, (Scale.minor.degrees+60).midicps.choose,
			\amp, 0.25,
			\cfmin, 50 * 2,
			\cfmax, 50 * 50,
			\rqmin, 0.5,
			\rqmax, 0.8,
			\cfhzmin, 1,
			\cfhzmax, 6,
		]
	);
};

// rephrase this as pattern (in sc-hacks)
//:step 0 : test as synth
\lfpar +> \rephrase;
//:test release!
\rephrase.ppp release: 1;
//:rephrase step 0b: in pattern simple
(instrument: \lfpar) +> \rephrase;
//:rephrase step 1: in pattern, with midinotes
(midinote: (Scale.minor.degrees+60).prand) +> \rephrase;
//:rephrase step 2: faster - test release
(dur: 0.1) +> \rephrase;
//:rephrase step 2: faster - test release
(dur: 0.9) +> \rephrase;
//:rephrase step 3: test legato .... 
(legato: 1.9) +> \rephrase;
//:rephrase step 3: test legato .... 
(legato: 2.9) +> \rephrase;
//:
