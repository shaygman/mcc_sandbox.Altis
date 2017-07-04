//======================================================MCC_fnc_customTasks=====================================================================================================
// Manage custom tasks
// Example:[_logic] spawn MCC_fnc_customTasks;
// Return - nothing
//==============================================================================================================================================================================
private ["_logic","_attachedUnit","_owners","_taskState","_taskStateDestination","_taskDescription","_taskType","_trg","_name","_desc","_missionDone"];
_logic = param [0, objNull, [objNull]];
_side = param [1, east];
_maxObjectivesDistance = param [2, 400, [0]];

waituntil {!alive _logic || _logic getvariable ["updated",false]};

if (!alive _logic) exitWith {};

_attachedUnit 			= _logic getvariable ["AttachObject_object",objnull];
_owners 				= _logic getvariable ["RscAttributeOwners",[]];
_taskState 				= _logic getvariable ["RscAttributeTaskState","created"];
_taskStateDestination 	= _logic getvariable ["RscAttributeTaskDestination",0];
_taskDescription 		= _logic getvariable ["RscAttributeTaskDescription",["","", ""]];
_taskType				= _logic getvariable ["customTask",""];

//add the task to the mission counter
{
	missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_total",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_total",_x],0])+1];
} forEach _owners;

//Not a custom task? exit
if (_taskType == "") exitWith {};

switch (true) do {
	case (_taskType in ["Secure_HVT"]): {
		waituntil {!alive _attachedUnit || isPlayer leader _attachedUnit || !(isNull attachedTo _attachedUnit)};

		if (alive _attachedUnit && (side leader _attachedUnit in _owners)) then {
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
						missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(side leader _attachedUnit)],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(side leader _attachedUnit)],0])+1];
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
					missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",(side leader _attachedUnit)],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",(side leader _attachedUnit)],0])+1];
					_missionDone = true;
				};

				sleep 5;
			};
		} else {
			_logic setvariable ["RscAttributeTaskState","Failed", true];
			missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",(side leader _attachedUnit)],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",(side leader _attachedUnit)],0])+1];
		};
	};

	case (_taskType in ["Kill_HVT","destroy_tanks","destroy_aa","destroy_artillery","destroy_cache","destroy_fuel","destroy_radio","destroy_radar"]): {
		waituntil {!alive _attachedUnit || isPlayer leader _attachedUnit};
		_logic setvariable ["RscAttributeTaskState","Succeeded", true];

		{
			missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_succeed",_x],0])+1];
		} forEach [west,east,resistance];
	};

	case (_taskType in ["disableIED"]): {
		waituntil {isnull _attachedUnit || (_attachedUnit getvariable ["iedTrigered",false])};
		if (isNull _attachedUnit) then {
			_logic setvariable ["RscAttributeTaskState","Succeeded", true];

			{
				missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_succeed",_x],0])+1];
			} forEach [west,east,resistance];
		} else {
			_logic setvariable ["RscAttributeTaskState","Failed", true];

			{
				missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],0])+1];
			} forEach [west,east,resistance];
		};
	};

	case (_taskType in ["pick_intel"]): {
		waituntil {isnull _attachedUnit};
		sleep 5;
		if (isNull _attachedUnit && ((missionNamespace getVariable ["MCC_pickItem",sideLogic]) in _owners)) then {
			_logic setvariable ["RscAttributeTaskState","Succeeded", true];

			missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(missionNamespace getVariable ["MCC_pickItem",sideUnknown])],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(missionNamespace getVariable ["MCC_pickItem",sideUnknown])],0])+1];
		} else {
			_logic setvariable ["RscAttributeTaskState","Failed", true];

			{
				missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],0])+1];
			} forEach ([west,east,resistance] - [(missionNamespace getVariable ["MCC_pickItem",sideUnknown])]);
		};
	};

	case (_taskType in ["clear_area"]): {
		waitUntil {!simulationEnabled _logic};
		_logic setVariable ["SucceededSide",[(_logic getvariable ["owner",sideLogic])],true];

		//succeed side
		missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(_logic getvariable ["owner",sideLogic])],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_succeed",(_logic getvariable ["owner",sideLogic])],0])+1];

		//Failed side
		{
			missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],(missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",_x],0])+1];
		} forEach ([west,east,resistance] - [(_logic getvariable ["owner",sideLogic])]);

		//if capture area then capture it
		[position _logic,(_logic getvariable ["radius",200])*3,(_logic getvariable ["owner",sideLogic]),0.2,[]] spawn MCC_fnc_campaignPaintMarkers;

		_logic setvariable ["RscAttributeTaskState","Succeeded", true];
	};
};

if (!isNull _logic) then {
	_logic setvariable ["updated",true];
	sleep 30;
	deletevehicle _logic;
};