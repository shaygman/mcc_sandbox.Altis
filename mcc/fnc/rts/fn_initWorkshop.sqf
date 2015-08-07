//=================================================================MCC_fnc_initWorkshop==============================================================================
//	Init workshop class building
//  Parameter(s):
//  	_side: SIDE		the building's side
//		_module: OBJECT the module itself
//==============================================================================================================================================================================
private ["_side","_module","_level","_anchor","_trg","_billboard","_helipad","_class","_billboardPos","_helipadPos"];
params ["_side", "_module"];

_level = _module getVariable ["mcc_constructionItemTypeLevel",1];
_anchor = _module getVariable ["mcc_construction_anchor",objNull];
_trg = _module getVariable ["mcc_construction_trigger",objNull];

//Start repair shop
if (isNull _trg) then {
	_trg = createTrigger ["EmptyDetector", getPos _anchor];
	_trg setTriggerArea [20, 20, 0, false];
	_trg setTriggerActivation ["ANY", "PRESENT", true];
	_module setVariable ["mcc_construction_trigger",_trg,true];
};

switch (_level) do {
    case 2: {
    	_class = "vehicle";
    	_billboardPos = [2.8,-2.1,-0.4];
    	_helipadPos = [10,4,-0.4];
	};
    case 3: {
    	_class = "tank";
    	_billboardPos = [2.8,-2.1,-0.4];
    	_helipadPos = [12,6,-0.4];
	};
	case 4: {
    	_class = "heli";
    	_billboardPos = [2,-2.1,-0.3];
    	_helipadPos = [11,9,-0.6];
	};
	case 5: {
    	_class = "jet";
    	_billboardPos = [2,-2.1,-0.3];
    	_helipadPos = [11,9,-0.6];
	};
	default {
    	_class = "";
	};
};

if (_class != "") then {
	_billboard = "Land_Noticeboard_F" createVehicle (_anchor modelToWorld [0,5,0]);
	_helipad = "Land_HelipadCircle_F" createVehicle (_anchor modelToWorld [0,15,0]);

	_billboard attachto [_anchor,_billboardPos];
	_helipad attachto [_anchor,_helipadPos];
	_helipad setVariable ["MCC_vehicleSpawnerHelipad",true,true];
	[[_billboard,[_class,_helipad]], "MCC_fnc_vehicleSpawnerInit", true, true] spawn BIS_fnc_MP;
};

//repair loop
[_trg,_module] spawn {
	private ["_trg","_level","_list","_module","_class","_fix","_vehicle","_damage"];
	params ["_trg", "_module"];

	waitUntil {time > 1};

	while {true} do {
	   	sleep 1;

		_level = _module getVariable ["mcc_constructionItemTypeLevel",1];
		_list = list _trg;
		switch (_level) do {
		    case 1: {
		    	_class = ["Car"];
		    	_damage = 0.4;
			};
		    case 2: {
		    	_class = ["Car","Motorcycle"];
		    	_damage = 0;
		    };
		    case 3: {
		    	_class = ["Car","Motorcycle","Tank","Ship"];
		    	_damage = 0;
		    };
		    case 4: {
		    	_class = ["Air"];
		    	_damage = 0;
		    };
		    case 5: {
		    	_class = ["Air"];
		    	_damage = 0;
		    };
		    default {
		    	_class = []
		    };
		};

		{
			_fix = false;
			_vehicle = _x;

			{
				if (_vehicle isKindOf _x) exitWith {_fix = true};
			} forEach _class;

			if (_fix) then {
				if (getDammage _vehicle > _damage) then {
					_vehicle setDamage ((getDammage _vehicle - 0.005) max 0);
					_vehicle setVariable ["MCC_ingameText","Repairing",true];
				};
			};
		} forEach _list;
	};
};



