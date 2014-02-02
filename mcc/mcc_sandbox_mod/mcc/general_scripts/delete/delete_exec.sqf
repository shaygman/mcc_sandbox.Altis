private ["_pos","_radius","_type","_nearObjects","_crew"];

_pos = _this select 0;
_radius = _this select 1;
_type =  ["All","All Units", "Man", "Car", "Tank", "Air", "ReammoBox"] select (_this select 2); 

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
		default	
			{
				_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects [_type, _radius];
			};
	};
		
{
	if ((_x iskindof "Car") || (_x iskindof "Tank") || (_x iskindof "Air")) then {
			_crew = crew _x;
			deletevehicle _x;
			{deletevehicle _x} foreach _crew;
		} else	{deletevehicle _x};

} foreach _nearObjects;


 
 

