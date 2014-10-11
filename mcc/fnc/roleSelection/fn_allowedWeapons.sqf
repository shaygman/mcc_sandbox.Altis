//==================================================================MCC_fnc_allowedWeapons======================================================================================
// Check if the player is in vehicle while he is not a pilot or a crewman
//==============================================================================================================================================================================	
private ["_curWeapon","_role","_playerVehicle","_type","_cursor","_drop","_neededRole","_camShake"];
_drop			= false; 
_neededRole		= ""; 
_role 			= tolower (player getvariable ["CP_role","n/a"]);	
_playerVehicle	= vehicle player; 

//Allowed weapons check
if (_playerVehicle == player) then	
{
	_curWeapon 	= currentWeapon player; 
	_type		= getNumber(configFile >> "CfgWeapons" >> _curWeapon >> "type");
	_cursor		= getText(configFile >> "CfgWeapons" >> _curWeapon >> "cursor");
	
	//AT	
	if (_role != "AT" && _type == 4) then
	{
		_drop = true; 
		_neededRole = "an AT"; 
	};
	
	//Marksman	
	if (_role != "Marksman" && _cursor == "srifle") then
	{
		_drop = true; 
		_neededRole = "a Marksman"; 
	};
	
	//AR
	if (_role != "AR" && _cursor == "mg") then
	{
		_drop = true; 
		_neededRole = "an Automatic-rifleman"; 
	};
	
	_camShake = player getVariable ["MCC_camShake",false]; 
	
	//Not allowed 
	if (_drop) then	
	{
		if (!_camShake) then
		{
			cutText [format ["You need to be %1 inorder to use this weapon, you'll suffer from increased weapon sway",_neededRole],"Plain Down",0.5];
			addCamShake [2, 999, 0.7];
			player setVariable ["MCC_camShake",true]; 
		};
	}
	else
	{
		resetCamShake;
		player setVariable ["MCC_camShake",false]; 
	};
};