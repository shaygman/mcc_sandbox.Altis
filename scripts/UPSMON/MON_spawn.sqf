/* =====================================================================================================
	MON_spawn.sqf
	Author: Monsada (chs.monsada@gmail.com) 
		Comunidad Hispana de Simulación: 
		http://www.simulacion-esp.com
 =====================================================================================================
	Parámeters: [Param1,Param2,Param3,[Param4]]  EXECVM "SCRIPTS\UPSMON\MON_SPAWN.SQF";	
		<-	Param1 	Id of the template to copy.
		<-	Param2 	Position to create new squad.
		<-	Param3 	Nº of squads to create
		<-	Param4	Array of parameters of UPSMON, first must be name of marc to patrol
  =====================================================================================================
  	Function that allows to spawn UPSMON squads.	
	
	1- create a squad in editor. Exec UPSMON and set TEMPLATE id, this will save members of squad, not equipement.		
		nul = [this,"town","TEMPLATE:",1] execVM "scripts\upsmon.sqf";	
	2- Exec MON_spawn on trigger or where you want telling the copy of the template to create
		and the position.
		nul = [1,[0,0,0],3,[mark, upsmon optional params]] EXECVM "SCRIPTS\UPSMON\MON_SPAWN.SQF";		
 =====================================================================================================*/
if (!isserver) exitWith {}; 

//Waits until UPSMON is init
waitUntil {!isNil("KRON_UPS_INIT")};
waitUntil {KRON_UPS_INIT==1};	
private ["_template","_position","_params","_copies","_membertypes","_unittype","_side","_UCthis","_initstr","_grp","_lead","_newunit","_i","_newpos","_vehicle","_initlstr"];

//Parameter reading
_template  = _this select 0;
_position = _this select 1;
_copies = _this select 2;
_params = _this select 3;

//Initialization
_membertypes = [];
_side = "";
_UCthis = [];
_initstr = "";
_initlstr = "";
_grp = grpnull;
_lead = objnull;
_newunit = objnull;
_newpos=[];
_vehicle=[];

//Gets parameters of UPSMON
for [{_i=0},{_i<count _params},{_i=_i+1}] do {_e=_params select _i; if (typeName _e=="STRING") then {_e=toUpper(_e)};_UCthis set [_i,_e]};
_initstr = ["INIT:","",_UCthis] call KRON_UPSgetArg;
_initlstr = ["INITL:","",_UCthis] call KRON_UPSgetArg;
_initlstr = _initlstr + _initstr;
_spawned= if ("SPAWNED" in _UCthis) then {true} else {false};
if (!_spawned) then {_UCthis = _UCthis + ["SPAWNED"]};	

if (KRON_UPS_Debug>0) then {player globalchat format["Spawning %3 copies of template %1",_template,_position,_copies,count KRON_UPS_TEMPLATES]};	
//if (KRON_UPS_Debug>0) then {diag_log format["Spawning %3 copies of template %1 on %2 templates %4",_template,_position,_copies,count KRON_UPS_TEMPLATES]};	
	
//Search if any template	
{
	if ((_x select 0) == _template) then {
		_side = _x select 1;
		_membertypes = _x select 2;	
		_vehicletypes = _x select 3;	
		//Gets leader type
		_unittype= _membertypes select 0;		
		
		//if (KRON_UPS_Debug>0) then {player globalchat format["template %1:%2 ",_template,_membertypes]};	
		
		for [{_i=1},{_i<=_copies},{_i=_i+1}] do {
	
			// make the clones civilians
			// use random Civilian models for single unit groups
			if ((_unittype=="Civilian") && (count _members==1)) then {_rnd=1+round(random 20); if (_rnd>1) then {_unittype=format["Civilian%1",_rnd]}};
			
			_grp=createGroup _side;
			
			_lead = _grp createUnit [_unittype, _position, [], 0, "form"];
			//_lead setVehicleInit _initlstr;
			[_lead] join _grp;
			_grp selectLeader _lead;
			sleep 1;
			
			// copy team members (skip the leader)
			_c=0;
			{
				_c=_c+1;
				if (_c>1) then {
					_newpos = _position findEmptyPosition [10, 200];
					sleep .4;
					if (count _newpos <= 0) then {_newpos = _position};
					_newunit = _grp createUnit [_x, _newpos, [],0,"form"];
					//_newunit setVehicleInit _initstr;
					[_newunit] join _grp;
				};
			} foreach _membertypes;
			

			{				
				_newpos = _position findEmptyPosition [10, 200];
				sleep .4;
				if (count _newpos <= 0) then {_newpos = _position};				
				_newunit = _x createvehicle (_newpos);											
			} foreach _vehicletypes;			
			
			//Set new parameters			
			_params = [_lead] + _UCthis;						
			
			//Exec UPSMON script			
			_params SPAWN UPSMON;
			
			//processInitCommands;			
		};
	};
}foreach KRON_UPS_TEMPLATES;

if (true) exitwith{};
