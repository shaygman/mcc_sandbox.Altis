/* ----------------------------------------------------------------------------
Function: fnc_GAIA_Classify

Description:
	This function classifies all groups of a certain side and saves them to group variables by set_variable.
	It determines the class, speed, cost and order portfolio of a group.	

Parameters:
	- Side

Returns:
	true

Author:
	Spirit, 17-1-2014

---------------------------------------------------------------------------- */

private ["_side","_ClassifiedGroup"];

_side = _this select 0;


 {
	 if (
   			//Seems like allgroups opens up with all sorts of empty groups, better check it
   			((side _x) == _side)
   			and
   			(count(units _x)>0)
 			)
 	 then
 	 		{
 	 			_ClassifiedGroup = [(units _x)] call fnc_ClassifyUnits;
 	 			if (count (_ClassifiedGroup)>0) then
 	 			{
 	 				_PreviousClass = _x getVariable ["GAIA_class","None"];
 	 				
 	 				//If we set it for the first time, then set them both equal so we dont monitor a class change on first cycle.
 	 				if (_PreviousClass == "None") 
 	 				then {_x setVariable ["GAIA_PreviousClass"			, (_ClassifiedGroup select 0), false]}	 				
 	 				else {_x setVariable ["GAIA_PreviousClass"			, _PreviousClass, false]};
					
					//Remember the points so we see how bad we do 
					_x setVariable ["GAIA_PreviousPoints"							, (_x getVariable ["GAIA_points",0]), false];
					 	 					
 	 				//[_Class,_speed,_points,_portfolio,cargo]
 	 				_x setVariable ["GAIA_class"							, (_ClassifiedGroup select 0), false];
 	 				_x setVariable ["GAIA_speed"							, (_ClassifiedGroup select 1), false];
 	 				_x setVariable ["GAIA_points"							, (_ClassifiedGroup select 2), false];
 	 				_x setVariable ["GAIA_portfolio"					, (_ClassifiedGroup select 3), false];
 	 				_x setVariable ["GAIA_cargo"							, (_ClassifiedGroup select 4), false];
 	 			};
 	 		};
	 }  forEach AllGroups;

	 
true;