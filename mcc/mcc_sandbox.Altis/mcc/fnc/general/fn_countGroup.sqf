//==================================================================MCC_fnc_countGroup===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group
// Example: [_group1] call MCC_fnc_countGroup;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_group","_infantryCount","_vehicleCount","_tankCount","_airCount","_shipCount","_tempVehicles","_vehiclePic",
		 "_pic","_tankPic","_airPic","_boatPic"];

_group 			= _this select 0; 
_infantryCount 	= 0;
_vehicleCount	= 0;
_tankCount		= 0;
_airCount		= 0;
_shipCount		= 0;
_tempVehicles	= [];
_vehiclePic		= []; 
_tankPic		= []; 
_airPic			= []; 
_boatPic		= []; 

if (! isnil "_group") then {
	{
		if ((vehicle _x) != _x) then {
			if (!((vehicle _x) in _tempVehicles)) then {
				_tempVehicles set [count _tempVehicles, vehicle _x];
				_pic = gettext (configFile >> "CfgVehicles" >> typeof (vehicle _x) >> "picture"); 
				if ((vehicle _x) iskindof "Car") then 
					{
						_vehicleCount = _vehicleCount + 1;
						_vehiclePic set [count _vehiclePic,_pic];
					};
				if ((vehicle _x) iskindof "Tank") then 
					{
						_tankCount = _tankCount + 1;
						_tankPic set [count _tankPic,_pic];
					};
				if ((vehicle _x) iskindof "Air") then 
					{
						_airCount = _airCount + 1;
						_airPic set [count _airPic,_pic];
					};
				if ((vehicle _x) iskindof "Boat") then
					{
						_shipCount = _shipCount + 1;
						_boatPic set [count _boatPic,_pic];
					};
				
				 
				};
			} else	{
				_infantryCount = _infantryCount + 1; 
				};
	} foreach units _group; 
	
	[_infantryCount,_vehicleCount,_tankCount,_airCount,_shipCount,[_vehiclePic,_tankPic,_airPic,_boatPic]];
};
