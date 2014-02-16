//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoFortify
// spirit 11-2-2014
//===========================================================================================================================================================================	
private ["_group","_TargetPos"];




_group  		= _this select 0;
_TargetPos	= _this select 1;


_objectslist = nearestObjects [leader _group ,["House"],200];
_buildingslist = [];
_buildingsleft = [];
_doorPositions = [];
_BuildingPos	 = [];



	{				 
		if (
					(format ["%1",_x buildingPos 0] != "[0,0,0]") 
//					and
//					([(position _x),((_group getVariable  ["GAIA_zone_intend",["",""]])select 1) ]call fnc_Pos_IsInMarker)
			 )
		then 
		{
			
			_buildingslist set [count _buildingslist,_x];
		}; 
	} foreach _objectslist;
	
_group setVariable ["Garrisoning",true];

if ((count _buildingslist) >= 1) then 
	{
	 	 	
			{
							_i=0;
							while {str(_x buildingPos _i) != "[0,0,0]"} do {_BuildingPos=_BuildingPos+[[(_x buildingPos _i),_x,_i]];_i = _i + 1;};
							
							//just stop if we have enough shit
							if ((count(_BuildingPos))> (count(units _group)*10) ) exitwith {true};
			}foreach ([_buildingslist,[],{(leader _group) distance (position _x)},"ASCEND"] call BIS_fnc_sortBy);			
	 	
	 	
	 	{
			_unit = _x;
			
			aaa= _BuildingPos;
			_bld  = (_BuildingPos select floor(random(count _BuildingPos)));
			_unit setVariable ["homebuild",(_bld select 1)];
			_unit setVariable ["homepos",(_bld select 2)];
			
			_moveComplete = [_unit,_bld select 0 ] spawn gaia_fnc_MoveTo;		
			

			
		}foreach (units _group);
	};
	




//Lets set the current Order.
_group setVariable ["GAIA_Order"							, "DoFortify", false];
//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
_group setVariable ["GAIA_OrderTime"					, Time, false];
_group setVariable ["GAIA_OrderPosition"			, _TargetPos, false];

true


