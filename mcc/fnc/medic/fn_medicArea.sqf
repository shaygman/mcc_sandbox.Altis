//=================================================================MCC_fnc_medicArea========================================================================================
//create a building as a medic area
//=============================================================================================================================================================================
private ["_building","_hitArray","_hitSelections","_damageNew"];
_building = _this;
_damageNew = 0;	//ammount of damage

while {alive _building} do
{
	{
		if (vehicle _x == _x && isTouchingGround _x) then
		{
			//unconcious
			if (_x getVariable ["MCC_medicUnconscious",true]) then {_x setVariable ["MCC_medicUnconscious",false,true]};

			//Bleeding
			if ((_x getVariable ["MCC_medicBleeding",0])>0) then {_x setVariable ["MCC_medicBleeding",0,true]};

			//Heal
			_hitArray = [];
			_hitSelections = ["HitHead","HitBody","hitHands","hitLegs"];

			{_hitArray pushBack (_unit getHitPointDamage _x)} foreach _hitSelections;
			_unit setDamage _damageNew;

			{
				_unit setHitPointDamage [_hitSelections select _foreachIndex, _damageNew];
			} forEach _hitArray;
		};
	} foreach (_building nearEntities ["CAManBase",50]);

	sleep 60 + random 60;
}