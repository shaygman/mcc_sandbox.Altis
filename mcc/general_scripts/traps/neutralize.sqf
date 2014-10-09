private ["_suspect","_men","_index","_rand"];
_suspect = _this select 0;
_men = _this select 1;
_index = _this select 2;
_rand= random 10;

if (!alive _suspect) exitWith {_suspect removeaction _index}; 

if (!MCC_natureIsRuning) then
{
	MCC_natureIsRuning = true; 
	if (_men distance _suspect <=10) then 
	{
		if (random 10 > 5) then {[[[netid _men,_men], "hands"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "dontmove"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
		sleep 2;
		if (_rand > 2) then 
		{
			if (random 10 > 5) then {[[[netid _suspect,_suspect], "dontshot"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _suspect,_suspect], "enough"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
			removeAllWeapons _suspect;
			[[2,getpos _suspect,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _suspect)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;
			doStop _suspect;
			_suspect setUnitPos "DOWN";
			_suspect setvariable ["armed",false,true];
			sleep 1;
			_suspect removeaction _index;
			
			{
			  deleteVehicle _x;
			} forEach attachedObjects _suspect;
			
			_suspect addaction ["<t color=""#FF0000"">- Secure Suspect -</t>",MCC_path +"mcc\general_scripts\hostages\hostage.sqf",[2],6,true,true,"","(_target distance _this) < 10"];
		} 
		else
		{
			if (random 10 > 5) then {[[[netid _suspect,_suspect], "hell"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _suspect,_suspect], "alone"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
			sleep 1;
		};
		
		MCC_natureIsRuning = false;				
	}
	else {hint "To far to neutralize"};
};
							
																
