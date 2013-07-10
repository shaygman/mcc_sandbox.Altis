private ["_damageType","_ied","_fakeIed","_dummyMarker"];
_fakeIed 	= _this select 0;
_ied 		= _fakeIed getvariable "realIed";
_damageType	= _this select 4;

if (!alive _ied || !alive _fakeIed) exitwith {_fakeIed removeaction _index;_ied setvariable ["armed",true,true];_ied setvariable ["iedTrigered",true,true];};	//Remove the Disable IED action if it's allready disabled

if (_damageType == "ClaymoreDirectionalMine_Remote_Ammo" || _damageType == "DemoCharge_Remote_Ammo" || _damageType == "SatchelCharge_Remote_Ammo" || _damageType == "pipebombExplosion"
	 || _damageType == "PipeBomb" || _damageType == "ACE_DummyAmmo_Explosives") then {
	_ied setvariable ["armed",true,true];
	_ied setvariable ["iedTrigered",true,true];
	};														
