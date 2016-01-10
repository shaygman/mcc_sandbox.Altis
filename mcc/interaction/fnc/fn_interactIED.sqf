//==================================================================MCC_fnc_interactIED===============================================================================================
// Interaction with IED type
// Example: [_men,_ied] spawn MCC_fnc_interactMan;
//=================================================================================================================================================================================
private ["_ied","_men","_rand","_disarmTime", "_footer", "_html", "_break","_dummyMarker","_isEngineer","_ok","_c4","_waitTime"];

#define MCC_CHARGE "DemoCharge_Remote_Mag"

_men 		= _this select 0;
_ied 		= _this select 1;
if (isnil "_ied") exitWith {};
_waitTime = 1;
_rand		= random 1;

//is engineer
_isEngineer = if (((getNumber(configFile >> "CfgVehicles" >> typeOf _men >> "canDeactivateMines")) == 1) || ((player getvariable ["CP_role",""]) == "Specialist")) then {true} else {false};
_disarmTime =  _ied getvariable "MCC_disarmTime";
_pos=[((getposATL _ied) select 0),(getposATL _ied) select 1,((getPosATL _ied) select 2)];

//Is it a mini-game
if ((_ied getVariable ["MCC_isIEDMiniGame",false]) && (_ied getvariable ["armed",false])) exitWith {
	[_ied,true] spawn MCC_fnc_bdStart;
	player setVariable ["MCC_interactionActive",false];
};

if (_men distance _ied <4) then {
	disableSerialization;

	player setVariable ["MCC_interactionActive",true];
	_ied setVariable ["MCC_isInteracted",true,true];

	//Open dialog
	if !((missionNamespace getVariable ["MCC_interactionKey_holding",false])) exitWith {
		MCC_fnc_IEDMenuClicked = {
			private ["_ctrl","_index","_ctrlData","_ied"];
			disableSerialization;

			_ctrlData	= _this select 0;
			_ied = player getVariable ["ied",objnull];

			if (_ctrlData == "charge" && (({_x == MCC_CHARGE} count magazines player)>0)) then {
				closedialog 0;
				player removeMagazine MCC_CHARGE;
				["Placing Charge",10] call MCC_fnc_interactProgress;

				_c4 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player;
				player addAction ["<t color=""#FF0000"">Detonate Charge</t>", {
												player removeAction (_this select 2);
												((_this select 3) select 0) setDamage 1;
												((_this select 3) select 1) setvariable ["iedTrigered",true,true];
											}, [_c4,_ied]];
			}
			else {
				closedialog 0;
			};
		};

		[[["['charge'] spawn MCC_fnc_IEDMenuClicked",format ["Place Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")]],0] call MCC_fnc_interactionsBuildInteractionUI;

		waituntil {dialog};

		_ied spawn {
			while {dialog} do {
				if (_this distance player > 7) exitWith {};
				sleep 0.1;
			};
			closedialog 0;
		};

		player setVariable ["ied",_ied];
		waituntil {!dialog};
		player setVariable ["MCC_interactionActive",false];
	};

	player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
	_break = false;

	//Create progress bar
	_success = ["Disarming",_disarmTime,_ied] call MCC_fnc_interactProgress;
	if !(_success) exitWith {};

	//If it is a bomb expert ;)
	if (_isEngineer) then {
		if (_rand > 0.20) then {
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

			sleep 1;
			if (_isEngineer) then {player addrating 500};
			_ied setvariable ["armed",false,true];
			player setVariable ["MCC_interactionActive",false];
			_ied setVariable ["MCC_isInteracted",false,true];
		} else {
			if (_rand >0.05) then {
				hint "Fail to disarm";

				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			} else {
				hint "Critical fail start runing";

				[[[netid _men,_men], format ["disarmcrit%1", (floor random 2)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

				_ied setvariable ["armed",false,true];
				sleep 2 + random 3;
				"SmallSecondary" createVehicle _pos;
				sleep 2 + random 3;
				_ied setvariable ["iedTrigered",true,true];
			};
		}
	} else {
		//If it isn't a bomb expert <*Kaboom*>
		if (_rand > 0.70) then {
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

			sleep 1;
			_ied setvariable ["armed",false,true];
		} else {
			hint "Fail to disarm";
			if (_rand >0.3) then {
				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			} else {
				hint "Critical fail start runing";

				[[[netid _men,_men], format ["disarmcrit%1", (floor random 2)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

				_ied setvariable ["armed",false,true];
				sleep 3 + random 3;
				"SmallSecondary" createVehicle _pos;
				sleep 3 + random 3;
				_ied setvariable ["iedTrigered",true,true];
			};
		};
	};

	player setVariable ["MCC_interactionActive",false];
	_ied setVariable ["MCC_isInteracted",false,true];
}
else {hint "To far to disarm"};
_ied setVariable ["MCC_isInteracted",false,true];
sleep _waitTime;
player setVariable ["MCC_interactionActive",false];