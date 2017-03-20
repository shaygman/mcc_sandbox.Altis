//==================================================================MCC_fnc_interactDoor==============================================================================
// Interaction with Door type
// Example: [_object] spawn MCC_fnc_interactMan;
//===============================================================================================================================================================
private ["_object","_optionalDoors","_suspectCorage","_typeOfSelected","_doorTypes","_loadName","_waitTime","_array","_str"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]

disableSerialization;
_object 	= _this select 0;

_waitTime = 1;

private ["_door","_animation","_phase","_closed","_tempArray"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

switch (true) do {
	//House
	case (_object isKindof "house" || _object isKindof "wall") : {
		if (_door == "") exitWith {};

		sleep 0.1;
		//Open dialog
		if ((missionNamespace getVariable ["MCC_interactionKey_holding",false]) && _closed) exitWith {

			_array = [["closeDialog 0","<t size='1' align='center' color='#ffffff'>Door</t>",""]];

			//Check door
			/*if (_object getVariable [format ["bis_disabled_%1_info",_door],false]) then {*/

				//Door Info
				_array pushBack ["['nothing'] spawn MCC_fnc_DoorMenuClicked",if (((_object getVariable [format ["bis_disabled_%1",_door],0])==0)) then {"Door Unlocked"} else {"Door Locked"},"\A3\ui_f\data\map\groupicons\waypoint.paa"];

				//if locked or not
				if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then {

					//Door unlocked
					if (({_x in items player} count MCC_LOCKPICK)!=0) then {
						_array pushBack ["['lock'] spawn MCC_fnc_DoorMenuClicked","Lock Door",MCC_path + "mcc\interaction\data\lock.paa"];
					};

					//Breach & bang
					if !(currentThrowable player isEqualTo []) then {
						_array pushBack ["['breachandbang'] spawn MCC_fnc_DoorMenuClicked","Breach & Bang",MCC_path + "mcc\interaction\data\grenade.paa"];
					};
				} else {
					//Door Locked
					if (({_x in items player} count MCC_LOCKPICK)!=0) then {
						_array pushBack ["['unlock'] spawn MCC_fnc_DoorMenuClicked","Pick Lock",MCC_path + "mcc\interaction\data\unlock.paa"];
					};
				};
			/*} else {
				_array pushBack ["['check'] spawn MCC_fnc_DoorMenuClicked","Check door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"];
			};*/

			//Do we have charges
			if (MCC_CHARGE in magazines player) then {_array pushBack ["['charge'] spawn MCC_fnc_DoorMenuClicked",format ["Place Breaching Charge (%1)",{_x == MCC_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> MCC_CHARGE >> "picture")]};


			//Do we have mirrors?
			if (({_x in items player} count MCC_MIROR)==0) then {_array pushBack ["['camera'] spawn MCC_fnc_DoorMenuClicked","Mirror under the door",MCC_path + "data\tacticalProbe.paa"]};

			if (count _array == 1) exitWith {};

			[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
			waituntil {dialog};

			player setVariable ["interactWith",[_object, _door, _phase]];
			waituntil {!dialog};
			sleep _waitTime;

			player setVariable ["MCC_interactionActive",false];
		};

		//We just pressed open/close door
		if (((_object getVariable [format ["bis_disabled_%1",_door],0])==1) && !MCC_interactionKey_holding) exitWith {
						_object animate [_animation, 0.1];
			//_object animateSource [_animation,  0.1];
			sleep 0.1;
			_object animate [_animation, 0];
			//_object animateSource [_animation, 0];
		};

		//systemChat format ["%1 - %2", _object,_animation];
		//_object animateSource [_animation, _phase];
		_object animate [_animation, _phase];
		sleep _waitTime;
		player setVariable ["MCC_interactionActive",false];
	};

	//Vehicle
	case (((_object isKindof "air") || (_object isKindof "ship") || (_object isKindof "LandVehicle") || _object isKindof "ReammoBox_F") && (player distance _object < 7)):
	{
		MCC_fnc_vehicleMenuClicked =
		{
			private ["_ctrlData","_object","_phase","_door"];
			disableSerialization;

			_ctrlData	= _this select 0;
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
		if ((missionNamespace getVariable ["MCC_interactionKey_holding",false]) && ((side _object == civilian || (side _object getFriend side player)>0.6)) && !dialog && isNull (player getVariable ["mcc_draggedObject", objNull])) exitWith {
			//set options

			_displayName = getText (configfile >> "CfgVehicles" >> typeof _object >> "displayName");
			_pic		 = if (_object isKindof "ReammoBox_F") then {""} else {getText (configfile >> "CfgVehicles" >> typeof _object >> "picture")};
			_array = [["closeDialog 0",_displayName,_pic]];

			{
				if ((_object emptyPositions _x)>0 && ((vectorUp _object) select 2) >0 && locked _object <2) then {
					_array pushBack [format ["['%1'] spawn MCC_fnc_vehicleMenuClicked",_x],format ["Board %1 as %2",_displayName,if (_object isKindof "air" && _x == "driver") then {"pilot"} else {_x}],format ["\A3\ui_f\data\igui\cfg\actions\getin%1_ca.paa",_x]]
				};
			} foreach ["commander","driver","gunner","cargo"];

			//Unload wounded
			if (({_x getVariable ["MCC_medicUnconscious",false]} count (crew _object))>0) then
			{
				_array pushBack ["['unload'] spawn MCC_fnc_vehicleMenuClicked","Unload Wounded",format ["%1data\iconDrag.paa",MCC_path]];
			};

			//Static-drag but no inventory
			if ((_object isKindof "StaticWeapon" || _object isKindof "ReammoBox_F") && (_object != (player getVariable ["mcc_draggedObject", objNull])) && (count attachedObjects _object == 0) && (getmass _object < 501) && (isNull attachedTo _object)) then {
				_array pushBack ["['drag'] spawn MCC_fnc_vehicleMenuClicked",format ["Drag %1",_displayName],format ["%1data\iconDrag.paa",MCC_path]];
			};

			//FOB BOX
			if (_object isKindof "Box_FIA_Support_F" && !(isNull attachedTo _object)) then {

				//rts main box
				if (!(_object getVariable ["mcc_mainBoxUsed", false]) && count (_object getVariable ["MCC_virtual_cargo",[]]) > 0 && (missionNamespace getVariable ["MCC_surviveMod",false])) then {
						_array pushBack["['mainBox'] spawn MCC_fnc_vehicleMenuClicked","Open Vault",format ["%1mcc\interaction\data\safe.paa",MCC_path]];
				};

				//Change Kits
				if (CP_activated && (missionNamespace getVariable ["MCC_allowChangingKits",true]) && !(missionNamespace getVariable ["MCC_surviveMod",false])) then {
					_array pushBack["['kitSelect'] spawn MCC_fnc_vehicleMenuClicked","Change Kit",format ["%1data\IconPhysical.paa",MCC_path]];
				};

				//Resupply
				if (!(missionNamespace getVariable ["MCC_surviveMod",false])) then {
					_array pushBack["['resupply'] spawn MCC_fnc_vehicleMenuClicked","Resupply",format ["%1data\IconAmmo.paa",MCC_path]];
				};
			};

			//Flip atv
			if (_object isKindof "Quadbike_01_base_F" && ((vectorUp _object) select 2) <0 && side _object == civilian) then {
				_array pushBack ["['flip'] spawn MCC_fnc_vehicleMenuClicked",format ["Flip %1",_displayName],format ["%1data\iconDrag.paa",MCC_path]];
			};

			//Push boat
			if (_object isKindof "ship") then {
				_array pushBack ["['push'] spawn MCC_fnc_vehicleMenuClicked",format ["Push %1",_displayName],format ["%1data\iconDrag.paa",MCC_path]];
			};

			//Gear menu
			if (!(_object isKindof "StaticWeapon" || _object isKindof "Box_FIA_Support_F") && !CP_activated) then {
				_array pushBack ["['gear'] spawn MCC_fnc_vehicleMenuClicked","Open inventory",format ["%1data\IconAmmo.paa",MCC_path]];
			};

			//Open dialog
			if (count _array == 1) exitWith {player setVariable ["MCC_interactionActive",false]};
			[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
			waituntil {dialog};

			_object spawn {
				while {dialog} do {
					if (_this distance player > 7) exitWith {};
					sleep 0.1;
				};
				closedialog 0;
			};

			player setVariable ["interactWith",_object];
			//_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_vehicleMenuClicked"];
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
	};
};
