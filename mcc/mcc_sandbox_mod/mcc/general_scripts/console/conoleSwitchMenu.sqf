private ["_type","_ok"];

_type = _this select 0; 								//Switch we are opening the console or the other options

closedialog 0; 
waituntil {!dialog};

switch (_type) do
	{
		case 1:	
		{ 
			_ok = createDialog "MCC_playerConsole";
		};
		
		case 2:	
		{ 
			_ok = createDialog "MCC_playerConsole2";
		};
		
		case 3:	
		{ 
			_ok = createDialog "MCC_playerConsole3";
		};
	};

if (!_ok) then {hint "Failed to open dialog"};
	