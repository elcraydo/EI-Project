<Cabbage>
#define IdleColour													fontcolour:0(200, 200, 200)
#define GainSlider													range(0, 4, 1, 0.475, 0.01), trackercolour(9, 214, 214, 128), colour(0, 0, 0, 255)
form size(670, 386), 												caption("Room Tuner"), colour(10, 5, 0, 255)
image bounds(10, 5, 650, 373), 										colour(90, 90, 90)
image bounds(15, 40, 640, 140), 									colour(60, 60, 60)
image bounds(15, 155, 220, 70), 									colour(60, 60, 60)
image bounds(15, 230, 110, 143), 									colour(60, 60, 60)
image bounds(435, 185, 110, 40), 									colour(60, 60, 60)
image bounds(550, 185, 105, 188), 									colour(60, 60, 60)
image bounds(33, 10, 624, 25), 		file("31bands.png")
; Start and Reverb
button bounds(20, 337, 100, 30),	channel("Audio"),				text("Audio Off", "Audio On"), fontcolour:1(128, 0, 0), fontcolour:0(200, 200, 200),				value(1)
combobox bounds(20, 235, 100, 60),	channel("Type"),				items("Room", "Hall", "Plate", "RehearsalRoom"), caption("Reverb"), colour(9, 214, 214, 200), fontcolour("black")
button bounds(20, 301, 100, 30), 	channel("Reverb"),				text("Reverb Off", "Reverb On"), value(1), fontcolour:1(9, 214, 214, 200), fontcolour:0(200, 200, 200)
; EQ & Master
button bounds(20, 190, 100, 30),	channel("EQBypass"),			text("EQ Off", "EQ On"), value(1), fontcolour:1(9, 214, 214, 200), fontcolour:0(200, 200, 200)
vslider bounds(10, 40, 30, 150),	channel("EQGain"),				range(0, 4, 1, 0.475, 0.1), colour(0, 0, 0, 255), fontcolour(0, 0, 0, 255), textcolour(0, 0, 0, 255)
vslider bounds(0, 0, 30, 150),		widgetarray("Gain", 31),		$GainSlider
image  bounds(0, 0, 10, 14),		widgetarray("Indicator", 31),	colour(0, 0, 0, 0), shape("ellipse")
vslider	bounds(550, 195, 106, 176), channel("MasterFader"),			range(0, 1, 1, 1, .01), text("Master Volume"), trackercolour(128, 0, 0), colour("black"), outlinecolour("black"), textcolour("black")
; Analyser
image	bounds(120, 185, 425, 185), 								plant("AdminPanel"), identchannel("adminident"), colour(,,,0), visible(0) {
gentable bounds(10, 50, 410, 50), 	tableNumber(2, 1), 				tablecolour("green", "blue"), amprange(-5, 5, -1), tablegridcolour(9, 214, 214, 8), tablebackgroundcolour("black"), samplerange(0, 32), identchannel("tableident"), fill(0)
gentable bounds(10, 100, 410, 50), 	tableNumber(3), 				tablecolour("red"), amprange(-5, 5, -1), tablegridcolour(9, 214, 214, 8), tablebackgroundcolour("black"), samplerange(0, 32), identchannel("tableident2"), fill(0)
textbox bounds(10, 152, 410, 30),	file("text.txt")
image bounds(120, 0, 295, 40), 										colour(60, 60, 60)
button	bounds(125, 5, 100, 30), 	channel("Compare"), 			latched(0), text("Compare"), fontcolour:1(9, 214, 214, 128), $IdleColour
button	bounds(225, 5, 48, 30), 	channel("Store"), 				latched(0), text("Store"), fontcolour:1(200, 0, 0), $IdleColour
button	bounds(273, 5, 47, 30), 	channel("TableReset"), 			latched(0), text("Def."), fontcolour:1(9, 214, 214, 128), $IdleColour
}
button bounds(440, 190, 100, 30), 	channel("Hide"), 				text("Admin"), fontcolour:1(9, 214, 214, 128), $IdleColour,
button bounds(130, 190, 100, 30), 	channel("Reset"),				latched(0), text("Reset Sliders"),   fontcolour:1(9, 214, 214, 128), $IdleColour
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d
</CsOptions>
<CsInstruments>
sr 		= 	44100
ksmps 	= 	32
nchnls 	= 	2
0dbfs	=	1

