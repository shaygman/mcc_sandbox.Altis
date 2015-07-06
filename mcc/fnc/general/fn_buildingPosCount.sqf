//========================================================MCC_fnc_buildingPosCount===============================================================================================
// return the ammount of indexed positions in a building
// Example:_buildingPos = _building call MCC_fnc_buildingPosCount;
// _building = building, the building to check for positions.
// _buildingPos = integer, the ammount of indexed positions
//===============================================================================================================================================================================
private ["_x"];
_x = 0;
while { format ["%1", _this buildingPos _x] != "[0,0,0]" } do	{_x = _x + 1};
_x


