
/*
_civm  							= [];
_civc  							= [];
_Civs 							= ["CIV_F" ,"soldier","men"] call MCC_fnc_makeUnitsArray;
_civc 							= ["CIV_F" ,"carx"] call MCC_fnc_makeUnitsArray;
_civMax 						= 20;

_grp							 	= grpNull;
_GrpUnit					 	= [];
_pos								= [];
_minrange						= (MCC_GAIA_AC_MAXRANGE - 200);

while{true}do
{
  //Check the houses
	{
		_pos = position _x;
		_distance = (_x distance player);
		if (
					(_distance<MCC_GAIA_AC_MAXRANGE)
					and 
					(_distance>_minrange ) 
					and
					!([_pos,_minrange] call GAIA_fnc_isNearPlayer)
			 )
			then
			{
				_simu 		= [["soldier", "carx"],[1,0.4]] call BIS_fnc_selectRandomWeighted;
				if (_simu == "soldier") then
				{
					_grp = [(position _x), civilian, [((_Civs select (floor random (count _Civs)))select 0)]] call BIS_fnc_spawnGroup;
					hint "civvie is there";
					sleep 3;
				};
			};
	}
	foreach (nearObjects [player, ["house"], _minrange]);

};

*/