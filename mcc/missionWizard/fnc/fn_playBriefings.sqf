/*======================================================MCC_fnc_playBriefings=========================================================================================================
// play breifings sounds in a row
// Example:[_sounds] call MCC_fnc_playBriefings;
// _sounds = ARRAY of ARRAY example [["soundName",_waitTime],["sound1",0.5],["sound2",0.2]]
//=======================================================================================================================================================================================*/
private ["_wait","_sounds"];

_sounds = param [0, [], [[]]];

//Sounds
for [{_x= 0},{_x < count _sounds},{_x = _x + 1}] do
{
	_sound 	= (_sounds select _x) select 0;
	_wait 	= (_sounds select _x) select 1;
	playSound _sound;
	sleep _wait;
};