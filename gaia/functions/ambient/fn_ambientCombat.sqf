/*
				Origal idea by : ***		ARMA3Alpha AMBIENT COMBAT SCRIPT v2.5 - by SPUn / lostvar	***
				Rewritten by 	 : Spirit, MCC GAIA functionality.
				
			Creates ambient combat around defined objects/units with multiple customizable features.
			
		Calling the script:
		
				default: 	nul = [] execVM "LV\ambientCombat.sqf";
		
								
	Parameters:
		

					
*/
// Take it easy as long as the show has not started.
while {!(MCC_GAIA_AC)} do 
{
    sleep 10;
};

if (isServer) then {[] spawn GAIA_FNC_ambientCombatServer;};
/*
_IsSingleplayer 		= !isMultiplayer && isServer && !isDedicated;
_isMultiplayerHost  = isMultiplayer && isServer && !isDedicated;
_IsMultiplayerClient= isMultiplayer && !isServer && !isDedicated;

if (_IsSingleplayer or _isMultiplayerHost or _IsMultiplayerClient) then {[] spawn GAIA_FNC_ambientCombatClient;};
*/