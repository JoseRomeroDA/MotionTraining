ACTION AxisCtrlStatusAction:
	
	FOR i:=1 TO MAX_AXIS DO
	
		AxisSequence.status.Active[i]			:= MpAxisBasic_0[i].Active;
		AxisSequence.status.CommandAborted[i]	:= MpAxisBasic_0[i].CommandAborted;
		AxisSequence.status.CommandBusy[i]		:= MpAxisBasic_0[i].CommandBusy;
		AxisSequence.status.Error[i]			:= MpAxisBasic_0[i].Error;
		AxisSequence.status.InPosition[i]		:= MpAxisBasic_0[i].InPosition;
		AxisSequence.status.InVelocity[i]		:= MpAxisBasic_0[i].InVelocity;
		AxisSequence.status.IsHomed[i]			:= MpAxisBasic_0[i].IsHomed;
		AxisSequence.status.MoveActive[i]		:= MpAxisBasic_0[i].MoveActive;
		AxisSequence.status.MoveDone[i]			:= MpAxisBasic_0[i].MoveDone;
		AxisSequence.status.Position[i]			:= MpAxisBasic_0[i].Position;
		AxisSequence.status.PowerOn[i]			:= MpAxisBasic_0[i].PowerOn;
		AxisSequence.status.StatusID[i]			:= MpAxisBasic_0[i].StatusID;
		AxisSequence.status.UpdateDone[i]		:= MpAxisBasic_0[i].UpdateDone;
		AxisSequence.status.Velocity[i]			:= MpAxisBasic_0[i].Velocity;
		AxisSequence.status.Info[i]				:= MpAxisBasic_0[i].Info;
									
	END_FOR;
	
END_ACTION