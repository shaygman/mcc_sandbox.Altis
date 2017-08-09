/*================================================================MCC_fnc_handleKilled============================================================================
// Kill messeges
==============================================================================================================================================================*/
private ["_distance","_string","_xpFactor"];

params ["_unit","_killer"];
if (missionNamespace getVariable ["CP_activated",true]) then {
	//GetXP
	if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {
		_distance =floor (_killer distance _unit);

		_string = if (missionNamespace getVariable ["CP_activated",false]) then {
					if  (isPlayer _unit) then {
						format ["Incapacitating (lvl %1) %2 (Distance %3m)", (_unit getvariable ["CP_roleLevel",1]), name _unit, _distance];
					} else {
						format ["Incapacitating %1 (Distance %2m)", name _unit, _distance];
					}
				} else {
				format ["Incapacitating %1 (Distance %2m)", name _unit, _distance];
			};

		_xpFactor = if (vehicle player != player) then {0.5} else {(ceil(_distance/200) min 3)};

	} else {
		_string = "";
	};

	if (side _killer getFriend ([_unit,true] call BIS_fnc_objectSide) < 0.6) then {
		[[getplayeruid _killer, (100*_xpFactor),_string], "MCC_fnc_addRating", _killer] spawn BIS_fnc_MP;
	};
};