giBands	=	31
giQ		=	2.8
gk_array[] init 65											; Initialise global arrays
gi_CenterFreq[] fillarray 20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000    ; Filterbank center freqs
;============================================================ UDO ============================================================;
opcode	graphictuner_jm, a,   iakkk[]
	iCnt, aEQAudioIn, kReset, kEQGain, kGain[]	xin
	if iCnt==0 goto exitloop

	if changed(kReset)==0 then								; Reset gain slider widgets
		if kReset==1 then									;
			chnset k(1),  sprintfk("Gain%d", iCnt)			;
			chnset k(1),  "EQGain"							;
		endif												;
	endif													;
	chnset sprintf("pos(%d, 40)", 10+iCnt*20), sprintf("Gain_ident%d", iCnt)							; Position slider widgets
	chnset sprintf("pos(%d, 16)", 20+iCnt*20), sprintf("Indicator_ident%d", iCnt)						; Position indicator widgets

	kGain[iCnt] port kGain[iCnt], 0.005
	aFilterOut butterbp aEQAudioIn*kGain[iCnt]*kEQGain, gi_CenterFreq[iCnt], gi_CenterFreq[iCnt]/giQ	; Recursive filterbanks

	aEQAudioOut graphictuner_jm iCnt-1, aEQAudioIn, kReset, kEQGain, kGain								; Recursive call to UDO

	exitloop:
	aFinalOut = (aFilterOut + aEQAudioOut)*0.95				; Sum outputs and gain down to compensate for bypass 
	xout	aFinalOut										; UDO outputs
endop
;======================================================== INSTRUMENT 1 =======================================================;
instr 1
kGain[] init giBands+1										; Initialise arrays to store widget values
kCnt = 1
loop:														; Call in current widget values
	kGain[kCnt] chnget sprintfk("Gain%d",kCnt)				;
loop_lt kCnt,1,giBands+1,loop								;

kMix=0.5
kVol = .05*kMix     										; Overall volume level of reverb. May need to adjust when wet/dry mix is changed, to avoid clipping.
iPartitionSize = 1024										; Size of each convolution partion
iDel = (ksmps < iPartitionSize ? iPartitionSize + ksmps : iPartitionSize)/sr   ; latency of pconvolve opcode
kCount	init iDel*kr 										; Since we are using a soundin (diskin2) [instead of ins] we can do a kind of "look ahead" by looping during one k-pass without output, creating zero-latency

kType	chnget "Type" 										; Restart when new a IR is selected
if changed(kType)==1 then 									;
	reinit RESTART 											;
endif 														;
RESTART:													;

iType=i(kType)
SVerb sprintfk "%d.wav", (iType<1? 1:iType) 				; This avoids a value of 0. The IRs contained in the folder should be named "1.wav, "2.wav", "3.wav", "4.wav"

