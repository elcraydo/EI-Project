<Cabbage>
#define GainKnob		range(0.000000000001, 4, 1, 0.475, 0.01), 	colour(0, 0, 0, 255), trackercolour(155, 0, 0, 128), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50)
#define GainFader		range(0, 4, 1, 0.475, 0.01), 				colour(0, 0, 0, 255), fontcolour(0, 0, 0, 255), textcolour(0, 0, 0, 255)
#define PanKnob			range(-1, 1, 0, 1, 0.01), 					colour(0, 0, 0, 255), trackercolour(0, 108, 0, 255), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50)
#define AuxKnob			range(0, 4, 0, 0.475, 0.01), 				colour(0, 0, 0, 255), trackercolour(155, 0, 0, 128), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50)
#define FilterGainKnob	range(0.1, 4, 1, 0.475, 0.01), 				colour(0, 0, 0, 255), trackercolour(155, 0, 0, 128), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50)
#define FreqKnob													colour(0, 0, 0, 255), trackercolour(9, 214, 214, 128), textcolour(0, 0, 0, 255), outlinecolour(0, 0, 0, 50)
#define QKnob			range(2.2, 2.8, 2.5, 1, .01), 				colour(0, 0, 0, 255), trackercolour(155, 155, 155, 255), textcolour(155, 155, 155, 125), outlinecolour(0, 0, 0, 50)
#define IdleColour													fontcolour:0(200, 200, 200)
#define FilterButton												fontcolour:0(200, 200, 200), fontcolour:1(9, 214, 214, 200)
#define SoloButton													fontcolour:0(200, 200, 200), fontcolour:1(9, 214, 214, 200)
#define MuteButton													fontcolour:0(200, 200, 200), fontcolour:1(255, 0, 0, 128)
;Form
form	size(1324, 745), caption("8 Channel Recursive Mixer"), pluginID("plu1"), colour(10, 5, 0, 255)
groupbox bounds(1060, 0, 150, 625), widgetarray("Groupbox",8), 		text("Channel"), colour(60, 60, 60)
label	bounds(1072, 32, 30, 40), 	widgetarray("Label",8), 		text("8")
groupbox bounds(1220, 0, 94, 625), 									text("Master"), colour(60, 60, 60)
image	bounds(-100, -100, 25, 66), widgetarray("ImageM",8),		colour(90, 90, 90)
image	bounds(1230, 171, 74, 127), 								colour(90, 90, 90)
image	bounds(1220, 635, 94, 40), 									colour(60, 60, 60), identchannel("boxident")
;Trim
rslider	bounds(1100, 25, 70, 70), 	widgetarray("Trim", 8), 		range(0, 4, 1, 0.5, 0.01), text("Trim"), $GainKnob
checkbox bounds(0, 0, 15, 8),		widgetarray("ChannelInd", 56),	shape("ellipse"), active(0), colour:1(0, 0, 0, 255)
;Parametric EQ
rslider	bounds(-100, -100, 70, 70), widgetarray("Low", 8), 			text("Low"), $FilterGainKnob 
rslider	bounds(-100, -100, 70, 50), widgetarray("LowMidFreq", 8), 	range(80, 800, 440, 1, 1), text("Low Mid Freq"), $FreqKnob
rslider	bounds(-100, -100, 50, 50),	widgetarray("LowMidQ", 8), 		text("Q"), $QKnob
rslider	bounds(-100, -100, 70, 50), widgetarray("LowMidGain", 8), 	text("Low Mid Gain"), $FilterGainKnob 
rslider	bounds(-100, -100, 70, 50), widgetarray("MidFreq", 8), 		range(800, 4000, 2400, 1, 1), text("Mid Freq"), $FreqKnob 
rslider	bounds(-100, -100, 50, 50),	widgetarray("MidQ", 8), 		text("Q"), $QKnob
rslider	bounds(-100, -100, 70, 50), widgetarray("MidGain", 8), 		text("Mid Gain"), $FilterGainKnob 
rslider	bounds(-100, -100, 70, 50), widgetarray("HiMidFreq", 8), 	range(4000, 8000, 6000, 1, 1), text("Hi Mid Freq"), $FreqKnob 
rslider	bounds(-100, -100, 50, 50),	widgetarray("HiMidQ", 8), 		text("Q"), $QKnob
rslider	bounds(-100, -100, 70, 50), widgetarray("HiMidGain", 8), 	text("Hi Mid Gain"), $FilterGainKnob 
rslider	bounds(-100, -100, 70, 70), widgetarray("High", 8), 		text("High"), $FilterGainKnob 
button	bounds(-100, -100, 34, 20), widgetarray("EQBypass", 8), 	text("EQ", "EQ"), value(1), $FilterButton
;Balance
rslider	bounds(1100, 395, 70, 70), 	widgetarray("Pan", 8), 			text("Pan"), $PanKnob
vslider	bounds(1090, 475, 90, 150), widgetarray("Fader", 8), 		$GainFader
button	bounds(1070, 475, 34, 20), 	widgetarray("Solo", 8), 		text("Solo", "Solo"), $SoloButton
button	bounds(1166, 475, 34, 20), 	widgetarray("Mute", 8), 		text("Mute", "Mute"), $MuteButton 
;Sends
rslider	bounds(1062, 420, 50, 50), 	widgetarray("Aux1", 8), 		text("Aux1"), $AuxKnob
rslider	bounds(1158, 420, 50, 50), 	widgetarray("Aux2", 8), 		text("Aux2"), $AuxKnob
button	bounds(1070, 395, 34, 20), 	widgetarray("PrePost1", 8), 	text("Pre", "Post"), fontcolour(200, 200, 200), $IdleColour
button	bounds(1166, 395, 34, 20), 	widgetarray("PrePost2", 8), 	text("Pre", "Post"), value(1), fontcolour(200, 200, 200), $IdleColour
;Master section
combobox bounds(1230, 31, 74, 60), 	channel("MultiSelect"), 		items("Multi A", "Multi B", "Multi C"), caption("Input"), colour(9, 214, 214, 200), fontcolour("black"), value(1)
combobox bounds(1230, 101, 74, 60), channel("OutputSource"), 		items("FOH", "Aux1", "Aux2"), caption("Output"), colour(9, 214, 214, 200), fontcolour("black"), value(1)
vslider	bounds(1222, 475, 90, 150), channel("MasterFader"), 		range(0, 1, 1, 1, .01), colour(0, 0, 0, 255), trackercolour(128, 0, 0), outlinecolour(0, 0, 0, 50)
rslider	bounds(1222, 420, 50, 50), 	channel("Aux1Master"), 			text("Aux1"), $GainKnob
rslider	bounds(1262, 420, 50, 50), 	channel("Aux2Master"), 			text("Aux2"), $GainKnob
button	bounds(1230, 365, 74, 20), 	channel("Audio"),				text("Audio Off", "Audio On"), $MuteButton,										value(1)
button	bounds(1230, 395, 74, 20), 	channel("Reset"), 				latched(0), text("Reset"), fontcolour:1(9, 214, 214, 128), $IdleColour
checkbox bounds(0, 0, 30, 15),		widgetarray("MasterInd", 14),	shape("ellipse"), active(0), colour:1(0, 0, 0, 255)
;Analyser
image	bounds(10, 635, 1304, 100), 								plant("AdminPanel"), identchannel("adminident"), colour(,,,0), visible(0) {
gentable bounds(0, 0, 1200, 50), 	tableNumber(2, 1), 				tablecolour("green", "blue"), amprange(-1, 5, -1), tablegridcolour(9, 214, 214, 8), tablebackgroundcolour("black"), samplerange(0, 168), identchannel("tableident"), fill(0)
gentable bounds(0, 50, 1200, 50), 	tableNumber(3), 				tablecolour("red"), amprange(-5, 5, -1), tablegridcolour(9, 214, 214, 8), tablebackgroundcolour("black"), samplerange(0, 168), identchannel("tableident2"), fill(0)
button	bounds(1220, 40, 74, 20), 	channel("Compare"), 			latched(0), text("Compare"), fontcolour:1(9, 214, 214, 128), $IdleColour
button	bounds(1220, 70, 44, 20), 	channel("Store"), 				latched(0), text("Store"), fontcolour:1(200, 0, 0), $IdleColour
button	bounds(1260, 70, 34, 20), 	channel("TableReset"), 			latched(0), text("Def."), fontcolour:1(9, 214, 214, 128), $IdleColour
}
button bounds(1230, 645, 74, 20), 	channel("Hide"), 				text("Admin"), fontcolour:1(9, 214, 214, 128), $IdleColour,
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1.0

