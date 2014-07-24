private ["_bool"];

if (isnil "MCC_ConolseUAV") exitWith {};
if (!alive MCC_ConolseUAV) exitWith {}; 

_console = switch (side player) do
			{
				case west :	{"B_UavTerminal"};
				case east :	{"O_UavTerminal"};
				case resistance :	{"I_UavTerminal"};
			};

if !(_console in (assignedItems player)) then {player linkItem _console; sleep 0.5};

_bool = player connectTerminalToUav MCC_ConolseUAV;

if (_bool) then {player action ["SwitchToUAVDriver", MCC_ConolseUAV]}; 
while {dialog} do {closedialog  0}; 


	
	