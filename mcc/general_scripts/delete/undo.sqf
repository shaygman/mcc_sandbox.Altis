 /*
 if !mcc_isloading then 
			{
			mcc_safe = mcc_safe + FORMAT ["script_handler = [1] execVM '%1mcc\general_scripts\delete\undo.sqf';
								waitUntil {scriptDone script_handler};
								"
								, MCC_path
								];									
			};
*/
[[2, {
		if ((count MCC_lastSpawn)>0) then
		{
			if (typeName (MCC_lastSpawn select ((count MCC_lastSpawn)-1)) == "ARRAY") then
			{
				deleteVehicle ((MCC_lastSpawn select ((count MCC_lastSpawn)-1)) select 0);
				{deleteVehicle _x} forEach ((MCC_lastSpawn select ((count MCC_lastSpawn)-1)) select 1);
			}	
			else	
			{
				deleteVehicle (MCC_lastSpawn select ((count MCC_lastSpawn)-1));
			};
			
			MCC_lastSpawn resize ((count MCC_lastSpawn)-1); 
		};
	}] , "MCC_fnc_globalExecute", true, false] call BIS_fnc_MP;
	
 
 

