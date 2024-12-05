
ACTION LedSequenceAction: 

	FOR i:= 1 TO 3 DO	
		IF AutoSequence.status.doErrorActive THEN
			AutoSequence.io.do_LedBlue		:= FALSE;
			AutoSequence.io.do_LedGreen[i]	:= FALSE;
			AutoSequence.io.do_LedWhite[i]	:= FALSE;
			AutoSequence.io.do_LedYellow[i]	:= FALSE;
			
			PWM_Active.Enable					:= TRUE;
			PWM_Active.Period					:= 2;
			PWM_Active.DutyCycle				:= 50;
			AutoSequence.io.do_LedRed[i]		:= PWM_Active.Out;
		ELSE 
			AutoSequence.io.do_LedRed[i]		:= FALSE;
			PWM_Active.Enable					:= FALSE;
		END_IF;	
		
		
		IF AutoSequence.cmd.AutoSequenceDisabled AND CountManualSequence <> 3 THEN
		
			AutoSequence.io.do_LedBlue		:= FALSE;
			AutoSequence.io.do_LedGreen[i]	:= FALSE;
			AutoSequence.io.do_LedWhite[i]	:= FALSE;
			AutoSequence.io.do_LedRed[i]	:= FALSE;
			
			PWM_Active.Enable					:= TRUE;
			PWM_Active.Period					:= 2;
			PWM_Active.DutyCycle				:= 50;
			AutoSequence.io.do_LedYellow[i]		:= PWM_Active.Out;
			IF EDGEPOS (PWM_Active.Out) THEN
				CountManualSequence := CountManualSequence + 1;
			END_IF;
		ELSIF AutoSequence.cmd.AutoSequenceDisabled AND (CountManualSequence >= 3) THEN
			PWM_Active.Enable					:= FALSE;
			AutoSequence.io.do_LedYellow[i]		:= TRUE;
		ELSIF NOT(AutoSequence.cmd.AutoSequenceDisabled) AND NOT(AutoSequence.status.doErrorActive) THEN
			AutoSequence.io.do_LedBlue			:= FALSE;
			AutoSequence.io.do_LedGreen[i]		:= FALSE;
			AutoSequence.io.do_LedRed[i]		:= FALSE;
			PWM_Active.Enable					:= FALSE;
			AutoSequence.io.do_LedYellow[i]		:= FALSE;
			CountManualSequence					:= 0;
		END_IF;
		
		
	END_FOR;
	
	IF NOT (AutoSequence.status.doErrorActive) AND NOT(AutoSequence.cmd.AutoSequenceDisabled) THEN
		
		IF AutoSequence.status.doPowerMotorsOff	 OR (AutoSequence.state = WAIT) THEN
			AutoSequence.io.do_LedGreen[1]	:= FALSE;
			AutoSequence.io.do_LedWhite[1]	:= TRUE;
		ELSIF AutoSequence.status.doPowerMotorsON THEN
			AutoSequence.io.do_LedGreen[1]	:= TRUE;
			AutoSequence.io.do_LedWhite[1]	:= FALSE;
		END_IF
			
		IF AutoSequence.status.doStartCycleInactive OR (AutoSequence.state = WAIT) THEN
			AutoSequence.io.do_LedWhite[2]	:= TRUE;
			AutoSequence.io.do_LedGreen[2]	:= FALSE;
		ELSIF	AutoSequence.status.doStartCycleActive THEN	
			AutoSequence.io.do_LedWhite[2]	:= FALSE;
			AutoSequence.io.do_LedGreen[2]	:= TRUE;
		END_IF;
		
		IF AutoSequence.status.doStopCycleActive THEN
		(*	AutoSequence.io.do_LedGreen[3] 	:= FALSE;*)
			AutoSequence.io.do_LedBlue		:= TRUE;
		ELSE 
		(*	AutoSequence.io.do_LedGreen[3] 	:= TRUE;*)
			AutoSequence.io.do_LedBlue		:= FALSE;
		END_IF;
	END_IF;
	
	
END_ACTION
