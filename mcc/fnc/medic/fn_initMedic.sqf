//==================================================================MCC_fnc_initMedic============================================================================================
// init MCC medic system
//===============================================================================================================================================================================
private ["_maxBleeding","_bleeding","_remaineBlood","_unit"];

//Add eh to local players and AI and look for new spawns
0 spawn
{
	_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
	while {true} do {
		{
			_unit = _x;
			if (local _unit) then {
				//Initate medic system and replace BI default items
				if (_unit isKindOf "CAManBase" && alive _unit && !(_unit getVariable ["MCC_medicEHstarted",false])) then {
					_unit setVariable ["MCC_medicEHstarted",true,true];
					_unit addEventHandler ["HandleDamage", {_this call MCC_fnc_handleDamage}];
					if !(isPlayer _unit) then {
						_unit addEventHandler ["HandleHeal",{(_this select 0) setVariable ["MCC_medicBleeding",0,true];false}];
					};

					_unit spawn	{
						//Gear scripts exc
						sleep 5;
						if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
							{
								if (_x == "FirstAidKit") then {
									_this removeItem _x;
									{_this additem "MCC_bandage"} forEach [1,2];
								};
								if (_x == "Medikit") then {
									_this removeItem _x;
									{_this additem "MCC_bandage"} forEach [1,2,3,4,5,6,7,8,9,10,11,12];
									{_this additem "MCC_epipen"} forEach [1,2,3,4,5,6,7,8,9,10,11,12];
									{_this additem "MCC_salineBag"} forEach [1,2,3,4];
									_this additem "MCC_firstAidKit";
								};
							} forEach (items _this);
						};
					};
				};

				//Manage AI blood losse and bandaging
				if !(isPlayer _unit) then {
					_bleeding = _unit getVariable ["MCC_medicBleeding",0];
					_remaineBlood = _unit getvariable ["MCC_medicRemainBlood",_maxBleeding];
					if (_bleeding > 0.1) then
					{
						_remaineBlood = _remaineBlood - (_bleeding*10);
						if (_remaineBlood <= 0) then
						{
							_unit setDamage 1
						}
						else
						{
							if ((_remaineBlood/_maxBleeding < 0.5 || (getDammage _unit)>0.3) && random 1 >0.5) then
							{
								if ("FirstAidKit" in (items _unit)) then
								{
									_unit removeItem "FirstAidKit";
									_unit action ["HealSoldierSelf", _unit];
									_unit setVariable ["MCC_medicBleeding",0,true];
								}
								else
								{
									if ("MCC_bandage" in (items _unit)) then
									{
										_unit removeItem "MCC_bandage";
										_unit addItem "FirstAidKit";
										_unit action ["HealSoldierSelf", _unit];
										_unit setVariable ["MCC_medicBleeding",0,true];
									};
								};
							};
						};
					} else {
						if (_remaineBlood < _maxBleeding) then {_remaineBlood = _remaineBlood + 0.1};
					};

					_unit setvariable ["MCC_medicRemainBlood",_remaineBlood,true];
				};
			};
		} foreach allUnits;

		sleep 10;
	};
};
