var keys;
~keys = Array.newClear(128);

//:
~noteOnFunc = {arg val, num, chan, src;
	var node;
	node = ~keys.at(num);
	if (node.notNil, {
		node.release;
		~keys.put(num, nil);
	});
	node = Synth(\mpou);
	~keys.put(num, node);
};

//:
MIDIdef.noteOn(\on, ~noteOnFunc);

//:
~noteOffFunc = {arg val, num, chan, src;
	var node;
	node = ~keys.at(num);
	if (node.notNil, {
		node.release;
		~keys.put(num, nil);
	});
};

//:
MIDIdef.noteOff(\off, ~noteOffFunc);
)

//:
SynthDef.new(\mpou, {|st=100, gate=1|
	var sig, env;
	sig = SinOsc.ar(XLine.kr(st, 60, 3), 0, 0.4);
	env = Env([1, 1, 0], [2, 2], \hold);
	sig = sig * EnvGen.kr(env, gate, doneAction: 2);
	sig = Pan2.ar(sig, 0);
	Out.ar(0, sig);
}).add;