
PROGRAM _INIT
	(* INIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		
		MpAxisBasic_0[i].Enable	:= TRUE;
		
		AxisSequence.parameters[i].Position		:= 100;
		AxisSequence.parameters[i].Velocity		:= 10.0;
		AxisSequence.parameters[i].Acceleration	:= 50.0;
		AxisSequence.parameters[i].Deceleration	:= 50.0;
	
	END_FOR;
	(* CYCLIC AXIS *)
	MpAxisBasic_0[1].MpLink		:= ADR(gAxis_1);
	MpAxisBasic_0[1].Parameters	:= ADR(AxisSequence.parameters[1]);
	MpAxisBasic_0[1]();

	MpAxisBasic_0[2].MpLink		:= ADR(gAxis_2);
	MpAxisBasic_0[2].Parameters	:= ADR(AxisSequence.parameters[2]);
	MpAxisBasic_0[2]();	
	
//	AxisSequence.couplingParam.Gear.RatioDenominator 	:= 3600;
//	AxisSequence.couplingParam.Gear.RatioNumerator		:= -3600;
//	MpAxisCoupling_0.MpLinkMaster	:= ADR(gAxis_1);
//	MpAxisCoupling_0.MpLink 		:= ADR(gAxis_2);
//	MpAxisCoupling_0.Parameters		:= ADR(AxisSequence.couplingParam);
	//	MpAxisCoupling_0.Enable			:= TRUE;
	
	
	MpAxisCamSequencer_0.MpLinkMaster 	:= ADR(gAxis_1);
	MpAxisCamSequencer_0.MpLink			:= ADR(gAxis_2);
	MpAxisCamSequencer_0.Parameters		:= ADR(CamSequencerParam);
	MpAxisCamSequencer_0.Enable 		:= TRUE;
	CamSequencerParam.CamSequence.Data.DataAddress	:= ADR (CamAutomatParam);
	MpAxisCamSequencer_0();
	
END_PROGRAM

PROGRAM _CYCLIC
	MpAxisCamSequencer_0.Signal1		:= AxisSequence.io.di_PowerMotors;
	IF EnableSequence THEN
		TapSequencerAction;
	END_IF;

	MpAxisBasic_0[1]();
	MpAxisBasic_0[2]();
	
	MpAxisCamSequencer_0();
	//MpAxisCoupling_0();
	(* Axis actions *)
	//AxisCtrlCmdAction;
	
	
//	/////////// PHYSICAL INPUTS ///////////
//	AxisSequence.status.PowerMotors		:= AxisSequence.io.di_PowerMotors;	
//	AxisSequence.status.StartSequence	:= AxisSequence.io.di_StartSequence;
//	AxisSequence.status.StopSequence	:= AxisSequence.io.di_StopSequence;
//	
//	
//	 
//	//Timer poweroff condition
//	TON_TurnOffMotors.PT	:= T#2s;
//	
//	IF (AxisSequence.status.StopSequence)  THEN
//		TON_TurnOffMotors.IN	:= TRUE;
//	ELSE 
//		TON_TurnOffMotors.IN := FALSE;
//	END_IF;
//	
//	
//	
//	FOR i:= 1 TO MAX_AXIS DO 
//		
//		IF (AxisSequence.state <> STEP_4) AND NOT (AxisSequence.state = STEP_1) THEN
//			AxisSequence.parameters[i].Distance		:= 180;
//			AxisSequence.parameters[i].Velocity		:= 100;
//			AxisSequence.parameters[i].Acceleration := 1000;
//			AxisSequence.parameters[i].Deceleration := 1000;
//			AxisSequence.parameters[i].Direction := mcDIR_POSITIVE;
//		ELSIF (AxisSequence.state = STEP_4) THEN
//			AxisSequence.parameters[i].Distance		:= -540;
//			AxisSequence.parameters[i].Velocity		:= 100;
//			AxisSequence.parameters[i].Acceleration := 1000;
//			AxisSequence.parameters[i].Deceleration := 1000;
//			AxisSequence.parameters[i].Direction 	:= mcDIR_NEGATIVE;
//		
//		END_IF;
//		
//		//PowerOn condition
//		IF EDGEPOS(AxisSequence.status.PowerMotors)  THEN
//			MpAxisBasic_0[1].Power	:= TRUE;	
//			MpAxisBasic_0[2].Power	:= TRUE;	
//		END_IF;
//
//		//Stop condition
//		IF AxisSequence.status.StopSequence OR ResetSequence THEN
//			MpAxisBasic_0[i].Home			:= FALSE;
//			MpAxisBasic_0[i].MoveAbsolute	:= FALSE;
//			MpAxisBasic_0[i].MoveAdditive	:= FALSE;
//			MpAxisBasic_0[i].MoveVelocity	:= FALSE;
//			ResetSequence	:= FALSE;
//			//MpAxisBasic_0[i].Stop			:= TRUE;
//			AxisSequence.state	 			:= STEP_1;
//		ELSE
//			//MpAxisBasic_0[i].Stop 		:= FALSE;
//			MpAxisBasic_0[i].ErrorReset	:= FALSE;
//		END_IF;
//	
//		//PowerOff condition 
//		IF TON_TurnOffMotors.Q  	THEN
//			MpAxisBasic_0[i].Power			:= FALSE;
//			MpAxisBasic_0[i].Home			:= FALSE;
//			MpAxisBasic_0[i].MoveAbsolute	:= FALSE;
//			MpAxisBasic_0[i].MoveAdditive	:= FALSE;
//			MpAxisBasic_0[i].MoveVelocity	:= FALSE;
//			MpAxisBasic_0[i].Stop			:= TRUE;
//			MpAxisBasic_0[i].ErrorReset		:= TRUE;
//			ResetSequence	:= FALSE;
//			AxisSequence.state	 			:= WAIT;
//		END_IF;
//
//
//		//Error condition	
//		IF 	MpAxisBasic_0[i].Error THEN
//			AxisSequence.state	:= ERROR; 
//		END_IF;
//
//	
//	
//	
//		CASE AxisSequence.state OF
//	
//			DISABLED:
//				
//				IF 	MpAxisBasic_0[1].Info.ReadyToPowerOn AND (MpAxisBasic_0[2].Info.ReadyToPowerOn) THEN
//					AxisSequence.state	:= WAIT;
//				ELSE 
//					
//				END_IF;
//				
//			WAIT:
//				
//				MpAxisBasic_0[i].Stop:= FALSE;
//						
//				IF	MpAxisBasic_0[i].Power AND MpAxisBasic_0[i].PowerOn THEN
//					AxisSequence.state	:= STEP_1; 
//				END_IF;
//			  
//			STEP_1: 
//				
//			
//						
//				IF (AxisSequence.status.StartSequence) AND (OldStartSequence <> AxisSequence.status.StartSequence) THEN 
//					AxisSequence.parameters[1].Homing.Position 	:= 30;
//					AxisSequence.parameters[2].Homing.Position	:= 200;
//					AxisSequence.parameters[1].Homing.Mode 	:= mcHOMING_DIRECT ;
//					AxisSequence.parameters[2].Homing.Mode 	:= mcHOMING_DIRECT ;
//					MpAxisBasic_0[1].Home	:= TRUE;
//					MpAxisBasic_0[2].Home	:= TRUE;
//					PermissionToHome		:= TRUE;
//				END_IF;
//				
//				IF (MpAxisBasic_0[1].IsHomed AND MpAxisBasic_0[2].IsHomed) AND (MpAxisBasic_0[1].Position = 30)
//					AND MpAxisBasic_0[2].Position = 200 AND PermissionToHome AND (CountSequence = 0) THEN
//					
//					MpAxisBasic_0[1].Home	:= FALSE;	
//					MpAxisBasic_0[2].Home	:= FALSE;
//					PermissionToHome		:= FALSE;
//					PermissionToStart		:= TRUE;
//	
//				END_IF;
//				
//				IF PermissionToStart THEN	
//					AxisSequence.parameters[1].Position	:= 0;
//					AxisSequence.parameters[2].Position	:= 0;
//					AxisSequence.parameters[1].Direction := mcDIR_SHORTEST_WAY;
//					AxisSequence.parameters[2].Direction := mcDIR_SHORTEST_WAY;
//					
//					MpAxisBasic_0[1].MoveAbsolute	:= TRUE;
//					MpAxisBasic_0[2].MoveAbsolute	:= TRUE;
//				END_IF;	
//				
//				IF MpAxisBasic_0[1].InPosition AND MpAxisBasic_0[1].MoveDone THEN
//					MpAxisBasic_0[1].MoveAbsolute	:= FALSE;
//					FinishSequence[1]				:= TRUE;
//				END_IF;	
//
//				IF MpAxisBasic_0[2].InPosition AND MpAxisBasic_0[2].MoveDone THEN
//					MpAxisBasic_0[2].MoveAbsolute	:= FALSE;
//					FinishSequence[2]				:= TRUE;		
//				END_IF;
//			
//				IF FinishSequence[1] AND FinishSequence[2] THEN
//					FinishSequence[1]		:= FALSE;
//					FinishSequence[2]		:= FALSE;
//					PermissionToStart		:= FALSE;
//					CountSequence			:= 1;
//					AxisSequence.state		:= STEP_2;
//				END_IF;
//							
//			STEP_2: //+180° Axis 1
//				
//				IF (CountSequence <7) THEN 
//					MpAxisBasic_0[1].MoveAdditive	:= TRUE;	
//					IF MpAxisBasic_0[1].InPosition AND (MpAxisBasic_0[1].MoveDone) THEN
//						MpAxisBasic_0[1].MoveAdditive	:= FALSE;
//						CountSequence 					:= CountSequence + 1;
//						AxisSequence.state				:= STEP_3;
//					END_IF;
//				END_IF;
//		
//				IF (CountSequence = 7) THEN
//					AxisSequence.state	:= STEP_4;
//				END_IF;
//					
//			STEP_3: //+180 Axis 2
//				
//				IF (CountSequence <7) THEN
//					MpAxisBasic_0[2].MoveAdditive := TRUE;	
//					IF MpAxisBasic_0[2].InPosition AND (MpAxisBasic_0[2].MoveDone) THEN
//						MpAxisBasic_0[2].MoveAdditive	:= FALSE;
//						CountSequence 					:= CountSequence + 1;
//						AxisSequence.state				:= STEP_2;
//					END_IF;
//				END_IF;
//				
//			STEP_4: 
//				
//				MpAxisBasic_0[i].MoveAdditive := TRUE;
//
//				IF MpAxisBasic_0[1].InPosition AND MpAxisBasic_0[1].MoveDone THEN
//					MpAxisBasic_0[1].MoveAdditive	:= FALSE;
//					FinishSequence[1]				:= TRUE;
//				END_IF;	
//	
//				IF MpAxisBasic_0[2].InPosition AND MpAxisBasic_0[2].MoveDone THEN
//					MpAxisBasic_0[2].MoveAdditive	:= FALSE;
//					FinishSequence[2]				:= TRUE;		
//				END_IF;
//				
//				IF FinishSequence[1] AND FinishSequence[2] THEN
//					FinishSequence[1]		:= FALSE;
//					FinishSequence[2]		:= FALSE;
//					ResetSequence			:= TRUE;
//					CountSequence			:= 0;
//					AxisSequence.state		:= STEP_1;
//				END_IF;
//				
//				
//			ERROR:
//					
//				MpAxisBasic_0[i].MoveAdditive	:= FALSE;
//				IF NOT(MpAxisBasic_0[1].Error) AND NOT(MpAxisBasic_0[2].Error)THEN
//					AxisSequence.state	:= WAIT;	
//				END_IF;
//	
//				
//		END_CASE;
//		
//		
//		MpAxisBasic_0[i]();
//	END_FOR;
//	
//	
//	//Old variables
//	OldStartSequence := AxisSequence.status.StartSequence;
//	
//	//Call Functions blocks
//	//AxisCtrlStatusAction;
//	TON_TurnOffMotors();
//

	

END_PROGRAM

PROGRAM _EXIT
	
	(* EXIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		MpAxisBasic_0[i].Enable	:= FALSE;
	END_FOR;
	
END_PROGRAM

