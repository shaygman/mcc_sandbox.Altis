disableSerialization;
private ["_type", "_string", "_command","_str"];

if (mcc_missionmaker == (name player)) then {
	_type = _this select 0;
	_string = ctrlText ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 24);

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

		case 3: // BroadCast text - small
		{
			_command = format ['titleText ["%1","PLAIN DOWN"]; titleFadeOut 60;',_string];
			[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		};

		case 4: // BroadCast text - Big
		{
			_str = "<t size='1' t font = 'puristaLight' color='#FFFFFF'>" + _string + "</t>";
			_command = format ['["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_str];
			[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		};
	};
} else {player globalchat "Access Denied"};