//ARMA3Alpha function LV_fnc_getPlayers v1.0 - by SPUn / lostvar
//Returns array of all alive non-captive players
private["_all","_players","_time","_grp"];
_players 	= [];
_ActiveAmb= 0;
_time 		= time;
_spotvalid= false;
_grp  		= grpNull;

while{(count _players) == 0}do
{
  if (count (playableUnits)==0) then
  {_all = [player];}
  else
  {_all = playableUnits;};
  //Loop them
  {
    
		if ((_time +30) > time ) then
		{
			_dummy = [(position (_all select 0))] call GAIA_fnc_ShowLocationOwner;
			_time = time;
		};

    if(isPlayer _x)then{
      if((alive _x)&&(!captive _x))then
      {
        
        _player   = _x;
        _spotValid = true;
        //check if the player is in a mcc zone
        {					
					if([position _player,str _x] call GAIA_fnc_IsInMarker)exitWith
					{_spotValid = false;};
				}forEach ([MCC_zones_numbers, { _x <1000}] call BIS_fnc_conditionalSelect);
				
				//we are on an allowed spot
				if _spotValid then
				{
	        _amount   = round(count(nearestObjects [_player, ["house"], 1000])/50);
	        _ActiveAmb= (
	        							{
	        								(leader _x distance _player)<(MCC_GAIA_AC_MAXRANGE+100)
	        								&&
	        								(_x getVariable ["GAIA_AMBIENT",false]) 
	        								&&
	        								isTouchingGround _player
	        							} count allgroups
	        						);
	        if ((_amount - _ActiveAmb)>0) then
	        { _players set[(count _players), _x];};
	      };
      };
    };
  }forEach _all;

//Delete old shit  
	{
		_delete = true;
		_grp    = _x;
		if (_grp getVariable ["GAIA_AMBIENT",false]) then
		{
			{
				if ([position _x,_dissapearDistance] call GAIA_fnc_isNearPlayer) exitWith {_delete = false;};					
			} forEach (units _grp);
			if _delete then 
			{
				//Delete all shit
				{deleteVehicle _x; sleep 0.3} foreach ([_grp] call  BIS_fnc_groupVehicles);
				{ deleteVehicle _x;sleep 0.3 }forEach units _grp;
				deletegroup _grp;
			};
		};
	}forEach allgroups;  
  
sleep 3;
};
_players
