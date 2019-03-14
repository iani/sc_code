//:
//init MIDI
MIDIClient.init;
MIDIIn.connectAll;
~keys = Array.newClear(128);

//:
~noteOnFuncHold = {| vel, num, chan, src|
	var node, sound;
	node = ~keys.at(num);
	//if not empty release
	if(node.notNil,{
		node.set(\gate, 0);
		node.release;
		~keys.put(num, nil);
	},{//if emmpty add sound
		node = Synth(~sound);
		~keys.put(num, node);
	});
};

//every channel is a sound
MIDIdef.noteOn(\pad, {| vel, num, chan, src|
	[vel, num, chan, src].postln;
	if(chan == 0, {
		~sound = \mpou;	
	});
	if(chan == 2, {
		~sound = \lfpar;
	});
	~noteOnFuncHold.value(vel, num, chan, src)
});

//:
MIDIdef.cc(\midi,{| val, num, chan, src|
	[val, num, chan, src].postln;
	if(chan == 2, {
		if(num == 1,{
			~keys[67].set(\add, val);			
		});
		if(num == 2, {
			~keys[67].set(\cfhzmin, val/10);	
		});
		if(num == 3, {
			~keys[67].set(\count, val);
			
		})
	
	});
})
~keys[67].set(\add, 60);