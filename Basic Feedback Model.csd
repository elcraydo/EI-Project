<Cabbage>
; Form
form caption("Basic Feedback Model") size(411, 386), colour(10, 5, 0, 255), pluginID("def1")
image bounds(10, 5, 391, 373), 		colour(90, 90, 90)
image bounds(15, 10, 150, 40), 		colour(60, 60, 60)
image bounds(125, 30, 40, 40), 		colour(60, 60, 60)
image bounds(195, 10, 201, 25), 	colour(60, 60, 60)
image bounds(175, 40, 221, 140), 	colour(60, 60, 60)
image bounds(175, 155, 110, 70), 	colour(60, 60, 60)
image bounds(175, 230, 110, 143), 	colour(60, 60, 60)
image bounds(290, 185, 106, 188), 	colour(60, 60, 60)
label bounds(20, 345, 100, 15), 	text("Distance &"), fontcolour("black")
label bounds(20, 360, 100, 15), 	text("Direction"), fontcolour("black")
; Distane & Direction
rslider bounds(20, 55, 100, 100), 	channel("Direction"), range(-1, 1, 0, 1, .001), colour("black"), trackercolour("60, 35, 0"), outlinecolour(0, 0, 0, 50), identchannel("DirectionKnob")
rslider bounds(130, 7, 30, 60), 	channel("SourceVolume"), range(0.01, 1, 0.1, .5, .001), colour(10, 10, 10), textcolour("black"), trackercolour(128, 0, 0), outlinecolour(0, 0, 0, 50), text("Vol")
button bounds(20, 15, 100, 30),		channel("SourceButton"), text("Source", "Mute Source"), fontcolour:1(128, 0, 0), fontcolour:0(200, 200, 200),
vslider bounds(50, 95, 40, 220),	channel("Distance"), range(0, 1, 0, 1, 0.01), colour(60, 60, 60), alpha(0.25)
; Reverb & Master
vslider bounds(290, 195, 106, 177), channel("Level"), range(0, 1, 1, 1, .01), text("Master Volume"), trackercolour(128, 0, 0), colour("black"), outlinecolour("black"), textcolour("black")
combobox bounds(180, 235, 100, 60), channel("Type"), items("Room", "Hall", "Plate"), caption("Reverb"), colour(9, 214, 214, 200), fontcolour("black")
button bounds(180, 301, 100, 30), 	channel("Reverb"), text("Reverb Off", "Reverb On"), value(1), fontcolour:1(9, 214, 214, 200), fontcolour:0(200, 200, 200)
button bounds(180, 337, 100, 30), 	channel("Feedback"), text("Feedback Off", "Feedback On"), value(1), fontcolour:1(9, 214, 214, 200), fontcolour:0(200, 200, 200)
; EQ
button bounds(180, 190, 100, 30),	channel("EQBypass"), text("EQ Off", "EQ On"), value(1), fontcolour:1(9, 214, 214, 200), fontcolour:0(200, 200, 200)
vslider bounds(170, 40, 30, 150),	channel("EQGlobalGain"), range(0, 4, 1, 0.5, 0.01), colour(0, 0, 0, 255), fontcolour(0, 0, 0, 255), textcolour(0, 0, 0, 255)
vslider bounds(190, 40, 30, 150),	widgetarray("EQBandGain", 10), range(0, 4, 1, 0.5, 0.01), trackercolour(9, 214, 214, 128), colour(0, 0, 0, 255)
image  bounds(200, 15, 10, 15),		widgetarray("Indicator", 10), colour(0, 0, 0), shape("ellipse")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments> 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

gaFeedback init 0
   
instr 1
iCnt			init 0
while iCnt < 10 do
	chnset sprintfk("pos(%d, 40)", iCnt%10*20+190), sprintfk("EQBandGain_ident%d", iCnt+1)	; Position slider widgets
	chnset sprintfk("pos(%d, 15)", iCnt%10*20+200), sprintfk("Indicator_ident%d", iCnt+1)	; Position indicator widgets
	iCnt=iCnt+1
od

kEQBandGain[]	init 11										; Gets info from all band slider widgets
kIndex = 1													;
while kIndex<11 do											;
	kEQBandGain[kIndex] chnget sprintfk("EQBandGain%d", kIndex)	;
	kIndex = kIndex+1										;
od

kEQGlobalGain 	chnget "EQGlobalGain"
kEQBypass 		chnget "EQBypass"
kDistance 		chnget "Distance"							; Move listener position (changes direct source level)
kDist= 255-(kDistance*200)									; Makes the rslider Y position move from 250 to 50
chnset sprintfk("bounds(20, %d, 100, 100)", kDist), "DirectionKnob"

