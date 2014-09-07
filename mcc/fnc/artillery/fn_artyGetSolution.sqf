//==================================================================MCC_fnc_artyGetSolution===============================================================================================
// Create a fire solution hint
// Example:[_cannon, _splashpos,_firedelay,_artitype,_nrshells,_spread] spawn MCC_fnc_artyGetSolution;
//===========================================================================================================================================================================	
private ["_unit","_cannon","_splashpos","_firedelay","_artitype","_nrshells","_spread","_counter","_messege","_solution","_solLow","_solLowETA","_solHigh","_solHighETA"];
_unit	 	= _this select 0;
_splashpos 	= _this select 1;
_firedelay 	= _this select 2;
_artitype 	= _this select 3;
_nrshells 	= _this select 4;
_spread 	= _this select 5;

_cannon = vehicle _unit;
if (_cannon != vehicle player) exitWith {};

_cannon setvariable ["MCC_fireMissionShellType",_artitype];
_cannon setvariable ["MCC_fireMissionShellNumber",_nrshells];

_cannon removeAllEventHandlers "fired";
_cannon addeventhandler["fired", {
									_cannon = _this select 0;
									_shellType = _this select 5;
									_nrshells = _cannon getvariable ["MCC_fireMissionShellNumber",0];
									_shellTypeNeeded = _cannon getvariable ["MCC_fireMissionShellType",""];
									if (_shellType == _shellTypeNeeded) then
									{
										_nrshells = _nrshells -1;  
										_cannon setvariable ["MCC_fireMissionShellNumber",_nrshells]
									};
								  }];

//Register fire mission
_counter =  ["MCC_fireMissionCounter",1] call bis_fnc_counter;
player setVariable ["MCC_fireMissionCounter",_counter]; 

while {(_cannon == vehicle player) && alive player && (_counter == (player getVariable ["MCC_fireMissionCounter",0])) && ((_cannon getvariable ["MCC_fireMissionShellNumber",0])>0)} do
{
	_solution = [_splashpos, player] call MCC_fnc_calcSolution;

	
	if (count _solution > 0 && !isnil "_solution") then
	//In range
	{
		_solLow = _solution select 0;
		_solLowETA = _solution select 1;
		_solHigh = _solution select 2;
		_solHighETA = _solution select 3;
		_messege = format["<t color='#00CCFF'>Fire Mission: %1</t><br/>----------------------<br/>X-ray: %2<br/>Yankee %3<br/>Direction %4<br/>----------------------<br/>Rounds: %5<br/>Rounds Type: %6<br/>Rounds Delay: %7s<br/>Rounds Spread: %8m<br/><br/><t color='#00CCFF'>Low Solution:</t><br/>Elevation: %9<br/>ETA: %10<br/><br/><t color='#00CCFF'>High Solution:</t><br/>Elevation: %11<br/>ETA: %12<br/><br/>Use [PageUp],[PageDown] to change elevation",
					_counter,
					_splashpos select 0,
					_splashpos select 1,
					_solution select 4,
					_cannon getvariable ["MCC_fireMissionShellNumber",0],
					getText(configFile >> "cfgMagazines" >> _artitype >> "displayname"),
					_firedelay,
					_spread,
					if (isnil "_solLow") then {"N/A"} else {if (_solLow < 0) then {"N/A"} else {_solLow}},
					if (isnil "_solLowETA") then {"N/A"} else {_solLowETA},
					if (isnil "_solHigh") then {"N/A"} else {_solHigh},
					if (isnil "_solHighETA") then {"N/A"} else {_solHighETA}			
				]
	}
	//Out of range
	else
	{
		_messege = format["<t color='#00CCFF'>Fire Mission: %1</t><br/>------------<br/>X-ray: %2<br/>Yankee %3<br/>Out Of Range",
					_counter,
					_splashpos select 0,
					_splashpos select 1		
				]
	};
	hintsilent parseText _messege;
	sleep 1; 
};

hint "";
