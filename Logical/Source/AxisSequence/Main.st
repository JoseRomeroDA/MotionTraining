
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	/////////// PHYSICAL INPUTS ///////////
	AxisSequence.status.PowerMotors		:= AxisSequence.io.di_PowerMotors;	
	AxisSequence.status.StartSequence	:= AxisSequence.io.di_StartSequence;
	AxisSequence.status.StopSequence	:= AxisSequence.io.di_StopSequence;
	
	
	 
	//Timer poweroff condition
	TON_TurnOffMotors.PT	:= T#2s;
	
	IF (AxisSequence.status.StopSequence)  THEN
		TON_TurnOffMotors.IN	:= TRUE;
	ELSE 
		TON_TurnOffMotors.IN := FALSE;
	END_IF;
	
	
	
	FOR i:= 1 TO MAX_AXIS DO 
		
		IF AxisSequence.state <> (STEP_8) THEN
			AxisSequence.parameters[i].Distance		:= 180;
			AxisSequence.parameters[i].Velocity		:= 1000;
			AxisSequence.parameters[i].Acceleration := 7200;
			AxisSequence.parameters[i].Deceleration := 7200;
		ELSIF AxisSequence.state = (STEP_8) THEN
			AxisSequence.parameters[i].Distance		:= -540;
			AxisSequence.parameters[i].Velocity		:= 1500;
			AxisSequence.parameters[i].Acceleration := 7200;
			AxisSequence.parameters[i].Deceleration := 7200;
		END_IF;
		
		//PowerOn condition
		IF EDGEPOS(AxisSequence.status.PowerMotors)  THEN
			AxisSequence.cmd.Power[i]	:= TRUE;	
		END_IF;

		//Stop condition
		IF AxisSequence.status.StopSequence THEN
			AxisSequence.cmd.Home[i]			:= FALSE;
			AxisSequence.cmd.MoveAbsolute[i]	:= FALSE;
			AxisSequence.cmd.MoveAdditive[i]	:= FALSE;
			AxisSequence.cmd.MoveVelocity[i]	:= FALSE;
			AxisSequence.cmd.Stop[i]			:= TRUE;
		ELSE
			AxisSequence.cmd.Stop[i] := FALSE;
		END_IF;
	
		//PowerOff condition 
		IF TON_TurnOffMotors.Q  	THEN
			AxisSequence.cmd.Power[i]			:= FALSE;
			AxisSequence.cmd.Home[i]			:= FALSE;
			AxisSequence.cmd.MoveAbsolute[i]	:= FALSE;
			AxisSequence.cmd.MoveAdditive[i]	:= FALSE;
			AxisSequence.cmd.MoveVelocity[i]	:= FALSE;
			AxisSequence.cmd.Stop[i]			:= TRUE;						
			AxisSequence.state	 				:= WAIT;
		END_IF;


		//Error condition	
		IF AxisSequence.status.Error[i] THEN
			AxisSequence.state	:= ERROR; 
		END_IF;

	
	
	
		CASE AxisSequence.state OF
	
			WAIT:
						
				IF	AxisSequence.cmd.Power[i] AND AxisSequence.status.PowerOn[i] THEN
					AxisSequence.state	:= STEP_1; 
				END_IF;
			  
			STEP_1: 
		
				IF	EDGEPOS(AxisSequence.status.StartSequence) THEN
				//	AxisSequence.cmd.MoveAbsolute[i]			:= TRUE;
					AxisSequence.cmd.Home[i]					:= TRUE;
				END_IF;
				
				IF (*(AxisSequence.status.InPosition[1]) AND (AxisSequence.status.MoveDone[1]) AND
				   (AxisSequence.status.InPosition[2]) AND (AxisSequence.status.MoveDone[2]) THEN *)
					(AxisSequence.status.IsHomed[1] AND AxisSequence.status.IsHomed[2]) THEN
					
					AxisSequence.cmd.Home[i]					:= FALSE;	
					AxisSequence.cmd.MoveAdditive[1]			:= TRUE;
						
				END_IF;
					
				
				IF AxisSequence.status.InPosition[1] AND (AxisSequence.status.MoveDone[1]) THEN
					//AutoSequence.cmd.homeMode		:= mcHOME_DEFAULT;
					AxisSequence.cmd.MoveAdditive[1]	:= FALSE;
					//AutoSequence.cmd.home			:= FALSE;
					AxisSequence.state					:= STEP_2;
				END_IF;
				
				
			
			STEP_2: //+180° Axis 2
					
					AxisSequence.cmd.MoveAdditive[2] := TRUE;
					
					IF AxisSequence.status.InPosition[2] AND (AxisSequence.status.MoveDone[2]) THEN
						AxisSequence.cmd.MoveAdditive[2]	:= FALSE;
						AxisSequence.state					:= STEP_3;
					END_IF;
		
					
					
			STEP_3: //+180 Axis 1
					AxisSequence.cmd.MoveAdditive[1] := TRUE;
					
					IF AxisSequence.status.InPosition[1] AND (AxisSequence.status.MoveDone[1]) THEN
						AxisSequence.cmd.MoveAdditive[1]	:= FALSE;
						AxisSequence.state					:= STEP_4;
					END_IF;
			
			STEP_4: //+180 Axis 2
	
					AxisSequence.cmd.MoveAdditive[2] := TRUE;
					
					IF AxisSequence.status.InPosition[2] AND (AxisSequence.status.MoveDone[2]) THEN
						AxisSequence.cmd.MoveAdditive[2]	:= FALSE;
						AxisSequence.state					:= STEP_5;
					END_IF;
		
					
			STEP_5:	//+180 Axis 1
				
					AxisSequence.cmd.MoveAdditive[1] := TRUE;
					
					IF AxisSequence.status.InPosition[1] AND (AxisSequence.status.MoveDone[1]) THEN
						AxisSequence.cmd.MoveAdditive[1]	:= FALSE;
						AxisSequence.state					:= STEP_6;
					END_IF;
				
			STEP_6: //+180 Axis 2
					
					AxisSequence.cmd.MoveAdditive[2] := TRUE;
					
					IF AxisSequence.status.InPosition[2] AND (AxisSequence.status.MoveDone[2]) THEN
						AxisSequence.cmd.MoveAdditive[2]	:= FALSE;
						AxisSequence.state					:= STEP_7;
					END_IF;
		
					
			STEP_7: //+180 Axis 1
				
					AxisSequence.cmd.MoveAdditive[2] := TRUE;
					
					IF AxisSequence.status.InPosition[2] AND (AxisSequence.status.MoveDone[2]) THEN
						AxisSequence.cmd.MoveAdditive[2]	:= FALSE;
						AxisSequence.state					:= STEP_8;
					END_IF;
			
			STEP_8: 
		
					AxisSequence.cmd.MoveAdditive[i] := TRUE;
					
					IF AxisSequence.status.InPosition[1] AND AxisSequence.status.InPosition[2] THEN	
						AxisSequence.cmd.MoveAdditive[2]	:= FALSE;
						AxisSequence.state					:= STEP_8;
					END_IF;	
				
				
			ERROR:
					
				AxisSequence.cmd.MoveAdditive[i]	:= FALSE;
				IF NOT(AxisSequence.status.Error[1]) AND NOT(AxisSequence.status.Error[1])THEN
						AxisSequence.state	:= WAIT;	
				END_IF;
	
				
			END_CASE;
		
	END_FOR;
	
	//Call Functions blocks
	TON_TurnOffMotors();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM


