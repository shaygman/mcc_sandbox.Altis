//==================================================================MCC_fnc_countGroupHC===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group expand
// Example: [_group1] call MCC_fnc_countGroupHC;
// _group1 = group, the group name
//===========================================================================================================================================================================
private ["_group","_infantryCount","_vehicleCount","_tankCount","_airCount","_shipCount","_vehiclePic","_pic","_tankPic","_airPic","_boatPic","_vehicleClass","_reconCount","_supportPic","_supportCount","_autonomousCount","_autonomousPic"];

_group 			=  param [0,grpNull,[grpNull]];

if (isNull _group) exitWith {};



_infantryCount 	= 0;
_reconCount		= 0;

_CarCount		= 0;
_tankCount		= 0;
_supportCount	= 0;
_airCount		= 0;
_shipCount		= 0;
_autonomousCount= 0;
_SoldierCargo	= 0;


_tempVehicles		= [];
_vehiclePic			= [];
_tankPic			= [];
_airPic 			= [];
_boatPic 			= [];
_supportPic			= [];
_autonomousPic		= [];


{
	if (alive _x) then {
		_class = typeof (vehicle _x);
		_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> _class >> "vehicleClass"));
		_SoldierCargo  = getNumber  (configFile >> "CfgVehicles" >> _class >> "transportSoldier");
		_simulation	= toLower (getText (configfile >> "CfgVehicles" >> _class  >> "simulation"));
		_pic = gettext (configFile >> "CfgVehicles" >> _class >> "picture");

		if ((vehicle _x) != _x) then {

			if (!((vehicle _x) in _tempVehicles) and !(_x in (assignedCargo vehicle _x))) then {

				_tempVehicles pushBack (vehicle _x);

				switch (true) do
				{
					case (_vehicleClass in ["car"]):
					{
						_CarCount = _CarCount + 1;
						_vehiclePic pushBack _pic;
					};

					case  (_vehicleClass in ["armored","support","static"]):
					{
						_tankCount = _tankCount + 1;
						_tankPic pushBack _pic;
					};

					case (_vehicleClass in ["air"]):
					{
						_airCount = _airCount + 1;
						_airPic pushBack _pic;
					};

					case (_vehicleClass in ["ship","submarine"]):
					{
						_shipCount = _shipCount + 1;
						_boatPic pushBack _pic;
					};

					case "support":
					{
						_supportCount = _supportCount + 1;
						_supportPic pushBack _pic;
					};

					case "autonomous":
					{
						_autonomousCount = _autonomousCount + 1;
						_autonomousPic pushBack _pic;
					};

					default
					{
						/* BRUTE FORCE IF NO CLASS */
						switch (true) do
						{
							case (_simulation in ["car","carx","motorcycle","motorcyclex"]):
							{
								_CarCount = _CarCount + 1;
								_vehiclePic pushBack _pic;
							};

							case (_simulation in ["tank","tankx"]):
							{
								_tankCount = _tankCount + 1;
								_tankPic pushBack _pic;
							};

							case (_simulation in ["helicopter","helicopterx","helicopterrtd","airplane","airplanex"]):
							{
								_airCount = _airCount + 1;
								_airPic pushBack _pic;
							};

							case (_simulation in ["ship","shipx","submarine","submarinex"]):
							{
								_shipCount = _shipCount + 1;
								_boatPic pushBack _pic;
							};
						};
					};
				};
			};
		};

		if (
					(format["%1", (assignedVehicleRole _x)]=="[]")
					or
					(format["%1", (assignedVehicleRole _x)]=='["Cargo"]')
			 )
		then {
			if (_vehicleClass in ["mendiver","menrecon","mensniper"]) then {
				_reconCount = _reconCount + 1
			} else {
				if (_simulation == "soldier") then {
					_infantryCount = _infantryCount + 1
				};
			};
		};
	};
} foreach (units _group);

[_infantryCount,_CarCount,_tankCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,[_vehiclePic,_tankPic,_airPic,_boatPic,_supportPic,_autonomousPic]];

