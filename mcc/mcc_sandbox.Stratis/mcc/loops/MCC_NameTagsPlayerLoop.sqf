//====================== Name Tags Loop ==================================
private ["_target","_distance","_string","_rank","_name","_picture","_driver","_gunner","_commander"]; 
_distance = 100;

if (isnil "MCC_nameTags") then (MCC_nameTags = false); 
while {true} do 
{
	if (MCC_nameTags) then
	{
		if (player == vehicle player) then	//Name tags while pointing
		{
			_blank = " ";
			_target = cursorTarget;

			if (_target isKindOf "Man") then
			{
				if ((side _target == side player) && (player distance _target) < _distance) then
				{
					_name = name _target;
					_rank = [_target,"displayNameShort"] call BIS_fnc_rankParams;
					_string = format ["<t size='0.5' color='#f0e68c'>%1. </t><t size='0.5' color='#f0e68c'>%2</t>",_rank, _name];
					[_string,0.55,0.8,0.5,0,0,3] spawn BIS_fnc_dynamicText;
				};
			};
			
		} 
		else							//Vehicle passengers list
		{
			_name = getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "displayName");
			_picture = getText (configFile >> "cfgVehicles" >> (typeOf vehicle player) >> "picture");
			_driver = driver _target;
			_gunner =  gunner _target;
			_commander = commander _target;
		};
		
			

		// Main Driver / GUNNER / COMMANDER Check

		
												if (Alive _driver) then
												{	
		
												_driver = name _driver;
												}
												else
												{
												_driver = "No Driver";
												};

												
												if (Alive _gunner) then
												{	
		
												_gunner = name _gunner;
												}
												else
												{
												_gunner = "No gunner";
												};
												
												
												if (Alive _commander) then
												{	
		
												_commander = name _commander;
												}
												else
												{
												_commander = "No Commander";
												};
		// PASSENGER/CARGO COUNT 

					_freePassengerSpaces = _target emptyPositions "cargo";

					_passengerSpaces = getNumber (configFile >> "CfgVehicles" >>(typeOf _target) >> "transportSoldier");
				

		// SETTING UP THE NAME AND IMAGE FORMATION
									_driver = format ["%1 %2 <img size='0.35' color='#7FFF70' image='images\crew_driver.paa'/><br/>",_blank, _driver];
									_gunner = format ["%1 %2 <img size='0.35' color='#7FFF70' image='images\crew_gunner.paa'/><br/>",_blank,_gunner];
									_commander = format ["%1 %2 <img size='0.35' color='#7FFF70' image='images\crew_commander.paa'/><br/>",_blank,_commander];
									_cargo = format ["%1 / %2 <img size='0.35' color='#7FFF70' image='images\crew_cargo.paa'/><br/>",_freePassengerSpaces, _passengerSpaces];
									
		// PRINTING OUT ON SCREEN. TO MOVE POSITION, CHANGE THE X,Y CORODINATES AFTER _printname WITHIN THE DYNAMICTEXT 
							_printname = format ["<t size='0.5' color='#f0e68c'>%1 / </t><img size='0.45' image='%5'/><br/><t size='0.5' color='#f0e68c'>%2</t><t size='0.5' color='#f0e68c'>%3</t><t size='0.5' color='#f0e68c'>%6</t><t size='0.5' color='#f0e68c'>%4</t>", _label, _driver, _gunner, _cargo,_picture,_commander];

							[_printname,0.5,0.9,_refresh,0,0,3] spawn bis_fnc_dynamicText;
							
					};
			};
	};
};
