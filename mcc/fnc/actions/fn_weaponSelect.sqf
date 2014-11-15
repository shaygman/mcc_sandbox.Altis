//==================================================================MCC_fnc_weaponSelect===============================================================================================
//Change weapons and throw utility
// Example: [] call MCC_fnc_weaponSelect;
//===========================================================================================================================================================================	
private ["_key"];
	
_key = _this select 0;
if (vehicle player != player) exitWith {};
switch (_key) do
{
	case 2:	
		{ 
		   if (primaryweapon player != "") then {player selectWeapon (primaryweapon player);
			};
		};
		
	case 3:	
		{ 
			if (handgunWeapon player != "") then {player selectWeapon (handgunWeapon player)};
		};	
		
	case 4:	
		{ 
			if (secondaryWeapon player != "") then {player selectWeapon (secondaryWeapon  player)};
		};
	case 5:	
		{ 
			if (({_x in items player} count ["MCC_ammoBoxMag"]) > 0) then 
			{
				0 = [] spawn
				{
					private ["_utility","_vel","_dir","_handPos","_item","_speed","_mag"];
					if ("MCC_ammoBoxMag" in items player) then
					{
						_mag 	= "MCC_ammoBoxMag";
						_item 	= "MCC_ammoBox";
						_speed 	= 1;
					};
					
					player removeItem _mag;
					player playactionNow "putdown";
					sleep 0.3;								
					_handPos = player selectionPosition "LeftHand"; 
					_utility = _item createvehiclelocal (player modelToWorld [(_handPos select 0),(_handPos select 1)+1.8,(_handPos select 2)]);
					_utility setpos (player modelToWorld [(_handPos select 0),(_handPos select 1)+1.8,(_handPos select 2)]);
					/*
					_vel = velocity player;
					_dir = direction player;

					_utility setVelocity [
						(_vel select 0) + (sin _dir * _speed), 
						(_vel select 1) + (cos _dir * _speed), 
						_speed
					];
					*/
				};
			};
		};
};