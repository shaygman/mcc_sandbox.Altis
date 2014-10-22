//ARMA3Alpha function LV_fnc_getPlayers v1.0 - by SPUn / lostvar
//Returns array of all alive non-captive players
private["_all","_players"];
_players 	= [];
_ActiveAmb= 0;
while{(count _players) == 0}do
{
  if (count (playableUnits)==0) then
  {_all = [player];}
  else
  {_all = playableUnits;};
  //Loop them
  {
    if(isPlayer _x)then{
      if((alive _x)&&(!captive _x))then
      {
        _player   = _x;
        _amount   = round(count(nearestObjects [_player, ["house"], 1000])/50);
        _ActiveAmb= (
        							{
        								(leader _x distance _player)<(MCC_GAIA_AMBIENT_maxRange+100)
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
  }forEach _all;
sleep 3;
};
_players
