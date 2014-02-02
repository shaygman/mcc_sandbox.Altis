private ["_dummyGroup", "_dummy", "_commander", "_type", "_side", "_sync", "_controller","_hc"];
_commander = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
_type = _this select 1;

if (_type ==0) then 
	{
	if (isnil {_commander getvariable "commander"}) then //if the unit isn't the commander
		{	
		if !((name _commander) == mcc_missionmaker) then {[[format ["%1 assigned as %2 commander",name _commander, side _commander]],"MCC_fnc_globalHint",true,true] spawn BIS_fnc_MP;};
		_commander setvariable ["commander", true, true];
		_dummyGroup = creategroup civilian; 
		switch (format ["%1", side _commander]) do 
			{
			case "EAST": //East
				{
				if (!isnil "HCEast") then	{
					_sync = synchronizedObjects HCEast;
					HCEast synchronizeObjectsRemove _sync;
					hcRemoveAllGroups HCEast;
					deletevehicle HCEast;
				};
				HCEast = _dummyGroup createunit ["HighCommand", getpos _commander,[],0,"NONE"];
				HCEast synchronizeObjectsAdd [_commander];
				publicvariable "HCEast"; 
				_hc = HCEast;
				}; 
				
			case "WEST": //West
				{
				if (!isnil "HCWest") then	{
					_sync = synchronizedObjects HCWest;
					HCWest synchronizeObjectsRemove _sync;
					hcRemoveAllGroups HCWest;
					deletevehicle HCWest;
				};
				HCWest = _dummyGroup createunit ["HighCommand", getpos _commander,[],0,"NONE"];
				HCWest synchronizeObjectsAdd [_commander];
				publicvariable "HCWest"; 
				_hc = HCWest;
				};
				
			case "GUER": //Resistance
				{
				if (!isnil "HCGuer") then	{
					_sync = synchronizedObjects HCGuer;
					HCGuer synchronizeObjectsRemove _sync;
					hcRemoveAllGroups HCGuer;
					deletevehicle HCGuer;
				};
				HCGuer = _dummyGroup createunit ["HighCommand", getpos _commander,[],0,"NONE"];
				HCGuer synchronizeObjectsAdd [_commander];
				publicvariable "HCGuer"; 
				_hc = HCGuer;
				};
			{if ((alive _x) && (side _x == side _commander)) then		//add all player from the same faction as subordante
				{
					_commander hcSetGroup [group _x];
				};
			} forEach  (switchableUnits + playableUnits);
			};
		} else {[[format ["%1 is allready assigned as %2 commander",name _commander, side _commander]],"MCC_fnc_globalHint",true,true] spawn BIS_fnc_MP;};
	};

if (_type == 1) then 	//Remove all
	{
	hcRemoveAllGroups _commander;
	};
	
if (_type == 2) then 	//Add Group
	{
	switch (format ["%1", side  _commander]) do 
		{
		case "EAST": //East
			{
			_controller = (synchronizedObjects HCEast) select 0;
			}; 
			
		case "WEST": //West
			{
			_controller = (synchronizedObjects HCWest) select 0;
			};
			
		case "GUER": //Resistance
			{
			_controller = (synchronizedObjects HCGuer) select 0;
			};
		};
	_controller hcSetGroup [group _commander];
	};
