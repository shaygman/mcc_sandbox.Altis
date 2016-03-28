//======================================================MCC_fnc_customTasks=====================================================================================================
// Manage custom tasks
// Example:[_logic] spawn MCC_fnc_customTasks;
// Return - nothing
//==============================================================================================================================================================================
private ["_logic","_attachedUnit","_owners","_taskState","_taskStateDestination","_taskDescription","_taskType","_trg","_name","_desc","_missionDone"];
_logic = _this select 0;
_side = [_this, 1, east] call BIS_fnc_param;
_maxObjectivesDistance = [_this, 2, 400, [0]] call BIS_fnc_param;

waituntil {!alive _logic || _logic getvariable ["updated",false]};

if (!alive _logic) exitWith {};

_attachedUnit 			= _logic getvariable ["AttachObject_object",objnull];
_owners 				= _logic getvariable ["RscAttributeOwners",[]];
_taskState 				= _logic getvariable ["RscAttributeTaskState","created"];
_taskStateDestination 	= _logic getvariable ["RscAttributeTaskDestination",0];
_taskDescription 		= _logic getvariable ["RscAttributeTaskDescription",["","", ""]];
_taskType				= _logic getvariable ["customTask",""];

//Not a custom task? exit
if (_taskType == "") exitWith {};

switch (true) do {
	case (_taskType in ["Secure_HVT"]): {
		waituntil {!alive _attachedUnit || isPlayer leader _attachedUnit || !(isNull attachedTo _attachedUnit)};

		if (alive _attachedUnit) then {
			_desc 	= format ["Get %1 back to base alive",name _attachedUnit];
			_logic setvariable ["RscAttributeTaskState","Succeeded", true];
			_logic setvariable ["updated",true];
			sleep 1;
			[_logic,"RscAttributeTaskDescription",[_desc, _desc, _desc]] call bis_fnc_setServerVariable;
			sleep 1;
			_logic setvariable ["RscAttributeTaskState","assigned", true];
			_logic setvariable ["updated",true];

			_missionDone = false;
			while {! _missionDone} do {
				{
					if (_x distance _attachedUnit < 100) then {
						_logic setvariable ["RscAttributeTaskState","Succeeded", true];
						_missionDone = true;
					};
				} forEach [missionNamespace getvariable ["MCC_START_WEST",[0,0,0]],
				           missionNamespace getvariable ["MCC_START_EAST",[0,0,0]],
				           missionNamespace getvariable ["MCC_START_GUER",[0,0,0]],
				           markerPos "respawn_west",
				           markerPos "respawn_east",
				           markerPos "respawn_guerrila"];

				if (!alive _attachedUnit) then {
					_logic setvariable ["RscAttributeTaskState","Failed", true];
					_missionDone = true;
				};

				sleep 5;
			};
		} else {
			_logic setvariable ["RscAttributeTaskState","Failed", true];
		};
	};

	case (_taskType in ["Kill_HVT"]): {
		waituntil {!alive _attachedUnit || isPlayer leader _attachedUnit};
		_logic setvariable ["RscAttributeTaskState","Succeeded", true];
	};

	case (_taskType in ["disableIED","pick_intel"]): {
		waituntil {isnull _attachedUnit || (_attachedUnit getvariable ["iedTrigered",false])};
		if (isNull _attachedUnit) then {
			_logic setvariable ["RscAttributeTaskState","Succeeded", true];
		} else {
			_logic setvariable ["RscAttributeTaskState","Failed", true];
		};
	};

	case (_taskType in ["clear_area"]): {
		//Create Trigger
		_pos = getpos _logic;
		_trg = createTrigger["EmptyDetector", _pos];
		_trg setTriggerArea[_maxObjectivesDistance*2,_maxObjectivesDistance*2,0,false];

		_trg setTriggerActivation [str _side, "PRESENT", false];

		_name = format ["%1", ["MCCMWClearObjective_",1] call bis_fnc_counter];

		//Create Marker
		[1, "ColorRed",[_maxObjectivesDistance*2,_maxObjectivesDistance*2], "ELLIPSE", "DiagGrid", "Empty", ("clearArea" + _name), _pos] call MCC_fnc_makeMarker;

		sleep 5;
		//Waituntil there are no more enemy units in the area
		waituntil {count list _trg < 3};
		deleteVehicle _trg;
		[2, "",[], "", "", "Empty", ("clearArea" + _name), []] call MCC_fnc_makeMarker;

		_logic setvariable ["RscAttributeTaskState","Succeeded", true];
	};

	case (_taskType in ["destroy_tanks","destroy_aa","destroy_artillery","destroy_cache","destroy_fuel","destroy_radio","destroy_radar"]): {
		waituntil {!alive _attachedUnit};
		_logic setvariable ["RscAttributeTaskState","Succeeded", true];
	};
};

_logic setvariable ["updated",true];
sleep 10;
deletevehicle _logic;