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

if (_men distance _ied <4) then
{
	disableSerialization;

	player setVariable ["MCC_interactionActive",true];
	_ied setVariable ["MCC_isInteracted",true,true];

	//Open dialog
	if !(MCC_interactionKey_holding) exitWith
	{
		MCC_fnc_IEDMenuClicked =
		{
			private ["_ctrl","_index","_ctrlData","_ied"];
			disableSerialization;

			_ctrl 		= _this select 0;
			_index 		= _this select 1;
			_ctrlData	= _ctrl lbdata _index;
			_ied = player getVariable ["ied",objnull];

			if (_ctrlData == "charge" && (({_x == MCC_CHARGE} count magazines player)>0)) then
			{
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
			else
			{
				closedialog 0;
			};
		};

		_ok = createDialog "MCC_INTERACTION_MENU";
		waituntil {dialog};
		_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
		_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.05* safezoneH];
		_ctrl ctrlCommit 0;

		_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

		lbClear _ctrl;
		{
			_class			= _x select 0;
			_displayname 	= _x select 1;
			_pic 			= _x select 2;
			_index 			= _ctrl lbAdd _displayname;
			_ctrl lbSetPicture [_index, _pic];
			_ctrl lbSetData [_index, _class];
		} foreach [["charge",format ["Place Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")],["close","Close Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];
		_ctrl lbSetCurSel 0;

		player setVariable ["ied",_ied];
		_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_IEDMenuClicked"];
		waituntil {!dialog};
		sleep 1;
		player setVariable ["MCC_interactionActive",false];
	};

	player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
	_break = false;

	//Create progress bar
	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutRsc ["MCC_interactionPB", "PLAIN"];
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 2);
	_ctrl ctrlSetText "Disarming";
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 1);

	for [{_x=1},{_x<_disarmTime},{_x=_x+0.1}]  do
	{

		_ctrl progressSetPosition (_x/_disarmTime);
		if ((animationState player)!="AinvPknlMstpSlayWrflDnon_medic") then {player playMoveNow "AinvPknlMstpSlayWrflDnon_medic"};
		if ((_ied distance _men) > 5 || !MCC_interactionKey_holding) then {_x = _disarmTime; _break = true; hintSilent ""}; //check if still close to the IED
		sleep 0.1;
	};

	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	//player switchMove "AmovPknlMstpSlowWrflDnon";
	player playMoveNow "AmovPknlMstpSlowWrflDnon";

	//If moved to far from the IED
	if (_break) exitwith
	{
		sleep 0.5;
		player setVariable ["MCC_interactionActive",false];
		_ied setVariable ["MCC_isInteracted",false,true];
	};

	//If it is a bomb expert ;)
	if (_isEngineer) then
	{
		if (_rand > 0.20) then
		{
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

			sleep 1;
			if (_isEngineer) then {player addrating 500};
			_ied setvariable ["armed",false,true];
			player setVariable ["MCC_interactionActive",false];
			_ied setVariable ["MCC_isInteracted",false,true];
		}
		else
		{
			if (_rand >0.05) then
			{
				hint "Fail to disarm";

				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			}
			else
			{
				hint "Critical fail start runing";

				[[[netid _men,_men], format ["disarmcrit%1", (floor random 2)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

				_ied setvariable ["armed",false,true];
				sleep 2 + random 3;
				"SmallSecondary" createVehicle _pos;
				sleep 2 + random 3;
				_ied setvariable ["iedTrigered",true,true];
			};
		}
	}
	else
	{
		//If it isn't a bomb expert <*Kaboom*>
		if (_rand > 0.70) then
		{
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;

			sleep 1;
			_ied setvariable ["armed",false,true];
		}
		else
		{
			hint "Fail to disarm";
			if (_rand >0.3) then
			{
				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			}
			else
			{
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