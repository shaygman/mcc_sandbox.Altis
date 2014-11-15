//===================================================================MCC_fnc_iedHit======================================================================================
// Handle damage when IED has been shoot or damaged
//==============================================================================================================================================================================	
private ["_damageType","_ied","_fakeIed","_dummyMarker","_damage","_return"];
_ied 		= _this select 0;
_fakeIed 	= _ied getvariable "fakeIed";
_damage		= _this select 2;
_damageType	= _this select 4;
_return 	= 0;

_fakeIed setdamage ((damage _fakeIed) + _damage); 
if (!alive _ied || !alive _fakeIed) exitwith {		//Remove the Disable IED action if it's allready disabled
		_fakeIed removeaction 0;
		_ied setvariable ["armed",true,true];
		_ied setvariable ["iedTrigered",true,true];
		_fakeIed removeEventhandler ["handleDamage",0];
	};	

if (_damageType in ["ClaymoreDirectionalMine_Remote_Ammo","DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo","pipebombExplosion","PipeBomb","ACE_DummyAmmo_Explosives"]) then {
	_fakeIed setdamage 1; 
	_ied setvariable ["armed",true,true];
	_ied setvariable ["iedTrigered",true,true];
	};														

_return