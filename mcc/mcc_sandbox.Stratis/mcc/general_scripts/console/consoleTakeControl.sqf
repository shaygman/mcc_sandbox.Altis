private ["_bool"];

if (isnil "MCC_ConolseUAV") exitWith {};
if (!alive MCC_ConolseUAV) exitWith {}; 

_bool = player connectTerminalToUav MCC_ConolseUAV;

if (_bool) then {player action ["SwitchToUAVDriver", MCC_ConolseUAV]}; 
while {dialog} do {closedialog  0}; 


	
	