
ACTION TapSequencerAction: 
//no detecta botellas
	
	EnableSequence	:= FALSE;
	
	
	CamAutomatParam.State[0].CamID						:= 16#FFFF;
	CamAutomatParam.State[0].Event[0].Type				:= mcEVENT_STATE_END;
	CamAutomatParam.State[0].Event[0].Transition		:= mcEVENT_IMMEDIATELY;
	CamAutomatParam.State[0].Event[0].NextState			:= 1;
	
	
	CamAutomatParam.State[1].CamID										:= 16#FFFF;
	CamAutomatParam.State[1].MasterFactor								:= 600;
	CamAutomatParam.State[1].SlaveFactor								:= 0;
	CamAutomatParam.State[1].CompensationMode							:= mcCOMP_OFF;
	CamAutomatParam.State[1].CompensationParameters.MasterCompDistance	:= 0;
	CamAutomatParam.State[1].CompensationParameters.SlaveCompDistance	:= 0;
	CamAutomatParam.State[1].Event[0].Type				:= mcEVENT_SIGNAL1;
	CamAutomatParam.State[1].Event[0].Transition		:= mcEVENT_END_OF_STATE;
	CamAutomatParam.State[1].Event[0].NextState			:= 2;
	
	
	CamAutomatParam.State[1].Event[1].Type				:= mcEVENT_STATE_END;
	CamAutomatParam.State[1].Event[1].Transition		:= mcEVENT_IMMEDIATELY;
	CamAutomatParam.State[1].Event[1].NextState			:= 1;


	
	CamAutomatParam.State[2].CamID										:= 16#FFFE;
	CamAutomatParam.State[2].MasterFactor								:= 1;
	CamAutomatParam.State[2].SlaveFactor								:= 1;
	CamAutomatParam.State[2].CompensationMode							:= mcCOMP_BETWEEN_CAMS;
	CamAutomatParam.State[2].CompensationParameters.MasterCompDistance	:= 20;
	CamAutomatParam.State[2].CompensationParameters.SlaveCompDistance	:= 170;
	CamAutomatParam.State[2].Event[0].Type				:= mcEVENT_STATE_END;
	CamAutomatParam.State[2].Event[0].Transition		:= mcEVENT_END_OF_STATE;
	CamAutomatParam.State[2].Event[0].NextState			:= 3;
	
	
	CamAutomatParam.State[3].CamID										:= 16#FFFF;
	CamAutomatParam.State[3].MasterFactor								:= 400;
	CamAutomatParam.State[3].SlaveFactor								:= 100;
	CamAutomatParam.State[3].CompensationMode							:= mcCOMP_OFF;
	CamAutomatParam.State[3].CompensationParameters.MasterCompDistance	:= 0;
	CamAutomatParam.State[3].CompensationParameters.SlaveCompDistance	:= 0;
	CamAutomatParam.State[3].Event[0].Type					:= mcEVENT_STATE_END;
	CamAutomatParam.State[3].Event[0].Transition			:= mcEVENT_END_OF_STATE;
	CamAutomatParam.State[3].Event[0].NextState				:= 4;
	
	CamAutomatParam.State[4].CamID										:= 16#FFFE;
	CamAutomatParam.State[4].MasterFactor								:= 1;
	CamAutomatParam.State[4].SlaveFactor								:= 1;
	CamAutomatParam.State[4].CompensationMode							:= mcCOMP_BETWEEN_CAMS;
	CamAutomatParam.State[4].CompensationParameters.MasterCompDistance	:= 20;
	CamAutomatParam.State[4].CompensationParameters.SlaveCompDistance	:= 180;
	CamAutomatParam.State[4].Event[0].Type					:= mcEVENT_STATE_END;
	CamAutomatParam.State[4].Event[0].Transition			:= mcEVENT_END_OF_STATE;
	CamAutomatParam.State[4].Event[0].NextState				:= 1;	
	CamAutomatParam.State[4].Event[1].Type					:= mcEVENT_SIGNAL1;
	CamAutomatParam.State[4].Event[1].Transition			:= mcEVENT_END_OF_STATE;
	CamAutomatParam.State[4].Event[1].NextState				:= 2;	

END_ACTION
