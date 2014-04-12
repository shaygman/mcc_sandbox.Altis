//==================================================================CP_fnc_setValue======================================================================================
// Sets value on a specific player
// Example: [[_varName1,_varName2],[_value1,_value2],_id], "CP_fnc_setValue", true, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================	
private ["_varName","_id","_value"];
_varName 	= _this select 0;			
_value 		= _this select 1; 
_id			= _this select 2; 

if (getPlayerUID player == _id) then	
{
	if (typeName _value == "STRING") then
	{
		call compile format ["%1 = '%2';",_varName,_value];
	}
	else
	{
		call compile format ["%1=%2;",_varName,_value];
	};
};

