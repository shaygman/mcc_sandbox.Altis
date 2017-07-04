//==================================================================MCC_fnc_populateVehicle===============================================================================================
//Populate a not empty vehicle with antoher group contains units acording to its faction and cargo space
// Example:[_vehicle]  call MCC_fnc_populateVehicle;
// <IN>
//	_vehicle:					Object- vehicle to populate
//
// <OUT>
//		nothing
//===========================================================================================================================================================================
private["_pos","_vehicle","_cargoNum","_fillSlots","_locGr","_convoyGroupArray","_group","_unitsArray","_type","_unit"];
_vehicle = _this select 0;
_pos = getPosATL _vehicle;

//Define Stuff
_convoyGroupArray = [];

 //Find cargo space
_cargoNum = [typeOf _vehicle, "allCargo"] call MCC_fnc_crewCount;;

if (_cargoNum > 2) then {
	// random but at least majority of seats occupied
	_fillSlots = _cargoNum - (round random (_cargoNum/4));
	_locGr =  _pos findEmptyPosition [10, 100];

	sleep 0.1;
	if (_locGr select 0 > 0)then {
		// Check if default group config is available
		// get group configs
		{
			if ( ((_x select 3) == "Rifle Squad") || ((_x select 3) == "Recon Team") ) then
			{
				_convoyGroupArray set [count _convoyGroupArray, format ["%1", ( _x select 2)]];
			};
		} forEach ([side _vehicle, faction _vehicle, "Infantry", "LAND"] call mcc_make_array_grps);

		While { true } do {

			if !( (count _convoyGroupArray) == 0 ) then {
				_group = [_locGr, side _vehicle, (call compile (_convoyGroupArray select 0)),[],[],[0.1,(missionNamespace getVariable ["MCC_AI_Skill",0.5])],[],[_fillSlots, 0]] call MCC_fnc_spawnGroup;
				sleep 0.1;
			} else {
				// no default groups found so let's build the faction custom unit's array
				_unitsArray = [];

				{
					_unitsArray	set [ count _unitsArray, _x select 0];
				} foreach ( [faction _vehicle,"soldier"] call MCC_fnc_makeUnitsArray );


				if !( (count _unitsArray) == 0 ) then {
					_group = creategroup side _vehicle;
					for [{_i=1},{_i<=_fillSlots},{_i=_i+1}] do {
						// select random type soldier - assuming pilots, divers etc are above type #5 in the array
						_type = _unitsArray select round (random (5 min (count _unitsArray-1)));
						_unit = _group createUnit [_type, _locGr, [], 0.5, "NONE"];
						sleep 0.1;
					};
				};
			};

			{
				_unit = _x;
				_unit assignAsCargo _vehicle;
				[_unit] orderGetIn true;
				_unit moveInCargo _vehicle;
				{_x addCuratorEditableObjects [[_unit],false]} forEach allCurators;
			} forEach units _group;

			_fillSlots = _fillSlots - (count units _group);

			// if only 1 seat left do not create a 1 man group but leave seat empty
			if ( _fillSlots < 2 ) exitWith {};
		};


		[_vehicle, _group] spawn
		{
			private ["_vehicle","_group"];
			_vehicle = _this select 0;
			_group = _this select 1;

			sleep 15;
			//Delete not needed units
			{if ((_vehicle getCargoIndex _x) == -1) then {deleteVehicle _x}} foreach units _group;
		};
	};
};

