#define MCC_CONSOLE_UAV_MISSILE 9109

private ["_control","_action","_string"];
disableSerialization;
_action = _this select 0;
_control = _this select 1;

if (isnil 'MCC_ConolseUAV') exitWith {}; 
//Flyhight
if (_action == 0) then	
	{
		(_control select 0) ctrlSetTooltip str (_control select 1);  
		if (ismultiplayer) then
			{
				_string = format ['objectfromnetid "%1" flyInHeight %2',netid MCC_ConolseUAV,(sliderPosition (_control select 0))];
			}
			else
			{
				_string = format ['MCC_ConolseUAV flyInHeight %1',(sliderPosition (_control select 0))];
			};
		[[2,compile _string], 'MCC_fnc_globalExecute', MCC_ConolseUAV, false] spawn BIS_fnc_MP;
	};

//Fire Missile
if (_action == 1) then	
	{
		if (ismultiplayer) then
			{
				_string = format ['objectfromnetid "%1" fire "%2"',netid MCC_ConolseUAV,MCC_ConsoleUAVmissiles select 2];
			}
			else
			{
				_string = format ['MCC_ConolseUAV fire "%1"',MCC_ConsoleUAVmissiles select 2];
			};
		[[2,compile _string], 'MCC_fnc_globalExecute', MCC_ConolseUAV, false] spawn BIS_fnc_MP;
	};

