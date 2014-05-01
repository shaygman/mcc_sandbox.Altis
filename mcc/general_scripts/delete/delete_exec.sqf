private ["_pos","_radius","_type","_nearObjects","_crew","_markers"];

_pos = _this select 0;
_radius = _this select 1;
_type =  ["All","All Units", "Man", "Car", "Tank", "Air", "ReammoBox","Markers","Lights","N/V","Bodies","Flashlights"] select (_this select 2); 
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
		deletevehicle _x;
	};
} foreach _nearObjects;


 
 