kLevel			chnget "Level"
kLevel portk kLevel, .05									; Smooth master volume changes
kMix=0.5
kVol = .05*kMix     										; Overall volume level of reverb. May need to adjust when wet/dry mix is changed, to avoid clipping.
iPartitionSize = 1024										; Size of each convolution partion
iDel = (ksmps < iPartitionSize ? iPartitionSize + ksmps : iPartitionSize)/sr   ; latency of pconvolve opcode

kCount			init iDel*kr 								; Since we are using a soundin (diskin2) [instead of ins] we can do a kind of "look ahead" by looping during one k-pass without output, creating zero-latency

kType			chnget "Type" 								; Restart when new a IR is selected
if changed(kType)==1 then
	reinit RESTART
endif

RESTART:
iType=i(kType)
SVerb sprintfk "%d.wav", (iType<1? 1:iType) 				; This avoids a value of 0. The IRs contained in the folder should be named "1.wav, "2.wav", "3.wav"

kStart			chnget "SourceButton"
if changed(kStart)==0 then									; on/off button
	if kStart==1 then
		loop:
    		aSigin diskin2 "drumloop.wav", 1, 0, 1

			kSourceVol chnget "SourceVolume"
			kSourceVol portk kSourceVol, 0.005				; Smooth volume changes
			kFeedback  chnget "Feedback"
			aSig = (aSigin*kSourceVol*(kDistance<.1? .1:kDistance))+(gaFeedback*kFeedback)	; Add feedback loop
			gaFeedback=0									; Clear the buffer

 			if changed(kEQBypass)==0 then
 				if kEQBypass==0 then 
					aEQOut = aSig
			  	elseif kEQBypass==1 then
					iq=2.5
					aBand1 butterbp aSig*kEQBandGain[1]*kEQGlobalGain, 32.70, 32.70/iq
					aBand2 butterbp aSig*kEQBandGain[2]*kEQGlobalGain, 65.41, 65.41/iq
					aBand3 butterbp aSig*kEQBandGain[3]*kEQGlobalGain, 130.81, 130.81/iq
					aBand4 butterbp aSig*kEQBandGain[4]*kEQGlobalGain, 261.63, 261.63/iq
					aBand5 butterbp aSig*kEQBandGain[5]*kEQGlobalGain, 523.25, 523.25/iq
					aBand6 butterbp aSig*kEQBandGain[6]*kEQGlobalGain, 1046.50, 1046.50/iq
					aBand7 butterbp aSig*kEQBandGain[7]*kEQGlobalGain, 2093, 2093/iq
					aBand8 butterbp aSig*kEQBandGain[8]*kEQGlobalGain, 4186, 4186/iq
					aBand9 butterbp aSig*kEQBandGain[9]*kEQGlobalGain, 8372, 8372/iq
					aBand10 butterbp aSig*kEQBandGain[10]*kEQGlobalGain, 16744, 16744/iq
					aEQOut = (aBand1+aBand2+aBand3+aBand4+aBand5+aBand6+aBand7+aBand8+aBand9+aBand10)
  				endif
			endif	 
        
    		aWetl, aWetr pconvolve kVol*(aEQOut), SVerb, iPartitionSize
    		aDry delay (1-kMix)*aEQOut,iDel  				; Delay dry signal, to align it with output of the reverb
    		kCount = kCount - 1
 		if kCount > 0 kgoto loop

   		kReverb chnget "Reverb"   
   		aLeft = (aWetl*kReverb)+aDry
   		aRight = (aWetr*kReverb)+aDry

		aDel vdelay (aLeft+aRight)/2, 20, 40				; Feedback delay, change delay time to alter pitch of feedback

		kFeedgain chnget "Direction"
		gaFeedback=aDel*(1-(kFeedgain^2))					; Squaring the value makes it positive regardless of rslider going from -1 to 1, but adds a skew to the polar pattern
  
    	outs aDel*kLevel, aDel*kLevel
	endif
endif
 
fSig pvsanal gaFeedback, 1024, 1024/4, 1024, 1    			; Spectrally analyses the signal
kFr, kAmp pvspitch fSig, 0.01								; pvspitch finds the fundamental and the amplitude of the fundamental

SColour sprintfk "colour(%d, 0, 0)", kAmp*255
SIdent sprintfk "Indicator_ident%d", (round (log(kFr)))
		chnset SColour, SIdent
endin
</CsInstruments>
<CsScore>
f0 z
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
