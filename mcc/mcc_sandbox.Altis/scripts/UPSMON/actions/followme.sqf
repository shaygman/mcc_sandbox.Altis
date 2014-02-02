// =========================================================================================================
//  Script for action follow me when surrended,  adds the soldier to player squad in a random choice.
//  Version: 1.0 
//  Author: Monsada (smirall@hotmail.com)
// ---------------------------------------------------------------------------------------------------------
private ["_obj","_caller","_id","_objtype","_rnd","_join","_direction"];
_npc = _this select 0;
_caller = _this select 1;
_id 	= _this select 2;

_rnd = 0;
_join=true;
_npc switchmove "";	

_direction = ((getpos _caller select 0) - (getpos _npc select 0)) atan2 ((getpos _caller select 1) - (getpos _npc select 1));

//If positive values are needed then use:
if(_direction < 0) then {_direction = _direction + 360}; 
_npc setdir _direction;
_npc dowatch _caller;
_npc setSpeedMode "LIMITED";
_npc domove position _caller;	

	
sleep 0.5;

_rnd = random 100;
_npc setmimic "Sad";

if (_rnd <= 30 ) then {
	_npc globalchat "Ok";
};

if (_rnd > 30  && _rnd <= 50) then {
	_npc globalchat "Yes";	
};


if (_rnd > 50  && _rnd <= 100) then {
	_join=false;	
	_rnd = random 100;	
	
	if (_rnd < 20) then {
		_npc setmimic "angry";
		_npc switchmove "CtsPercMstpSnonWnonDnon_idle31rejpaniVnose";	
		_npc globalchat "Kiss my ass";		
	};

	if (_rnd > 20  && _rnd <= 40) then {
		_npc setmimic "Agresive";	
		_npc switchmove "CtsPercMstpSnonWnonDnon_idle33rejpaniVzadku";	
		sleep 3;
		_npc globalchat "Que te den";	
	};
	
	if (_rnd > 40  && _rnd <= 60) then {
		_npc setmimic "Agresive";
		_npc switchmove "CtsPercMstpSnonWnonDnon_idle33rejpaniVzadku";	
		sleep 1;
		_npc globalchat "Fuck you";		
	};
	
	if (_rnd > 60  && _rnd <= 80) then {
		_npc setmimic "Agresive";
		_npc switchmove "CtsPercMstpSnonWnonDnon_idle32podrbaniNanose";		
		sleep 0.5;
		_npc globalchat "Follow your mother";		
	};
		
	if (_rnd > 80  && _rnd <= 100) then {	
		_npc setmimic "angry";
		sleep 0.1;
		_npc switchmove "CtsPercMstpSnonWnonDnon_idle32podrbaniNanose";		
		_npc globalchat "Fuck you";			
	};
};

if (_join) then {
	// remove the action once it is activated
	_npc stop false;
	if (_npc == leader _npc) then {	
		_npc globalchat "All follow that man";
		{					
			_x switchmove "";			
			[_x] joinSilent _caller;
		}foreach units _npc;
	} else {
		_npc removeAction _id;
		[_npc] joinSilent _caller;	
	};
};

if (true) exitWith {};
