// =====================================================================
// SuperCollider Workspace
// =====================================================================

//:
MIDIdef.cc(\midi,{| val, num, chan, src|
	[val, num, chan, src].postln;
	if (num == 2, {
		~st = val;
	});
	if (num == 5, {
		~freq = val;
	});
	if (num == 3, {
		~dust = LinLin.kr(val, 0, 127, 20, 200);
	});
	if (num == 1, {
		
		
	})
	//	Synth.new(\ante, [\freq, val.midicps, \gate, 1]);
})

//:
~round = 3;
~st = 100;
~freq = 380;
~dust = 20;
~max = 1200;

//:
MIDIdef.noteOn(\pad, {|val, num, chan, scr|
	[val,num, chan, scr].postln;
	if (num == 55, {
		~t.schedAbs(0, {
			~keys[num] = Synth(\mpou, [\gate, 1, \st, ~st]);
			2
		})
	});
	if (num == 54, {
		~keys[num] = Synth(\gauss, [\gate, 1]);
	});
	if (num == 57, {
		~keys[num] = Synth(\blip, [\gate, 1, \dust, ~dust]);
	});
	if (num == 60, {
		~tc.schedAbs(0, {
			4.do{
				Synth(\lfpar,[
					\gate, 1,
					\freq, (Scale.minor.degrees+60).midicps.choose,
				]);
			};
			2
		});
	});
	if (num == 48, {
		~keys[num] = Synth(\ante, [
			\gate, 1,
			\freq, ~freq]
		);
	});
});

//:
MIDIdef.noteOn(\padOff, {|val, num, chan|
	if (~keys[num] != nil, {
		~keys[num].set(\gate, 0);
		~keys[num] = nil;
	});
})

//:
~keys = Array.newClear(128);
//:
MIDIClient.init;
MIDIIn.connectAll;

//:
MIDIdef.noteOn(\pad, {|val, num, chan, scr|
	[val,num, chan, scr].postln;
});

//:
MIDIdef.cc(\pada, {|val, num, chan, scr|
	[val,num, chan, scr].postln;
});

//:
