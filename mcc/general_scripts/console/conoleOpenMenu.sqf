private ["_message","_messageFinal","_time","_ok","_type","_nul","_stance"];
// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_playerConsoleLoading_IDD 2991

#define MCC_ConsoleLoadingText 9105
disableSerialization;

_type = (_this select 3) select 0; 								//Switch we are opening the console or the other options

closedialog 0; 
_ok = createDialog "MCC_playerConsoleLoading";

_time = time + 3;

if (_type == 0) then {											//Opening the conole
	if (vehicle player == player ) then
		{
			switch (stance player) do
				{
				   case "STAND":	
					{ 
						_stance = "AinvPercMstpSrasWrflDnon";
					};
					
					case "CROUCH":	
					{ 
						_stance = "AinvPknlMstpSrasWrflDnon";
					};
					
					case "LYING":	
					{ 
						_stance = "AinvPpneMstpSrasWrflDnon";
					};
					
					default
					{
						_stance = "";
					}
				};
			player playMove _stance;
		};
	if (MCC_CASConsoleFirstTime) then	
	{
		while {_time > time && dialog} do 
		{
			_message = "";
			_messageFinal = ["S","e","a","r","c","h","i","n","g"," ","S","a","t","e","l","l","i","t","e","s",".",".",".",".","."];
			for "_i" from 0 to (count _messageFinal - 1) do {
				_message = _message + (_messageFinal select _i);
				ctrlSetText [9105, _message];
				sleep 0.05;
			};
		};
		MCC_CASConsoleFirstTime = false; 
	};

	if (dialog) then 
	{
		_time = time + random 1; 
		while {_time > time && dialog} do 
		{
			_message = "";
			_messageFinal = ["C","o","n","n","e","c","t","i","n","g",".",".",".",".","."];
			for "_i" from 0 to (count _messageFinal - 1) do 
			{
				_message = _message + (_messageFinal select _i);
				ctrlSetText [9105, _message];
				sleep 0.05;
			};
		};
	};

	if (dialog && MCC_ConsoleOperator == "") then {MCC_ConsoleOperator = name player; publicVariable "MCC_ConsoleOperator"};	//First login 
	
	if (dialog && MCC_ConsoleOperator ==  name player) then {									//sign in 
		closedialog 0; 
		_ok = createDialog "MCC_playerConsole";
		};
	
	if (dialog && MCC_ConsoleOperator !=  name player) then {									//access denied
		ctrlSetText [9105, format ["Access denied: %1 is signed in",MCC_ConsoleOperator]];
		sleep 2;
		closedialog 0; 
		};
	};

if (_type == 1) then {											//Switching to Artillery
	_time = time + random 2;
	while {_time > time && dialog} do {
		_message = "";
		_messageFinal = ["C","o","n","n","e","c","t","i","n","g"," ","S","t","e","e","l"," ","R","a","i","n",".",".","."];
		for "_i" from 0 to (count _messageFinal - 1) do {
			_message = _message + (_messageFinal select _i);
			ctrlSetText [9105, _message];
			sleep 0.05;
		};
	};
	if (dialog) then {
		closedialog 0; 
		MCC_Console1Open = false;
		MCC_Console2Open = false;
		MCC_Console3Open = false;
		MCC_Console4Open = true;
		_nul=[1] execVM MCC_path + "bon_artillery\dialog\openMenu.sqf";
		};
	};