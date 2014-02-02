// Loop only on players for saving data
MCC_groupLocalWP = [];
MCC_groupLocalWPLines = []; 

private ["_wpArray"]; 
while {true} do 
{
	if (alive player) then 
		{
			MCC_save_Backpack = backPackItems player;
			MCC_save_primaryWeaponItems = primaryWeaponItems player;
			MCC_save_secondaryWeaponItems = secondaryWeaponItems player;
			MCC_save_handgunitems = handgunItems player;
			
			CP_rating = rating player;
			if (CP_activated) then {[] call CP_fnc_allowedDrivers}; 
			
			
			if (MCC_ConsolePlayersCanSeeWPonMap) then	//Draw WP 
			{
				//Have GPS
				 if  ("ItemGPS" in (assignedItems player) || "B_UavTerminal" in (assignedItems player) || "MCC_Console" in (assignedItems player)) then
				 {
					//Delete previous lines and WP
					{deletemarkerlocal _x} foreach MCC_groupLocalWP;
					MCC_groupLocalWP = []; 
					{deletemarkerlocal _x} foreach MCC_groupLocalWPLines;
					MCC_groupLocalWPLines = [];
					
					//Lets create new one
					_wpArray = waypoints (group player);
					if (count _wpArray > 0) then
					{
						private ["_wp","_wPos","_wType"];
						MCC_lastPos = nil; 
						for [{_i=0},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
						{			
							_wp = (_wpArray select _i);
							_wPos  = waypointPosition _wp;
							_wType = waypointType _wp;
							createMarkerLocal [format["%1", _wp],_wPos];
							format["%1", _wp] setMarkerTypelocal "waypoint";
							format["%1", _wp] setMarkerColorlocal "ColorBlue";
							format["%1", _wp] setMarkerTextLocal (format ["%1",_wType]);
							MCC_groupLocalWP set [count MCC_groupLocalWP, format["%1", _wp]];
							if (isnil "MCC_lastPos") then {MCC_lastPos = [(getpos player) select 0,(getpos player) select 1]}; 
							[MCC_lastPos , _wPos ,format ["%1", _i]] call MCC_fnc_drawLine;	//draw the line
							MCC_groupLocalWPLines set [count MCC_groupLocalWPLines, format["line_%1", _i]];
							MCC_lastPos = _wPos; 
						};
					};
				};
			};
		};
	sleep 20;
};
