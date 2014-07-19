private ["_damageType","_ied","_fakeIed","_dummyMarker","_damage"];
_ied 		= _this select 0;
_fakeIed 	= _ied getvariable "fakeIed";
_damage		= _this select 2;
_damageType	= _this select 4;

//player sidechat format ["fakeIED: %1 , DamageDone: %2, Damage: %3, DamageType: %5",_fakeIed,_damage,(damage _fakeIed),_damageType];
_fakeIed setdamage ((damage _fakeIed) + _damage); 
if (!alive _ied || !alive _fakeIed) exitwith {		//Remove the Disable IED action if it's allready disabled
		_fakeIed removeaction 0;
		_ied setvariable ["armed",true,true];
		_ied setvariable ["iedTrigered",true,true];
		_fakeIed removeEventhandler ["handleDamage",0];
	};	

if (_damageType == "ClaymoreDirectionalMine_Remote_Ammo" || _damageType == "DemoCharge_Remote_Ammo" || _damageType == "SatchelCharge_Remote_Ammo" || _damageType == "pipebombExplosion"
	 || _damageType == "PipeBomb" || _damageType == "ACE_DummyAmmo_Explosives") then {
	_fakeIed setdamage 1; 
	_ied setvariable ["armed",true,true];
	_ied setvariable ["iedTrigered",true,true];
	};														
