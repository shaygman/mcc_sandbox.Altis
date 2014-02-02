#define MCC_CLTEXT 2001
disableSerialization;
private ["_type", "_string", "_command"];

if (mcc_missionmaker == (name player)) then {
	_type = _this select 0;
	_string = ctrlText MCC_CLTEXT;
	
	switch (_type) do
	{
	   case 0:	//Local
		{ 
			call (compile _string); 
		};
		
	   case 1:	//Global
		{ 
			[[2,compile _string], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		};
		
		case 2: // mcc load
		{
			_command = 'mcc_isloading=true;' + _string + 'mcc_isloading=false;'; 
			[] spawn compile _command;
		};
	};
} else {player globalchat "Access Denied"};