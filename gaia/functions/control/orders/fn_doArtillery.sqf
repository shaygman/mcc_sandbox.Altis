//==================================================================fnc_DoInfPatrol===============================================================================================
// Mortar 
// Example: [_group, Position] call fnc_DoMortar
// spirit 1-2-2014
//===========================================================================================================================================================================	
private ["_group","_pos","_isInRange","_rounds","_MortarRound","_ammo","_radiusSpread"];

_group 			= _this select 0; 
_pos				= _this select 1;


_ammo 				= [];	
_radiusSpread = 0;


_class 						= _group getVariable ["GAIA_class",[]];
_MortarRound		  = _group getVariable ["GAIA_MortarRound",0];
_ammo 						= (getArtilleryAmmo [(assignedVehicle (leader _group))] select 0);

//If we were busy somewhere, finish it
if (_MortarRound>0) then {_pos = _group getVariable ["GAIA_MortarTarget",[0,0,0]];};

//If this is the second round, we dont check for all sorts of stuff. Finish what you started
_isInRange 				= (_pos inRangeOfArtillery [[(leader _group)],_ammo  ]) or (_MortarRound>0) ;

		
// First Shot
if (_isInRange) then
{
		switch(true)do
		{
				case (_MortarRound<2) : {_radiusSpread= 120;_rounds =1;};
				case (_MortarRound<3) : {_radiusSpread= 100;_rounds =1;};
				case (_MortarRound<4) : {_radiusSpread= 080;_rounds =1;};
				case (_MortarRound<5) : {_radiusSpread= 010;_rounds =3;};
				//The 'Fire For Effect' will not always be achieved. It can be skipped if we roll 2 in the random roll in the code below
				case (_MortarRound<=6): {_radiusSpread= 000;_rounds =8;};
				case (_MortarRound<=10): {_radiusSpread= 010;_rounds =1;};

		};
  
		///Pos is for all mortar in group
		_mortarPos = [_pos, _radiusSpread, random(360)] call BIS_fnc_relPos;;
		
		
		
		//Fire dudes
		{
	
			
			if (alive _x) then
			{
		
				(vehicle _x) addMagazine _ammo;
				_x commandArtilleryFire [_mortarPos, _ammo  , _rounds ];			
				
				
			};
		}foreach (units _group);
		
		
		// We finished this round so go up (sometimes faster then other times)
		_MortarRound = _MortarRound + round((random 2));
		if (_MortarRound>=10) then
			{
					//Specific Mortar information
					_group setVariable ["GAIA_MortarRound"					, 0, false];
					_group setVariable ["GAIA_MortarTarget"					, [0,0,0], false];		
			}
		else
			{
					//Specific Mortar information
					_group setVariable ["GAIA_MortarRound"					, _MortarRound, false];
					_group setVariable ["GAIA_MortarTarget"					, _pos, false];		
			};

				//Lets set the current Order.
		_group setVariable ["GAIA_Order"							, "DoMortar", false];
		//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
		//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
		_group setVariable ["GAIA_OrderTime"					, Time, false];		
		_group setVariable ["GAIA_OrderPosition"			, (position leader _group), false];
		

};




_isInRange
