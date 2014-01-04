#define MCC_MINIMAP 9120

#define mcc_playerConsole_IDD 2993
#define MCC_CONSOLE_UAVPIP 9105 


private ["_uav","_arguments","_type"];
disableSerialization;

_type	= _this select 0;

if (_type == 0) then {											//open UAV
	_time = time + (2 + random 5);
	while {_time > time && dialog} do {
		_message = "";
		_messageFinal = ["C","o","n","n","e","c","t","i","n","g"," ","M","Q","9","-","R","e","a","p","e","r",".",".",".","."];
		for "_i" from 0 to (count _messageFinal - 1) do {
			_message = _message + (_messageFinal select _i);
			ctrlSetText [MCC_CONSOLE_UAVPIP, _message];
			sleep 0.05;
		};
	};
	if (dialog) then {
		closedialog 0; 
		closedialog 0; 
		_nul=[] execVM MCC_path + "general_scripts\console\conoleUavAction.sqf";
		};
	};