private ["_ied","_fakeIed","_men","_rand","_disarmTime", "_footer", "_html", "_break","_dummyMarker","_isEngineer"];
_men 		= _this select 0;
_ied 		= _this select 1;
if (isnil "_ied") exitWith {};

_fakeIed	= _ied getVariable["fakeIed",objNull];

_rand		= random 1;
_isEngineer = getNumber(configFile >> "CfgVehicles" >> typeOf _men >> "canDeactivateMines");	//Check if is engineer
_disarmTime =  _ied getvariable "MCC_disarmTime"; 
_pos=[((getposATL _ied) select 0),(getposATL _ied) select 1,((getPosATL _ied) select 2)];

if (_men distance _ied <3) then 
{
	uiNameSpace setVariable ["MCC_interactionActive",true]; 
	_ied setVariable ["MCC_isInteracted",true,true]; 
	player playMove "Acts_carFixingWheel";
	_break = false; 
	
	//Create progress bar
	for [{_x=1},{_x<_disarmTime},{_x=_x+1}]  do 
	{
		_footer = [_x,_disarmTime] call MCC_fnc_countDownLine;
		//add header
		_html = "<t color='#818960' size='0.85' shadow='0' underline = 'true' align='center'>" + "Disarming" + "</t><br/><br/>";
		//add _text
		_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left'>" + "Do not move while attempting to disarm" + "</t>";
		//add _footer
		_html = _html + "<br/><br/><t color='#818960' size='0.85' shadow='0' align='right'>" + _footer + "</t>";
		sleep 1; 
		hintsilent parseText(_html);
		if ((animationState player)!="Acts_carFixingWheel") then {player playMove "Acts_carFixingWheel"};
		if ((_ied distance _men) > 5) then {_x = _disarmTime; _break = true; hintSilent ""}; //check if still close to the IED
	};
	
	player switchMove "AmovPknlMstpSlowWrflDnon";	
	player playMoveNow "AmovPknlMstpSlowWrflDnon";	
	
	//If moved to far from the IED
	if (_break) exitwith
	{
		uiNameSpace setVariable ["MCC_interactionActive",false];
		_ied setVariable ["MCC_isInteracted",false,true]; 
	};	
	
	//If it is a bomb expert ;)
	if (_isEngineer==1) then	
	{
		if (_rand > 0.20) then 
		{
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			
			sleep 1;
			_ied setvariable ["armed",false,true];
			deletevehicle _ied;
			uiNameSpace setVariable ["MCC_interactionActive",false]; 
			_ied setVariable ["MCC_isInteracted",false,true]; 
		}
		else 
		{
			if (_rand >0.05) then 
			{
				hint "Fail to disarm";
				
				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			}
			else 
			{
				hint "Critical fail start runing";
				
				[[[netid _men,_men], format ["disarmcrit%1", (floor random 2)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				
				_ied setvariable ["armed",false,true];
				sleep 2 + random 3;
				"SmallSecondary" createVehicle _pos;
				sleep 2 + random 3;
				_ied setvariable ["iedTrigered",true,true];
			};
		}
	}
	else 
	{
		//If it isn't a bomb expert <*Kaboom*>
		if (_rand > 0.70) then 
		{	
			hint "disarmed";
			[[[netid _men,_men], format ["disarm%1", (floor random 7)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			
			sleep 1;
			_ied setvariable ["armed",false,true];
			deletevehicle _ied;
		}
		else 
		{
			hint "Fail to disarm";
			if (_rand >0.3) then 
			{
				[[[netid _men,_men], format ["disarmfail%1", (floor random 3)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			} 
			else 
			{
				hint "Critical fail start runing";
				
				[[[netid _men,_men], format ["disarmcrit%1", (floor random 2)+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				
				_ied setvariable ["armed",false,true];
				sleep 3 + random 3;
				"SmallSecondary" createVehicle _pos;
				sleep 3 + random 3;
				_ied setvariable ["iedTrigered",true,true];
			};
		};
	};
	
	uiNameSpace setVariable ["MCC_interactionActive",false]; 
	_ied setVariable ["MCC_isInteracted",false,true]; 
}
else {hint "To far to disarm"};
uiNameSpace setVariable ["MCC_interactionActive",false]; 
_ied setVariable ["MCC_isInteracted",false,true]; 
						
																
