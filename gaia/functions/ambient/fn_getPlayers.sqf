//ARMA3Alpha function LV_fnc_getPlayers v1.0 - by SPUn / lostvar
//Returns array of all alive non-captive players
private["_all","_players"];
_players = [];
while{(count _players) == 0}do
{
  if (count (playableUnits)==0) then
  {_all = [player];}
  else
  {_all = playableUnits;};
  //Loop them
  {
    if(isPlayer _x)then{
      if((alive _x)&&(!captive _x))then{
        _players set[(count _players), _x];
      };
    };
  }forEach _all;
sleep 3;
};
_players
