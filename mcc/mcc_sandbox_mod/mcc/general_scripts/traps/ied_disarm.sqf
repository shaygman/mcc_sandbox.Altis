private ["_ied","_fakeIed","_men","_index","_rand","_randsound","_disarmTime", "_footer", "_html", "_break","_dummyMarker","_isEngineer"];
_fakeIed = _this select 0;
_ied = _fakeIed getvariable "realIed";

if (isnil "_ied") then
{
	_ied = _this select 0;
	_fakeIed = _ied getvariable "fakeIed";
}; 

_men = _this select 1;
_index = _this select 2;
_rand= random 1;
_randsound = random 10;
_isEngineer = getNumber(configFile >> "CfgVehicles" >> typeOf _men >> "canDeactivateMines");	//Check if is engineer

if (!alive _ied) exitwith {_fakeIed removeaction _index};	//Remove the Disable IED action if it's allready disabled
_disarmTime =  MCC_IEDDisarmTimeArray select (_ied getvariable "disarmTime"); 
_pos=[((getposATL _ied) select 0),(getposATL _ied) select 1,((getPosATL _ied) select 2)];

if (_men distance _ied <3) then 
	{
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		_break = false; 
		for [{_x=1},{_x<_disarmTime},{_x=_x+1}]  do //Create progress bar
			{
				_footer = [_x,_disarmTime] call MCC_fnc_countDownLine;
				//add header
				_html = "<t color='#818960' size='0.85' shadow='0' align='left'>" + "Disarm Timer" + "</t><br/><br/>";
				//add _text
				_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left'>" + "Do not move while attempting to disarm" + "</t>";
				//add _footer
				_html = _html + "<br/><br/><t color='#818960' size='0.85' shadow='0' align='right'>" + _footer + "</t>";
				sleep 1; 
				hintsilent parseText(_html);
				if ((animationState player)!="AinvPknlMstpSlayWrflDnon_medic") then {player playMove "AinvPknlMstpSlayWrflDnon_medic"};
				if ((_ied distance _men) > 5) then {_x = _disarmTime; _break = true}; //check if still close to the IED
			};
		//player switchMove "";	//Stop the animation
		player playMoveNow "AmovPknlMstpSlowWrflDnon";	

		if (_break) exitwith{};	//If moved to far from the IED

		if (_isEngineer==1) then	//If it is a bomb expert ;)
						{
							if (_rand > 0.20) then {
													hint "disarmed";
													if (_randsound > 5) then {[[[netid _men,_men], "disarm1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "disarm2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
													sleep 1;
													_ied setvariable ["armed",false,true];
													_ied removeAction _index;
													_dummyMarker = _ied getvariable "iedMarkerName"; 
													[[2,compile format ["deletemarkerlocal '%1';",_dummyMarker]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
													deletevehicle _ied;
													}
												else {
													if (_rand >0.05) then {
																		hint "Fail to disarm";
																		if (_randsound > 5) then {[[[netid _men,_men], "disarmfail1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "disarmfail2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
																		}
																	else {
																		hint "Critical fail start runing";
																		_ied removeAction _index;
																		if (_randsound > 5) then {[[[netid _men,_men], "disarmcrit1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "disarmcrit2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
																		_ied setvariable ["armed",false,true];
																		sleep 2 + random 3;
																		"SmallSecondary" createVehicle _pos;
																		sleep 2 + random 3;
																		_ied setvariable ["iedTrigered",true,true];
																		};
						}							}
						else {
							if (_rand > 0.70) then {	//If it isn't a bomb expert <*Kaboom*>
													hint "disarmed";
													if (_randsound > 5) then {[[[netid _men,_men], "disarm3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "disarm4"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
													sleep 1;
													_ied setvariable ["armed",false,true];
													_ied removeAction _index;
													_dummyMarker = _ied getvariable "iedMarkerName"; 
													[[2,compile format ["deletemarkerlocal '%1';",_dummyMarker]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
													deletevehicle _ied;
													}
												else {
												hint "Fail to disarm";
													if (_rand >0.3) then {
																		if (_randsound > 7) then {[[[netid _men,_men], "disarmfail1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP} else {[[[netid _men,_men], "disarmfail2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
																	} else {
																		hint "Critical fail start runing";
																		_ied removeAction _index;
																		if (_randsound > 5) then {[[[netid _men,_men], "disarmcrit1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP; player switchmove "";} else {[[[netid _men,_men], "disarmcrit2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP};
																		_ied setvariable ["armed",false,true];
																		sleep 3 + random 3;
																		"SmallSecondary" createVehicle _pos;
																		sleep 3 + random 3;
																		_ied setvariable ["iedTrigered",true,true];
																		};
																		 
													};
												
							};
	}
	else {hint "To far to disarm"};
						
																
