private ["_null","_uid","_name","_value","_playerLevel","_commanderLevel","_arLevel","_riflemanLevel",
		 "_ATLevel","_marksmanLevel","_specialistLevel","_crewLevel","_pilotLevel"];

_uid = _this select 0;
_name = _this select 1;
if (CP_debug) then {diag_log format ["CP: %1: Player: %2 - %3 joined game", time, _uid,_name]};

_playerLevel = profileNamespace getVariable format ["CP_playerLevel_%1",_uid];						// Player level
if (isnil "_playerLevel") then {														
	profileNamespace setVariable [format ["CP_playerLevel_%1",_uid], [1,0]];
	_playerLevel = [1,0];
	};
	
_commanderLevel = profileNamespace getVariable format ["CP_playerCommanderLevel_%1",_uid];			// Player Commander level
if (isnil "_commanderLevel") then {														
	profileNamespace setVariable [format ["CP_playerCommanderLevel_%1",_uid], [1,0]];
	_commanderLevel = [1,0];
	};

_arLevel = profileNamespace getVariable format ["CP_playerARLevel_%1",_uid];						// Player AR level
if (isnil "_arLevel") then {														
	profileNamespace setVariable [format ["CP_playerARLevel_%1",_uid], [1,0]];
	_arLevel = [1,0];
	};
	
_riflemanLevel = profileNamespace getVariable format ["CP_playerRiflemanLevel_%1",_uid];			// Player Rifleman level
if (isnil "_riflemanLevel") then {														
	profileNamespace setVariable [format ["CP_playerRiflemanLevel_%1",_uid], [1,0]];
	_riflemanLevel = [1,0];
	};

_ATLevel = profileNamespace getVariable format ["CP_playerATLevel_%1",_uid];						// Player AT level
if (isnil "_ATLevel") then {														
	profileNamespace setVariable [format ["CP_playerATLevel_%1",_uid], [1,0]];
	_ATLevel = [1,0];
	};	

_corpsmanLevel = profileNamespace getVariable format ["CP_playerCorpsmanLevel_%1",_uid];			// Player Corpsman level
if (isnil "_corpsmanLevel") then {														
	profileNamespace setVariable [format ["CP_playerCorpsmanLevel_%1",_uid], [1,0]];
	_corpsmanLevel = [1,0];
	};

_marksmanLevel = profileNamespace getVariable format ["CP_playerMarksmanLevel_%1",_uid];			// Player Marksman level
if (isnil "_marksmanLevel") then {														
	profileNamespace setVariable [format ["CP_playerMarksmanLevel_%1",_uid], [1,0]];
	_marksmanLevel = [1,0];
	};

_specialistLevel = profileNamespace getVariable format ["CP_playerSpecialistLevel_%1",_uid];		// Player Specialist level
if (isnil "_specialistLevel") then {														
	profileNamespace setVariable [format ["CP_playerSpecialistLevel_%1",_uid], [1,0]];
	_specialistLevel = [1,0];
	};

_crewLevel = profileNamespace getVariable format ["CP_playerCrewLevel_%1",_uid];					// Player Crew level
if (isnil "_crewLevel") then {														
	profileNamespace setVariable [format ["CP_playerCrewLevel_%1",_uid], [1,0]];
	_crewLevel = [1,0];
	};

_pilotLevel = profileNamespace getVariable format ["CP_playerPilotLevel_%1",_uid];						// Player Pilot level
if (isnil "_pilotLevel") then {														
	profileNamespace setVariable [format ["CP_playerPilotLevel_%1",_uid], [1,0]];
	_pilotLevel = [1,0];
	};
	
 [[["playerLevel","commanderLevel","arLevel","riflemanLevel","ATLevel","corpsmanLevel","marksmanLevel","specialistLevel","crewLevel","pilotLevel","CP_gotValueFromServer"],
  [_playerLevel,_commanderLevel,_arLevel,_riflemanLevel,_ATLevel,_corpsmanLevel,_marksmanLevel,_specialistLevel,_crewLevel,_pilotLevel,"true"],
  _uid],"CP_fnc_setValue", true, false] spawn BIS_fnc_MP;