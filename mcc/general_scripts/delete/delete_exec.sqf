private ["_pos","_radius","_type","_nearObjects","_crew","_markers"];

_pos = _this select 0;
_radius = _this select 1;
_type =  ["All","All Units", "Man", "Car", "Tank", "Air", "ReammoBox","Markers","Bodies","Lights","doorsAll","doorsRandom","doorsAllunlock","Buildings","sandstorm","storm","heatwave","clear","N/V","Flashlights"] select (_this select 2);
_nearObjects = [];

switch _type do
	{
		case "All":
			{
				_nearObjects =  [_pos select 0, _pos select 1, 0] nearObjects _radius;
			};
		case "All Units":
			{
				_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects ["Man", _radius];
				_nearObjects =_nearObjects + ([_pos select 0, _pos select 1, 0] nearObjects ["Car", _radius]);
				_nearObjects =_nearObjects + ([_pos select 0, _pos select 1, 0] nearObjects ["Tank", _radius]);
				_nearObjects =_nearObjects + ([_pos select 0, _pos select 1, 0] nearObjects ["Air", _radius]);
				_nearObjects =_nearObjects + ([_pos select 0, _pos select 1, 0] nearObjects ["ReammoBox", _radius]);
			};

		case "Markers":
			{
				//Markers
				_markers = [];
				{
					if (((getMarkerPos _x distance [_pos select 0, _pos select 1, 0]) < _radius) && !(getMarkerPos _x in mcc_zone_pos))
					then
					{
						_markers set [count _markers, _x];
					};
				} foreach allMapMarkers;

				{
					[2, "", "", "", "", "", _x, []] call MCC_fnc_makeMarker;
				} foreach _markers;
			};

		case "Lights":
			{
				private "_lamps";
				//Lights
				{
					_lamps = [_pos select 0, _pos select 1, 0] nearObjects [_x, _radius];
					sleep 1;
					{_x setDamage 1} forEach _lamps;
				} foreach ["Lamps_Base_F", "PowerLines_base_F"];
			};

		case "doorsAll":
			{
				private "_buildings";
				//Buildings
				_buildings = [_pos select 0, _pos select 1, 0] nearObjects ["house", _radius];

				{
					for [{_i=1},{_i<=15},{_i=_i+1}] do
					{
						_x setVariable [format ["bis_disabled_door_%1",_i],1,true];
					};
				} foreach _buildings;
			};

		case "doorsAllunlock":
			{
				private "_buildings";
				systemChat "inlock";
				//Buildings
				_buildings = [_pos select 0, _pos select 1, 0] nearObjects ["house", _radius];

				{
					for [{_i=1},{_i<=15},{_i=_i+1}] do
					{
						_x setVariable [format ["bis_disabled_door_%1",_i],0,true];
					};
				} foreach _buildings;
			};

		case "doorsRandom":
			{
				private "_buildings";
				//Buildings
				_buildings = [_pos select 0, _pos select 1, 0] nearObjects ["house", _radius];
				{
					for [{_i=1},{_i<=15},{_i=_i+1}] do
					{
						if (random 1 > 0.5) then {_x setVariable [format ["bis_disabled_door_%1",_i],1,true]};
					};
				} foreach _buildings;
			};

		case "Buildings":
			{
				private "_buildings";

				//Buildings
				_buildings = [_pos select 0, _pos select 1, 0] nearObjects ["house", _radius];
				sleep 1;
				{if ((random 1) > 0.4) then {_x setDamage 1}} forEach _buildings;

				//Objects
				_buildings = (nearestObjects [[_pos select 0, _pos select 1, 0],[], _radius]) - ([_pos select 0, _pos select 1, 0] nearObjects _radius);
				sleep 1;
				{if ((random 1) > 0.4) then {_x setDamage 1}} forEach _buildings;

				//create burning wrecks
				for [{_x=0},{_x<1+(floor _radius/20)},{_x=_x+1}] do
				{
					_wreck = (MCC_ied_wrecks select (random (count MCC_ied_wrecks-1))) select 1;
					_tempPos = [(_pos select 0) + ((random _radius)-(random _radius)) ,(_pos select 1) + ((random _radius)-(random _radius)),0];
					_dummy= _wreck createvehicle _tempPos;
					_dummy setdir (floor random 360);
					if ((random 1) > 0.5) then
					{
						_effect = (["test_EmptyObjectForFireBig","test_EmptyObjectForSmoke"]  call BIS_fnc_selectRandom)  createVehicle (getpos _dummy);
						_effect setpos (getpos _dummy);
					};
				};

				[["bf",false],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
			};

		case "sandstorm":
			{
				[["sandstorm",false],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
			};

		case "storm":
			{
				[["storm",false],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
			};

		case "heatwave":
			{
				[["heatwave",false],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
			};

		case "clear":
			{
				[["clear",false],"MCC_fnc_ppEffects",true,false] call BIS_fnc_MP;
			};

		case "N/V":
			{
				//Night Vision
				_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects ["Man", _radius];
				private "_unit";
				{
					_unit = _x;
					{
						_unit unassignItem _x;
						_unit removeItem _x;
					} foreach ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];
				} foreach _nearObjects;

				_nearObjects = [];
			};

		case "Bodies":
			{
				//Bodies
				{
					if ((_x distance [_pos select 0, _pos select 1, 0]) < _radius) then {_nearObjects set [count _nearObjects, _x]};
				} foreach allDeadMen;
			};

		case "Flashlights":
			{
				_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects ["Man", _radius];

				//Flashlight
				{
					if ("acc_flashlight" in primaryWeaponItems _x) then
					{
						_x enablegunlights "forceOn";
					}
					else
					{
						_x addPrimaryWeaponItem "acc_flashlight";
						_x enablegunlights "forceOn";
					};
				} foreach _nearObjects;

				_nearObjects = [];
			};


		default
			{
				_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects [_type, _radius];
			};
	};

{
	if ((_x iskindof "Car") || (_x iskindof "Tank") || (_x iskindof "Air")) then
	{
			_crew = crew _x;
			deletevehicle _x;
			{deletevehicle _x} foreach _crew;
	}
	else
	{
		if (_x getVariable ["mcc_delete",true]) then {deletevehicle _x};
	};
} foreach _nearObjects;