kAudio chnget "Audio"
if changed(kAudio)==0 then									; on/off button
	if kAudio==1 then
		loop:
			aAudioinL, aAudioInR diskin2 "Demo1.wav", 1,0,1	; Audio file input
			aEQAudioIn=((aAudioinL+aAudioInR)/2)*0.9		; Sum channels and gain down
			kEQBypass chnget "EQBypass"						; EQ bypass
			if changed(kEQBypass)==0 then
				if kEQBypass==0 then
					aEQAudioOut = aEQAudioIn
				elseif kEQBypass==1 then
					kReset chnget "Reset"
					kEQGain chnget "EQGain"
					aEQAudioOut graphictuner_jm giBands, aEQAudioIn, kReset, kEQGain, kGain	; Call UDO
				endif
			endif

			aWetL, aWetR pconvolve kVol*(aEQAudioOut), SVerb, iPartitionSize	; Reverb
			aDry delay (1-kMix)*aEQAudioOut,iDel  			; Delay dry signal, to align it with output of the reverb
			kCount = kCount - 1

  		if kCount > 0 kgoto loop

   		kReverb chnget "Reverb"								; Reverb on/off
   		aLeft = (aWetL*kReverb)+aDry						; Mix wet and dry
   		aRight = (aWetR*kReverb)+aDry						;

		kMasterFader	chnget "MasterFader"				; Master Fader
		kMasterFader 	port kMasterFader, 0.005			;
		outs aLeft*kMasterFader, aRight*kMasterFader		; Audio outputs
	endif
endif

kCompare		chnget "Compare"
kStore			chnget "Store"
kTableReset		chnget "TableReset"
if kCompare+kStore+kTableReset>0 then						; Initiate table update
	event "i", 2, 0, .5,  	kEQGain, kGain[1], kGain[2], kGain[3], kGain[4], kGain[5], kGain[6], kGain[7], kGain[8], kGain[9], kGain[10], \
							kGain[11], kGain[12], kGain[13], kGain[14], kGain[15], kGain[16], kGain[17], kGain[18], kGain[19], kGain[20], \
							kGain[21], kGain[22], kGain[23], kGain[24], kGain[25], kGain[26], kGain[27], kGain[28], kGain[29], kGain[30], kGain[31]
endif

kHide chnget "Hide"											; Show/hide features
chnset sprintfk("visible(%d)", kHide), "adminident"			;
endin
;======================================================== INSTRUMENT 2 =======================================================;
instr 2														; Update table
iTableL	ftgen 1, 0, 64, -2, p4,  p5,  p6,  p7,  p8,  p9,  p10, p11, p12, p13, p14, \
							p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, \
							p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35

kStore			chnget "Store"								
if changed(kStore)==1 then
	vcopy	2, 1, 64										; Store current widget positions to table 2
endif

kTableReset		chnget "TableReset"								
if changed(kTableReset)==1 then
	vcopy	2, 4, 64										; Restore default widget positions to table 2
endif

chnset	"tablenumber(1,2)", "tableident"					; Update table displays (this line can only appear once per gentable widget)
vcopy	3, 1, 64											; Copies widget position table into table 3
vsubv	3, 2, 64,0,0,0										; Subtracts values of table 2 from table 3 and overwrites table 3
chnset	"tablenumber(3)", "tableident2"						; Displays new values of table 3
copyf2array gk_array, 3										; Copies the resultant table into the global array

kCnt2		init 1											; Counter must be k-rate for the array opcode to work
while kCnt2 < 32 do
	S1 sprintfk "pos(%d, 16), colour(255, 0, 0, %d)", kCnt2%31*20+20, abs(gk_array[kCnt2]*63); determines the brightness of the indicators, position must be included again
	S2 sprintfk "Indicator_ident%d", kCnt2					;
	chnset S1, S2											; Updates the indicators, overwriting any previous chnset to the same identchannel
	kCnt2=kCnt2+1
od
endin
</CsInstruments>
<CsScore>
f0 z
f1 0 64 -2   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1	; Initial widget table, overwritten by instrument 2 when "Compare" is pressed (Blue)
f2 0 64 -2   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1	; Customizable preset ideal example table (Green)
f3 0 64 -2   0 0 0 0 0 0 0 0 0 0   0 0 0 0 0 0 0 0 0 0   0 0 0 0 0 0 0 0 0 0   0 0	; Initial table to be overwritten by comparative table (Red)
f4 0 64 -2   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1 1 1 1 1 1 1 1 1   1 1	; Default widget position for reset
i1 0 [3600*24*7]
</CsScore>
</CsoundSynthesizer>

