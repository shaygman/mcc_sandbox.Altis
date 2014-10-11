private ["_suspect","_men","_index","_rand"];
_suspect = _this select 0;
_men = _this select 1;
_index = _this select 2;
_rand= random 10;

if (!MCC_natureIsRuning) then
{
	uiNameSpace setVariable ["MCC_isIEDDisarming",true];  
	if (_men distance _suspect <=10) then 
	{
		[[[netid _suspect,_suspect], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		player sidechat "ok"; 
		[[2,getpos _suspect,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _suspect)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;
		_suspect doTarget _men;
		(group _suspect) setFormDir ([_suspect,_men] call BIS_fnc_dirTo);
		doStop _suspect;
		_suspect disableAI "MOVE";
		
		sleep 2;
		if (_rand < (5 * ((_suspect skill "courage")+1))) then 
		{
			[[[netid _suspect,_suspect], format ["enough%1",floor random 14]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			removeAllWeapons _suspect;
			_suspect setUnitPos "DOWN";
			_suspect setvariable ["armed",false,true];
			sleep 1;
			{
			  deleteVehicle _x;
			} forEach attachedObjects _suspect;
			
			_suspect enableAI "MOVE";
			_suspect addaction ["<t color=""#FF0000"">- Secure Suspect -</t>",MCC_path +"mcc\general_scripts\hostages\hostage.sqf",[2],6,true,true,"","(_target distance _this) < 10"];
		} 
		else
		{
			[[[netid _suspect,_suspect], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			player sidechat "ok"; 
			sleep 1;
		};
		
		uiNameSpace setVariable ["MCC_isIEDDisarming",false]; 		
	}
	else {hint "To far to neutralize"};
};
							
																
