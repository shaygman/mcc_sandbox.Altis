//==================================================================MCC_fnc_interactMan===============================================================================================
// Interaction with man type
// Example: [_suspect,_men] spawn MCC_fnc_interactMan; 
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage"];
_suspect = _this select 0;
_men = _this select 1;

//If neturalize make hime follow you
if ((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && !(lineIntersects [getposasl player, getposasl _suspect])) exitWith
{
	if ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2) && (player distance _suspect < 3)) then
	{
		_null = [_suspect, player, 0,[0]] execVM format ["%1mcc\general_scripts\hostages\hostage.sqf",MCC_path];
	};
	
	uiNameSpace setVariable ["MCC_interactionActive",false]; 
};

//shout
[[[netid _men,_men], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
sleep 2;

//Zipcuff
if ((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player)) exitWith
{
	if (player distance _suspect < 3) then
	{
		playsound "MCC_zip";
		_suspect setVariable ["MCC_disarmed",false,true];
		sleep 1; 
		[[_suspect, "AmovPercMstpSnonWnonDnon_Ease", false, -1],"MCC_fnc_setUnitAnim", false, false] spawn BIS_fnc_MP;
		_suspect setVariable ["MCC_neutralize",true,true];
	};
	uiNameSpace setVariable ["MCC_interactionActive",false]
};

//Cant neturalize friendly units
if (((side _suspect != civilian && (side _suspect getFriend  side player)>0.6)) || isPlayer _suspect || (_suspect getVariable ["MCC_neutralize",false])) exitWith {uiNameSpace setVariable ["MCC_interactionActive",false]};

_factor = if (side _suspect == civilian) then {6} else {11};
if (primaryWeapon player == "") then {_factor = _factor*2}; 
_rand= random 20;
		
[[2,getpos _suspect,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _suspect)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

//Stop and look at the player
[[[_suspect, _men], 
  {
	_suspect = _this select 0;
	_men = _this select 1;
	
	(group _suspect) setFormDir ([_suspect,_men] call BIS_fnc_dirTo);
	doStop _suspect;
	_suspect disableAI "MOVE";
  }],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;

//Get courage
_suspectCorage = _suspect getVariable "MCC_courage";
if (isnil "_suspectCorage") then
{
	_suspectCorage = (rankId _suspect + (random 10 + _factor) + count units group _suspect);
	_suspect setVariable ["MCC_courage",_suspectCorage,true];
};
_suspectCorage = _suspectCorage * (1-(getdammage _suspect));
//If comply
if (random 25 > _suspectCorage || (_suspect getVariable ["MCC_Stunned", false])) then 
{
	[[[netid _suspect,_suspect], format ["enough%1",floor random 14]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	[[_suspect,"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"], "MCC_fnc_disarmUnit", _suspect, false] spawn BIS_fnc_MP;

	//if is armed civilian
	if ((_suspect getVariable ["MCC_IEDtype",""]) == "ac") then
	{
		_suspect setvariable ["armed",false,true];
		sleep 1;
		{
		  deleteVehicle _x;
		} forEach attachedObjects _suspect;
	};
	
	//If left unintended for long will break free
	_suspect spawn 
	{
		private ["_escapeChance","_suspect"];
		_suspect		= _this;
		_escapeChance 	= 0.01;
				
		while {alive _suspect && !(_suspect getVariable ["MCC_neutralize",false])} do
		{
			if (random 1 < _escapeChance) exitWith {_suspect setVariable ["MCC_disarmed",false,true]}; 
			_escapeChance = _escapeChance + 0.01;
		};
		
		_suspect setVariable ["MCC_disarmed",false]
	};
} 
else
{
	[[[netid _suspect,_suspect], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	if ((stance _suspect == "STAND") && (side _suspect == civilian)) then 
	{
		[[_suspect,"Acts_Kore_Introducing",true,4], "MCC_fnc_setUnitAnim", true, false] spawn BIS_fnc_MP;
	};
};

[[[_suspect],{(_this select 0) enableAI "MOVE";}],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;
uiNameSpace setVariable ["MCC_interactionActive",false]; 