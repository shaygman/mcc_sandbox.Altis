//====================== Name Tags Loop ==================================
private ["_target","_distance","_string","_rank","_name","_picture","_driver","_gunner","_commander","_nameVehicle","_emptyPos","_health","_bars","_color","_isMedic"];
_distance = 300;

while {true} do {
	if (missionNamespace getvariable ["MCC_nameTags",false]) then {
		_blank = " ";
		_target = cursorTarget;

		//Name tags while pointing
		if ((side _target == side player) && (player distance _target) < _distance && (_target != vehicle player)) then {
			//Man show name and rank
			if (_target isKindOf "Man") then {
				_name = name _target;
				_rank = [_target,"texture"] call BIS_fnc_rankParams;
				_color = if (_target in units player) then {"#a8e748"} else {"#80ABCD"};

				if (missionNamespace getvariable ["CP_activated",false]) then {
					_isMedic = ((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman");
					_bars = "";

					_colorBar = _color;
					if (_isMedic && damage _target > 0.05) then {
						_health = floor (30 - (damage _target * 30));
						for "_i" from 1 to _health do {_bars = _bars +"|"};
						_colorBar = if (_health > 20) then {"#a8e748"} else {if (_health > 10) then {"#ffa500"} else {"#B71C1C"}};
					};

					_string = format ["<t font='puristaMedium' size='0.4' color='%5'><img size='0.45' image='%3'/><br/><img size='0.45' image='%1'/> %2 <br/></t><t size='0.4' color='%6'>%4</t>",_rank, _name, _target getvariable ["CP_roleImage", ""], _bars, _color,_colorBar];
				} else {
					_string = format ["<t font='puristaMedium' size='0.4' color='%3'><img size='0.45' image='%1'/><br/>%2</t>",_rank, _name, _color];
				};
			};

			//Vehicle show type name and name and rank of the commander or driver or gunner
			if (_target isKindOf "Car" || _target isKindOf "Tank" || _target isKindOf "Air") then {
				_nameVehicle = getText (configFile >> "CfgVehicles" >> (typeOf _target) >> "displayName");
				_picture = getText (configFile >> "cfgVehicles" >> (typeOf _target) >> "picture");
				_driver = if (!isnull (commander _target)) then	{
								commander _target;
							} else	{
								if (!isnull (driver _target)) then {
									driver _target;
								} else {
									gunner _target;
								}
							};
				_name = if (alive _driver) then {name _driver} else {"Unknown"};
				_rank = if (alive _driver) then {[_driver,"displayNameShort"] call BIS_fnc_rankParams} else {""};
				_string = format ["<t font='puristaMedium' size='0.4' color='#a8e748' underline='true'>%3 </t><img size='0.45' image='%4'/><br/><t font='puristaMedium' size='0.4' color='#a8e748'>%1. %2</t>",_rank, _name,_nameVehicle,_picture];
			};

			[_string,0.15,0.5,0.2,0,0,3] spawn BIS_fnc_dynamicText;
		};

		if (player != vehicle player) then {
			_nameVehicle 	= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "displayName");
			_picture 		= getText (configFile >> "cfgVehicles" >> (typeOf vehicle player) >> "picture");
			_driver 		= if (alive (driver vehicle player)) then {name (driver vehicle player)} else {"Empty"};
			_gunner 		= if (alive (gunner vehicle player)) then {name (gunner vehicle player)} else {"Empty"};
			_commander 		= if (alive (commander vehicle player)) then {name (commander vehicle player)} else {"Empty"};
			_emptyPos		= (vehicle player) emptyPositions "cargo";

			_string = format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748' underline='true'>%1 </t><img align='left' size='0.45' image='%2'/><br/>",_nameVehicle,_picture];
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Commander: %1 </t><br/>",_commander];
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Driver: %1 </t><br/>",_driver];
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Gunner: %1 </t><br/>",_gunner];
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>Empty Spaces: %1 </t><br/>",_emptyPos];

			[_string,1.2,0.8,0.5,0,0,4] spawn BIS_fnc_dynamicText;
		};
	};

	//Cover
	if (missionNameSpace getVariable ["MCC_cover",false]) then {
		[] call MCC_fnc_cover;
		//_null = execVM "mcc\fnc\actions\fn_cover.sqf";
	};

	sleep 0.1;
};