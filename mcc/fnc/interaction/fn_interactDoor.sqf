//==================================================================MCC_fnc_interactDoor========================================================================================
// Interaction with Door type
// Example: [_object] spawn MCC_fnc_interactMan;
//==============================================================================================================================================================================
private ["_object","_door","_optionalDoors","_suspectCorage","_typeOfSelected","_animation","_phase","_doorTypes","_loadName","_waitTime","_array","_str","_closed"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]
#define MCC_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

disableSerialization;
_object 	= _this select 0;

_waitTime = 1;

_door = [_object] call MCC_fnc_isDoor;

switch (true) do {
	//House
	case (_object isKindof "house" || _object isKindof "wall") : {
		if (_door == "") exitWith {};

		if (tolower worldName in MCC_ARMA2MAPS) then {
			_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
			_animation = "dvere"+_str;
			//_animation = _door + "_rot";
		} else {
			_animation = _door + "_rot";
		};

		_phase = if ((_object animationPhase _animation) > 0) then {0} else {1};

		//Check if locked
		if (((_object getVariable [format ["bis_disabled_%1",_door],0])==1) && !MCC_interactionKey_holding) exitWith {
			_object animate [_animation, 0.1];
			sleep 0.1;
			_object animate [_animation, 0];
		};

		//ArmA2 maps have it all viceversa way to go BI
		_closed = if (tolower worldName in MCC_ARMA2MAPS) then {
						if (_phase == 0) then {true} else {false};
					} else {
						if (_phase == 0) then {false} else {true};
					};

		//Open dialog
		if (MCC_interactionKey_holding && _closed && !dialog) exitWith {

			_array = [["charge",format ["Place Breaching Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")],
					  ["check","Check door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
					  ["camera","Mirror under the door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
					  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

			//If door is unlocked change the action to lock
			if (_object getVariable [format ["bis_disabled_%1_info",_door],false]) then {
				if (({_x in items player} count MCC_LOCKPICK)!=0) then {
					if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then
					{
						_array set [1, ["lock","Wedge Door","\A3\ui_f\data\map\groupicons\waypoint.paa"]]
					} else {
						_array set [1, ["unlock","Pick Lock","\A3\ui_f\data\map\groupicons\waypoint.paa"]];
					};
				} else {
						_array set [1, ["nothing",if (((_object getVariable [format ["bis_disabled_%1",_door],0])==0)) then {"Door Unlocked"} else {"Door Locked"},"\A3\ui_f\data\map\groupicons\waypoint.paa"]]
				};
			};

			//Check if we have the tools for the job
			if !(MCC_CHARGE in magazines player) then {_array set [0,-1]};
			if (({_x in items player} count MCC_MIROR)==0) then {_array set [2,-1]};
			_array = _array - [-1];

			if (count _array == 1) exitWith {};
			_ok = createDialog "MCC_INTERACTION_MENU";
			waituntil {dialog};

			_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
			_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
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
			} foreach _array;
			_ctrl lbSetCurSel 0;

			player setVariable ["interactWith",[_object, _door, _phase]];
			_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_DoorMenuClicked"];
			waituntil {!dialog};
			sleep _waitTime;
			player setVariable ["MCC_interactionActive",false];
		};

		_object animate [_animation, _phase];
		sleep _waitTime;
		player setVariable ["MCC_interactionActive",false];
	};

	//Vehicle
	case (((_object isKindof "air") || (_object isKindof "ship") || (_object isKindof "LandVehicle") || _object isKindof "ReammoBox_F") && (player distance _object < 7)):
	{
		MCC_fnc_vehicleMenuClicked =
		{
			private ["_ctrl","_index","_ctrlData","_object","_phase","_door"];
			disableSerialization;

			_ctrl 		= _this select 0;
			_index 		= _this select 1;
			_ctrlData	= _ctrl lbdata _index;
			_object		= player getVariable ["interactWith",objNull];

			closeDialog 0;
			switch (true) do {
				case (_ctrlData in ["commander","driver","gunner","cargo"]) : {player action [format ["getIn%1",_ctrlData], _object]};
				case (_ctrlData == "gear") : {player action ["Gear", _object]};
				case (_ctrlData == "drag") : {[_object] call MCC_fnc_dragObject};
				case (_ctrlData == "flip") : {
					_pos = getpos _object;
					_pos set [2, (_pos select 2)+1];
					_object setpos _pos;
					[_object ,0, 0] call bis_fnc_setpitchbank;
				};

				case (_ctrlData == "push") : {
					_dir = direction player;
					_object setVelocity [(sin _dir * 2), (cos _dir * 2), 0];
				};

				case (_ctrlData == "unload"): {
					{

						if (_x getVariable ["MCC_medicUnconscious",false]) then	{
							[[[_x],{
								_unit = _this select 0;
								moveOut _unit; unassignVehicle _unit;
								waitUntil {vehicle _unit == _unit};
								sleep 2;
								_unit playmoveNow 'Unconscious';
							}], "BIS_fnc_spawn", _x, false] spawn BIS_fnc_MP;
						};
					} forEach (crew _object);
				};

				case (_ctrlData == "mainBox"): {
					_object setVariable ["mcc_mainBoxUsed", true,true];
					_null = [] call MCC_fnc_mainBoxInit;
 					waituntil {!dialog};
 					_object setVariable ["mcc_mainBoxUsed", false,true];
				};

				case (_ctrlData == "resupply"): {
					[_object,true] spawn MCC_fnc_resupply;
				};

				case (_ctrlData == "kitSelect"): {
					createDialog "CP_GEARPANEL";
				};
			};
		};

		//Open dialog
		if (MCC_interactionKey_holding && ((side _object == civilian || (side _object getFriend side player)>0.6)) && !dialog && isNull (player getVariable ["mcc_draggedObject", objNull])) exitWith
		{
			//set options
			_array = [];
			_displayName = getText (configfile >> "CfgVehicles" >> typeof _object >> "displayName");
			_pic		 = getText (configfile >> "CfgVehicles" >> typeof _object >> "picture");

			{
				if ((_object emptyPositions _x)>0 && ((vectorUp _object) select 2) >0 && locked _object <2) then {_array set [count _array, [_x,format ["Board %1 as %2",_displayName,if (_object isKindof "air" && _x == "driver") then {"pilot"} else {_x}],format ["\A3\ui_f\data\igui\cfg\actions\getin%1_ca.paa",_x]]]};
			} foreach ["commander","driver","gunner","cargo"];

			//Unload wounded
			if (({_x getVariable ["MCC_medicUnconscious",false]} count (crew _object))>0) then
			{
				_array set [count _array, ["unload","Unload Wounded","\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"]];
			};

			//Static-drag but no inventory
			if ((_object isKindof "StaticWeapon" || _object isKindof "ReammoBox_F") && (_object != (player getVariable ["mcc_draggedObject", objNull])) && (count attachedObjects _object == 0) && (getmass _object < 501) && (isNull attachedTo _object)) then {
				_array set [count _array,["drag",format ["Drag %1",_displayName],format ["%1data\IconAmmo.paa",MCC_path]]];
			};

			//FOB BOX
			if (_object isKindof "Box_FIA_Support_F" && !(isNull attachedTo _object)) then {

				//rts main box
				if ((_object getVariable ["mcc_mainBoxUsed", false]) && count (_object getVariable ["MCC_virtual_cargo",[]]) > 0 && (missionNamespace getVariable ["MCC_surviveMod",false])) then {
						_array pushBack["mainBox","Open Vault",format ["%1data\IconAmmo.paa",MCC_path]];
				};

				//Change Kits
				if (CP_activated && (missionNamespace getVariable ["MCC_allowChangingKits",true]) && !(missionNamespace getVariable ["MCC_surviveMod",false])) then {
					_array pushBack["kitSelect","Change Kit",format ["%1data\IconAmmo.paa",MCC_path]];
				};

				//Resupply
				if (!(missionNamespace getVariable ["MCC_surviveMod",false])) then {
					_array pushBack["resupply","Resupply",format ["%1data\IconAmmo.paa",MCC_path]];
				};
			};

			//Flip atv
			if (_object isKindof "Quadbike_01_base_F" && ((vectorUp _object) select 2) <0 && side _object == civilian) then
			{
				_array set [count _array,["flip",format ["Flip %1",_displayName],_pic]];
			};

			//Push boat
			if (_object isKindof "ship") then
			{
				_array set [count _array,["push",format ["Push %1",_displayName],_pic]];
			};

			//Gear menu
			if (!(_object isKindof "StaticWeapon" || _object isKindof "Box_FIA_Support_F") && !CP_activated) then
			{
				_array set [count _array,["gear","Open inventory",format ["%1data\IconAmmo.paa",MCC_path]]];
			};

			_array set [count _array,["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

			if (count _array == 1) exitWith {};
			_ok = createDialog "MCC_INTERACTION_MENU";
			waituntil {dialog};

			_object spawn
			{
				while {dialog} do
				{
					if (_this distance player > 7 || !alive _this) exitWith {};
					sleep 0.1;
				};
				closedialog 0;
			};
			_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
			_ctrl ctrlSetPosition [0.4,0.4,0.2 * safezoneW, 0.025* count _array* safezoneH];
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
			} foreach _array;
			_ctrl lbSetCurSel 0;

			player setVariable ["interactWith",_object];
			_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_vehicleMenuClicked"];
			waituntil {!dialog};
			sleep _waitTime;
			player setVariable ["MCC_interactionActive",false];
		};

		if !(isNull (player getVariable ["mcc_draggedObject", objNull])) then {[] call MCC_fnc_releaseObject};

		//Quick get inside vehicles
		{
			if ((_object emptyPositions _x)>0 && ((vectorUp _object) select 2) >0 && locked _object <2 && isnull (player getVariable ["mcc_draggedObject", objNull])) exitWith
			{
				player action [format ["getIn%1",_x], _object];
			};
		} foreach ["driver","commander","gunner","cargo"];

		/*
		if (_door == "") exitWith {};
		_phase = if ((_object doorPhase _door) > 0) then {0} else {1};
		_object animateDoor [_door, _phase, false];
		*/
	};
};
