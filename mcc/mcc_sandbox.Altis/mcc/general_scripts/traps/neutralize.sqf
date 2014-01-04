private ["_suspect","_men","_index","_rand"];
_suspect = _this select 0;
_men = _this select 1;
_index = _this select 2;
_rand= random 10;

if (!MCC_natureIsRuning) then
	{
	MCC_natureIsRuning = true; 
	if (_men distance _suspect <=10) then 
		{
		if (random 10 > 5) then {[[[netid _men,_men], "hands"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "dontmove"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
		sleep 2;
			if (_rand > 2) then {
									if (random 10 > 5) then {[[[netid _suspect,_suspect], "dontshot"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _suspect,_suspect], "enough"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
									removeAllWeapons _suspect;
									_suspect playmove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
									sleep 1;
									_suspect setvariable ["armed",false,true];
									_suspect removeaction _index;
									_suspect addAction ["Secure suspect", MCC_path + "mcc\general_scripts\hostages\hostage.sqf", [0]];
									} else
										{
										if (random 10 > 5) then {[[[netid _suspect,_suspect], "hell"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _suspect,_suspect], "alone"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
										sleep 1;
										};
		MCC_natureIsRuning = false;				
		}
		else {hint "To far to neutralize"};
	};
							
																