giChannels = 8
gS_MultiArray1[] fillarray "A1.wav", "A2.wav", "A3.wav", "A4.wav", "A5.wav", "A6.wav", "A7.wav", "A8.wav"
gS_MultiArray2[] fillarray "B1.wav", "B2.wav", "B3.wav", "B4.wav", "B5.wav", "B6.wav", "B7.wav", "B8.wav"
gS_MultiArray3[] fillarray "C1.wav", "C2.wav", "C3.wav", "C4.wav", "C5.wav", "C6.wav", "C7.wav", "C8.wav"

opcode	ImAnOpcode, k, kii																	; User defined opcodes
	kin,iupport,idnport	xin																	;
	kold		init	0																	;
	kporttime	= (kin<kold?idnport:iupport)												;
	kout		portk	kin, kporttime														;
	kold		= kout																		;
	xout		kout																		;
endop																						;

opcode mixer_jk, aa, ikkk[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]k[]kkkkk
	icnt, kMultiSelect, kOutputSource, kTrim[], kEQBypass[], kLow[], kLowMidFreq[], kLowMidGain[], kLowMidQ[], kMidFreq[], kMidGain[], kMidQ[], kHiMidFreq[], kHiMidGain[], kHiMidQ[], kHigh[], \
															kMute[], kSolo[], kPan[], kFader[], kPrePost1[], kAux1[], kPrePost2[], kAux2[], kAux1Master, kAux2Master, kMasterFader, kAudio, kReset xin
	if icnt==0 goto exitloop

	if changed(kReset)==0 then																; Reset widgets
		if kReset==1 then
			kRST[] init 22																	; Lookup preset table and cast entries to a k-rate array
			kRSTcnt = 1																		;
			loop:																			;
				kRST[kRSTcnt] table kRSTcnt,4,0,-1											;
			loop_lt kRSTcnt,1,22,loop														;

			chnset kRST[1],  sprintfk("Trim%d",icnt)  	 									; Trim
			chnset kRST[2],  sprintfk("EQBypass%d",icnt)									; EQ bypass
			chnset kRST[3],  sprintfk("Low%d",icnt) 										; Parametric EQ
			chnset kRST[4],  sprintfk("LowMidFreq%d",icnt)									;
			chnset kRST[5],  sprintfk("LowMidGain%d",icnt)									;
			chnset kRST[6],  sprintfk("LowMidQ%d",icnt)										;
			chnset kRST[7],  sprintfk("MidFreq%d",icnt)										;
			chnset kRST[8],  sprintfk("MidGain%d",icnt)										;
			chnset kRST[9],  sprintfk("MidQ%d",icnt)										;
			chnset kRST[10], sprintfk("HiMidFreq%d",icnt)									;
			chnset kRST[11], sprintfk("HiMidGain%d",icnt)									;
			chnset kRST[12], sprintfk("HiMidQ%d",icnt)										;
			chnset kRST[13], sprintfk("High%d",icnt)										;
			chnset kRST[14], sprintfk("Mute%d",icnt)	  									; Mute
			chnset kRST[15], sprintfk("Solo%d",icnt)  										; Solo
			chnset kRST[16], sprintfk("Pan%d",icnt)											; Pan
			chnset kRST[17], sprintfk("Fader%d",icnt)										; Fader
			chnset kRST[18], sprintfk("PrePost1%d",icnt)									; Pre/Post 1
			chnset kRST[19], sprintfk("Aux1%d",icnt)	 									; Aux Send 1
			chnset kRST[20], sprintfk("PrePost2%d",icnt)									; Pre/Post 2
			chnset kRST[21], sprintfk("Aux2%d",icnt)										; Aux Send 2
		endif
	endif

	chnset sprintfk("pos(%d,%d)",(-140)+icnt*150, 0), sprintfk("Groupbox_ident%d",icnt)		; Background groupboxes
	chnset sprintfk("pos(%d,%d)",(-28)+icnt*150, 22), sprintfk("ImageM_ident%d",icnt)		; Background image
	chnset sprintfk("pos(%d,%d), text(%d)",(-128)+icnt*150, 32, icnt), sprintfk("Label_ident%d",icnt)	; Labels
	chnset sprintfk("pos(%d,%d)",(-100)+icnt*150, 25), 	sprintfk("Trim_ident%d",icnt)  	 	; Trim	
	chnset sprintfk("pos(%d,%d)",(-130)+icnt*150, 120),	sprintfk("EQBypass_ident%d",icnt)	; EQ bypass	
	chnset sprintfk("pos(%d,%d)",(-100)+icnt*150, 102),	sprintfk("Low_ident%d",icnt) 		; Parametric EQ
	chnset sprintfk("pos(%d,%d)",(-138)+icnt*150, 170),	sprintfk("LowMidFreq_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-62)+icnt*150, 170),	sprintfk("LowMidGain_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-90)+icnt*150, 170),	sprintfk("LowMidQ_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-138)+icnt*150, 218),	sprintfk("MidFreq_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-62)+icnt*150, 218),	sprintfk("MidGain_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-90)+icnt*150, 218),	sprintfk("MidQ_ident%d",icnt)		;
	chnset sprintfk("pos(%d,%d)",(-138)+icnt*150, 266),	sprintfk("HiMidFreq_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-62)+icnt*150, 266),	sprintfk("HiMidGain_ident%d",icnt)	;
	chnset sprintfk("pos(%d,%d)",(-90)+icnt*150, 266),	sprintfk("HiMidQ_ident%d",icnt)		;
	chnset sprintfk("pos(%d,%d)",(-100)+icnt*150, 317),	sprintfk("High_ident%d",icnt)		;
	chnset sprintfk("pos(%d,%d)",(-34)+icnt*150, 475),	sprintfk("Mute_ident%d",icnt)  		; Mute
	chnset sprintfk("pos(%d,%d)",(-130)+icnt*150, 475),	sprintfk("Solo_ident%d",icnt)  		; Solo 
	chnset sprintfk("pos(%d,%d)",(-100)+icnt*150, 395),	sprintfk("Pan_ident%d",icnt)  		; Pan
	chnset sprintfk("pos(%d,%d)",(-110)+icnt*150, 475),	sprintfk("Fader_ident%d",icnt)  	; Fader
	chnset sprintfk("pos(%d,%d)",(-130)+icnt*150, 395),	sprintfk("PrePost1_ident%d",icnt)	; Pre/Post 1
	chnset sprintfk("pos(%d,%d)",(-138)+icnt*150, 420),	sprintfk("Aux1_ident%d",icnt)  	 	; Aux Send 1
	chnset sprintfk("pos(%d,%d)",(-34)+icnt*150, 395),	sprintfk("PrePost2_ident%d",icnt)	; Pre/Post 2
	chnset sprintfk("pos(%d,%d)",(-42)+icnt*150, 420),	sprintfk("Aux2_ident%d",icnt)		; Aux Send 2

	iLoop		init 0																		; Position and colour master level indicator widgets
	iColumns	init 0																		;
	iColCnt		init 0																		;
	until iLoop = 14 do																		;
		iColCnt = 1+iLoop-(iColumns*7)														;
		chnset sprintfk("pos(%d, %d), colour:0(%d, %d, 0)", iColumns*34+1235, 278-iLoop%7*17, (iColCnt%7==0? 233 : (iColCnt%6==0? 255 : (iColCnt%5==0? 250 : 0))), (iColCnt%7==0? 0: (iColCnt%6==0? 120 : (iColCnt%5==0? 190 : 255)))), sprintfk("MasterInd_ident%d", iLoop+1) ;
		iLoop=iLoop+1																		;
		iColumns = (iLoop%7==0 ? iColumns+1 : iColumns)										;
	enduntil																				;

	iLoop2		init 0																		; Position and colour channel level indicator widgets
	iColumns2	init 0																		;
	iColCnt2	init 0																		;
	until iLoop2 = 56 do																	;
		iColCnt2 = 1+iLoop2-(iColumns2*7)													;
		chnset sprintfk("pos(%d, %d), colour:0(%d, %d, 0)", iColumns2*150+127, 75-iLoop2%7*8, (iColCnt2%7==0? 233 : (iColCnt2%6==0? 255 : (iColCnt2%5==0? 250 : 0))), (iColCnt2%7==0? 0: (iColCnt2%6==0? 120 : (iColCnt2%5==0? 190 : 255)))), sprintfk("ChannelInd_ident%d", iLoop2+1) ;
		iLoop2=iLoop2+1																		;
		iColumns2 = (iLoop2%7==0 ? iColumns2+1 : iColumns2)									;
	enduntil																				;

	if changed(kMultiSelect)==0 then														; Select input multitrack
		if changed(kAudio)==0 then															; on/off button
			if kAudio==1 then																;
				if kMultiSelect==1 then														;
					aSig diskin2 gS_MultiArray1[icnt-1], 1,0,1								; (First entry in array is gS_MultiArray1[0], so tracks are 0-7)
				elseif kMultiSelect==2 then													;
					aSig diskin2 gS_MultiArray2[icnt-1], 1,0,1								;
				elseif kMultiSelect==3 then													;
					aSig diskin2 gS_MultiArray3[icnt-1], 1,0,1								;
				endif																		;
			elseif kAudio==0 then															;
				aSig=0																		;
			endif																			;
		endif																				;
	endif																					;

	kTrim[icnt] port kTrim[icnt], 0.005														; Smooth input volume changes

	kChanMon  = 0
	kChanMoff = 1
	krmsChan	rms	aSig*kTrim[icnt]														; Channel Meter
	krmsChan	pow	krmsChan, 0.75															; (Thanks to Iain McCurdy's Envelope Follower code)
	krmsChan	ImAnOpcode	krmsChan, 0.01, 0.2												;
	#define	ChanInd(Chan'N)																	;
	#																						;
	kOnTrigChan		trigger	krmsChan, $Chan^1.5,0											;
	kOffTrigChan	trigger	krmsChan, $Chan^1.5,1											;
	if	kOnTrigChan==1 then																	;
 		chnset	kChanMon, sprintfk("ChannelInd%d", $N+(icnt-1)*7)							;
	elseif kOffTrigChan==1 then																;
 		chnset	kChanMoff, sprintfk("ChannelInd%d", $N+(icnt-1)*7)							;
	endif																					;
	if changed(kMultiSelect)==0 then														; Reset meters with new multitrack selection
		chnset 1, sprintfk("ChannelInd%d", $N+((icnt-1)*7))									;
	endif																					;
	#																						;
	$ChanInd(1/32'1)																		;
	$ChanInd(4/32'2)																		;
	$ChanInd(8/32'3)																		;
	$ChanInd(12/32'4)																		;
	$ChanInd(18/32'5)																		;
	$ChanInd(24/32'6)																		;
	$ChanInd(32/32'7)																		;

	if changed(kEQBypass[icnt])==0 then
		if kEQBypass[icnt]==0 then
			aSigPreFader = aSig * kTrim[icnt]												; Trim
		elseif kEQBypass[icnt]==1 then
			aFiltLow 		rbjeq aSig*kTrim[icnt],		120, 				kLow[icnt], 		0, 									1, 10		; Trim, Filters in series
			aFiltLowMid 	rbjeq aFiltLow, 			kLowMidFreq[icnt], 	kLowMidGain[icnt], 	kLowMidFreq[icnt]/kLowMidQ[icnt], 	1, 8		;
			aFiltMid 		rbjeq aFiltLowMid, 			kMidFreq[icnt], 	kMidGain[icnt], 	kMidFreq[icnt]/kMidQ[icnt], 		1, 8		;
			aFiltHiMid 		rbjeq aFiltMid, 			kHiMidFreq[icnt], 	kHiMidGain[icnt], 	kHiMidFreq[icnt]/kHiMidQ[icnt], 	1, 8		;
			aSigPreFader 	rbjeq aFiltHiMid, 			8000, 				kHigh[icnt], 		0, 									1, 12		;
		endif
	endif

	kSoloMod = ((kSolo[1]+kSolo[2]+kSolo[3]+kSolo[4]+kSolo[5]+kSolo[6]+kSolo[7]+kSolo[8]) <1 || kSolo[icnt]==1 ? 1:0)							; Solo modifier
	kFader[icnt] port kFader[icnt], 0.005													; Smooth volume changes	
	aSigPostFader = aSigPreFader * kFader[icnt] * kSoloMod * (1-kMute[icnt])				; Channel Fader, Solo, Mute

	kPan[icnt] port kPan[icnt], 0.005														; Channel Pan
	aSigPostPanL = aSigPostFader * (1-kPan[icnt])/2											;
	aSigPostPanR = aSigPostFader * (kPan[icnt]+1)/2											;
		
	aAux1=0
	aAux2=0
	if kPrePost1[icnt] ==0 then																; Pre/Post fader Aux sends
		aAux1		+= aSigPreFader * kAux1[icnt]											;
	elseif kPrePost1[icnt] ==1 then															;
		aAux1		+= aSigPostFader * kAux1[icnt]											;
	endif																					;
	if kPrePost2[icnt] ==0 then																;
		aAux2		+= aSigPreFader * kAux2[icnt]											;
	elseif kPrePost2[icnt] ==1 then															;
		aAux2		+= aSigPostFader * kAux2[icnt]											;
	endif																					;

	aAudioL, aAudioR mixer_jk icnt-1, kMultiSelect, kOutputSource, kTrim, kEQBypass, kLow, kLowMidFreq, kLowMidGain, kLowMidQ, kMidFreq, kMidGain, kMidQ, kHiMidFreq, kHiMidGain, kHiMidQ, kHigh, \
																				kMute, kSolo, kPan, kFader, kPrePost1, kAux1, kPrePost2, kAux2, kAux1Master, kAux2Master, kMasterFader, kAudio, kReset

	exitloop:
	if changed(kOutputSource)==0 then														; Output source selector
		if kOutputSource==1 then															;
			kMasterFader port kMasterFader, 0.005											;
			aFinalOutL = (aSigPostPanL + aAudioL) * kMasterFader							;
			aFinalOutR = (aSigPostPanR + aAudioR) * kMasterFader							;
		elseif kOutputSource==2 then														;
			kAux1Master port kAux1Master, 0.005												;
			aFinalOutL = (aAux1/2 + aAudioL) * kAux1Master									;
			aFinalOutR = (aAux1/2 + aAudioR) * kAux1Master									;
		elseif kOutputSource==3 then														;
			kAux2Master port kAux2Master, 0.005												;
			aFinalOutL = (aAux2 + aAudioL) * kAux2Master									;
			aFinalOutR = (aAux2 + aAudioR) * kAux2Master									;
		endif																				;
	endif																					;

	xout	aFinalOutL, aFinalOutR															; UDO outputs

endop																						; End of UDO
	
instr 1
kTrim[] 		init giChannels+1															; Initialise arrays to store widget values
kEQBypass[] 	init giChannels+1															;
kLow[] 			init giChannels+1															;
kLowMidFreq[] 	init giChannels+1															;
kLowMidGain[] 	init giChannels+1															;
kLowMidQ[] 		init giChannels+1															;
kMidFreq[] 		init giChannels+1															;
kMidGain[] 		init giChannels+1															;
kMidQ[]			init giChannels+1															;
kHiMidFreq[] 	init giChannels+1															;
kHiMidGain[] 	init giChannels+1															;
kHiMidQ[] 		init giChannels+1															;
kHigh[] 		init giChannels+1															;
kSolo[] 		init giChannels+1															;
kMute[] 		init giChannels+1															;
kPan[] 			init giChannels+1															;
kFader[] 		init giChannels+1															;
kPrePost1[] 	init giChannels+1															;
kAux1[] 		init giChannels+1															;
kPrePost2[] 	init giChannels+1															;
kAux2[] 		init giChannels+1															;
kMultiSelect	chnget "MultiSelect"														; Call in master controls
kOutputSource 	chnget "OutputSource"														;
kMasterFader 	chnget "MasterFader"														;
kAux1Master 	chnget "Aux1Master"															;
kAux2Master 	chnget "Aux2Master"															;
kAudio			chnget "Audio"																; Audio playback On/off button
kReset			chnget "Reset"																;

if changed(kMultiSelect)==1 then															; Restart multitrack on selection
	reinit RESTART																			;
endif   																					;
RESTART:																					;

kcnt = 1
loop:																						; Call in current widget values
	kTrim[kcnt] 		chnget sprintfk("Trim%d",kcnt)										;
	kEQBypass[kcnt] 	chnget sprintfk("EQBypass%d",kcnt)									;
	kLow[kcnt] 			chnget sprintfk("Low%d",kcnt)										;
	kLowMidFreq[kcnt] 	chnget sprintfk("LowMidFreq%d",kcnt)								;
	kLowMidGain[kcnt] 	chnget sprintfk("LowMidGain%d",kcnt)								;
	kLowMidQ[kcnt] 		chnget sprintfk("LowMidQ%d",kcnt)									;
	kMidFreq[kcnt] 		chnget sprintfk("MidFreq%d",kcnt)									;
	kMidGain[kcnt] 		chnget sprintfk("MidGain%d",kcnt)									;
	kMidQ[kcnt] 		chnget sprintfk("MidQ%d",kcnt)										;
	kHiMidFreq[kcnt] 	chnget sprintfk("HiMidFreq%d",kcnt)									;
	kHiMidGain[kcnt] 	chnget sprintfk("HiMidGain%d",kcnt)									;
	kHiMidQ[kcnt] 		chnget sprintfk("HiMidQ%d",kcnt)									;
	kHigh[kcnt] 		chnget sprintfk("High%d",kcnt)										;
	kSolo[kcnt] 		chnget sprintfk("Solo%d",kcnt)										;
	kMute[kcnt] 		chnget sprintfk("Mute%d",kcnt)										;
	kPan[kcnt] 			chnget sprintfk("Pan%d",kcnt)										;
	kFader[kcnt] 		chnget sprintfk("Fader%d",kcnt)										;
	kPrePost1[kcnt] 	chnget sprintfk("PrePost1%d",kcnt)									;
	kAux1[kcnt] 		chnget sprintfk("Aux1%d",kcnt)										;
	kPrePost2[kcnt] 	chnget sprintfk("PrePost2%d",kcnt)									;
	kAux2[kcnt] 		chnget sprintfk("Aux2%d",kcnt)										;
loop_lt kcnt,1,giChannels+1,loop															;

aAudioL, aAudioR mixer_jk giChannels, kMultiSelect, kOutputSource, kTrim, kEQBypass, kLow, kLowMidFreq, kLowMidGain, kLowMidQ, kMidFreq, kMidGain, kMidQ, kHiMidFreq, kHiMidGain, kHiMidQ, kHigh, \
																				kMute, kSolo, kPan, kFader, kPrePost1, kAux1, kPrePost2, kAux2, kAux1Master, kAux2Master, kMasterFader, kAudio, kReset
outs aAudioL, aAudioR																		; Audio outputs

kMasMon	 = 0
kMasMoff = 1

krmsMasL	rms	aAudioL																		; Left Master Meter
krmsMasL	pow	krmsMasL, 0.75																;
krmsMasL	ImAnOpcode	krmsMasL, 0.01, 0.2													;
#define	MasLInd(MasL'N)																		;
#																							;
kOnTrigMasL		trigger	krmsMasL, $MasL^1.5,0												;
kOffTrigMasL	trigger	krmsMasL, $MasL^1.5,1												;
if	kOnTrigMasL==1 then																		;
 	chnset	kMasMon, "MasterInd$N"															;
elseif kOffTrigMasL==1 then																	;
 	chnset	kMasMoff, "MasterInd$N"															;
endif																						;
if changed(kMultiSelect)==0 then															; Reset meters with new multitrack selection
	chnset 1, "MasterInd$N" 																;
endif																						;
#																							;
$MasLInd(1/32'1)																			;
$MasLInd(4/32'2)																			;
$MasLInd(8/32'3)																			;
$MasLInd(12/32'4)																			;
$MasLInd(18/32'5)																			;
$MasLInd(24/32'6)																			;
$MasLInd(32/32'7)																			;

krmsMasR	rms	aAudioR																		; Right Master Meter
krmsMasR	pow	krmsMasR, 0.75																;
krmsMasR	ImAnOpcode	krmsMasR, 0.01, 0.2													;
#define	MasRInd(MasR'N)																		;
#																							;
kOnTrigMasR		trigger	krmsMasR, $MasR^1.5,0												;
kOffTrigMasR	trigger	krmsMasR, $MasR^1.5,1												;
if	kOnTrigMasR==1 then																		;
 	chnset	kMasMon, "MasterInd$N"															;
elseif kOffTrigMasR==1 then																	;
 	chnset	kMasMoff, "MasterInd$N"															;
endif																						;
if changed(kMultiSelect)==0 then															; Reset meters with new multitrack selection
	chnset 1, "MasterInd$N" 																;
endif																						;
#																							;
$MasRInd(1/32'8)																			;
$MasRInd(4/32'9)																			;
$MasRInd(8/32'10)																			;
$MasRInd(12/32'11)																			;
$MasRInd(18/32'12)																			;
$MasRInd(24/32'13)																			;
$MasRInd(32/32'14)																			;

kCompare		chnget "Compare"
kStore			chnget "Store"
kTableReset		chnget "TableReset"
if kCompare+kStore+kTableReset>0 then														; Initiate table update
	event "i", 2, 0, .5,  	kTrim[1], kEQBypass[1], kLow[1], kLowMidFreq[1], kLowMidGain[1], kLowMidQ[1], kMidFreq[1], kMidGain[1], kMidQ[1], kHiMidFreq[1], kHiMidGain[1], kHiMidQ[1], kHigh[1], kMute[1], kSolo[1], kPan[1], kFader[1], kPrePost1[1], kAux1[1], kPrePost2[1], kAux2[1], \ ;Channel 1
							kTrim[2], kEQBypass[2], kLow[2], kLowMidFreq[2], kLowMidGain[2], kLowMidQ[2], kMidFreq[2], kMidGain[2], kMidQ[2], kHiMidFreq[2], kHiMidGain[2], kHiMidQ[2], kHigh[2], kMute[2], kSolo[2], kPan[2], kFader[2], kPrePost1[2], kAux1[2], kPrePost2[2], kAux2[2], \ ;Channel 2
	 						kTrim[3], kEQBypass[3], kLow[3], kLowMidFreq[3], kLowMidGain[3], kLowMidQ[3], kMidFreq[3], kMidGain[3], kMidQ[3], kHiMidFreq[3], kHiMidGain[3], kHiMidQ[3], kHigh[3], kMute[3], kSolo[3], kPan[3], kFader[3], kPrePost1[3], kAux1[3], kPrePost2[3], kAux2[3], \ ;Channel 3
	 						kTrim[4], kEQBypass[4], kLow[4], kLowMidFreq[4], kLowMidGain[4], kLowMidQ[4], kMidFreq[4], kMidGain[4], kMidQ[4], kHiMidFreq[4], kHiMidGain[4], kHiMidQ[4], kHigh[4], kMute[4], kSolo[4], kPan[4], kFader[4], kPrePost1[4], kAux1[4], kPrePost2[4], kAux2[4], \ ;Channel 4
	 						kTrim[5], kEQBypass[5], kLow[5], kLowMidFreq[5], kLowMidGain[5], kLowMidQ[5], kMidFreq[5], kMidGain[5], kMidQ[5], kHiMidFreq[5], kHiMidGain[5], kHiMidQ[5], kHigh[5], kMute[5], kSolo[5], kPan[5], kFader[5], kPrePost1[5], kAux1[5], kPrePost2[5], kAux2[5], \ ;Channel 5
	 						kTrim[6], kEQBypass[6], kLow[6], kLowMidFreq[6], kLowMidGain[6], kLowMidQ[6], kMidFreq[6], kMidGain[6], kMidQ[6], kHiMidFreq[6], kHiMidGain[6], kHiMidQ[6], kHigh[6], kMute[6], kSolo[6], kPan[6], kFader[6], kPrePost1[6], kAux1[6], kPrePost2[6], kAux2[6], \ ;Channel 6
	 						kTrim[7], kEQBypass[7], kLow[7], kLowMidFreq[7], kLowMidGain[7], kLowMidQ[7], kMidFreq[7], kMidGain[7], kMidQ[7], kHiMidFreq[7], kHiMidGain[7], kHiMidQ[7], kHigh[7], kMute[7], kSolo[7], kPan[7], kFader[7], kPrePost1[7], kAux1[7], kPrePost2[7], kAux2[7], \ ;Channel 7
							kTrim[8], kEQBypass[8], kLow[8], kLowMidFreq[8], kLowMidGain[8], kLowMidQ[8], kMidFreq[8], kMidGain[8], kMidQ[8], kHiMidFreq[8], kHiMidGain[8], kHiMidQ[8], kHigh[8], kMute[8], kSolo[8], kPan[8], kFader[8], kPrePost1[8], kAux1[8], kPrePost2[8], kAux2[8]	;Channel 8
endif

kHide chnget "Hide"																			; Show/hide features
chnset sprintfk("size(94, %d)", kHide*62+40), "boxident"									;
chnset sprintfk("visible(%d)", kHide), "adminident"											;
endin

instr 2																						; Update table
iTableL	ftgen 1, 0, 256, -2,	p4,   p5,   p6,   p7,   p8,   p9,   p10,  p11,  p12,  p13,  p14,  p15,  p16,  p17,  p18,  p19,  p20,  p21,  p22,  p23,  p24,  \	; Channel 1
	 							p25,  p26,  p27,  p28,  p29,  p30,  p31,  p32,  p33,  p34,  p35,  p36,  p37,  p38,  p39,  p40,  p41,  p42,  p43,  p44,  p45,  \	; Channel 2
	 							p46,  p47,  p48,  p49,  p50,  p51,  p52,  p53,  p54,  p55,  p56,  p57,  p58,  p59,  p60,  p61,  p62,  p63,  p64,  p65,  p66,  \	; Channel 3
	 							p67,  p68,  p69,  p70,  p71,  p72,  p73,  p74,  p75,  p76,  p77,  p78,  p79,  p80,  p81,  p82,  p83,  p84,  p85,  p86,  p87,  \	; Channel 4
	 							p88,  p89,  p90,  p91,  p92,  p93,  p94,  p95,  p96,  p97,  p98,  p99,  p100, p101, p102, p103, p104, p105, p106, p107, p108, \	; Channel 5
	 							p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, \	; Channel 6
	 							p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149, p150, \	; Channel 7
	 							p151, p152, p153, p154, p155, p156, p157, p158, p159, p160, p161, p162, p163, p164, p165, p166, p167, p168, p169, p170, p171	; Channel 8

kStore			chnget "Store"
if changed(kStore)==1 then
	vcopy	2, 1, 256																		; Store current widget positions to table 2
endif

kTableReset		chnget "TableReset"
if changed(kTableReset)==1 then
	vcopy	2, 4, 256																		; Restore default widget positions to table 2
endif

chnset	"tablenumber(1,2)", "tableident"													; Update table displays (this line can only appear once per gentable widget)
vcopy	3, 1, 256																			; Copies widget position table into table 3
vsubv	3, 2, 256,0,0,0																		; Subtracts values of table 2 from table 3 and overwrites table 3
chnset	"tablenumber(3)", "tableident2"														; Displays new values of table 3
endin
</CsInstruments>
<CsScore> 
f0 z
f1 0 256 -2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  	/* <Channel 1	*/ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 2		; Initial widget table, overwritten by instrument 2 when "Compare" is pressed (Blue)
		 */ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 3	*/ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 4		;
		 */ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 5	*/ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 6		;
		 */ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	/* <Channel 7	*/ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1	;  <Channel 8		;
f2 0 256 -2 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0 /*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		; Customizable preset ideal example table (Green)
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		;
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		;
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	   		;
f3 0 256 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  	/* 				*/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/* 			   		; Initial table to be overwritten by comparative table (Red)
		 */ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/*				*/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/* 			   		;
		 */ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/*				*/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/* 			   		;
		 */ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	/*				*/ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	   			   		;
f4 0 256 -2 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0 /*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		; Default widget position for reset
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		;
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*		;
		 */ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	/*	*/ 1 1 1 440 1 2.5 2400 1 2.5 6000 1 2.5 1 0 0 0 1 0 0 1 0	   		;
i1 0 [3600*24*7]
</CsScore>
</CsoundSynthesizer>