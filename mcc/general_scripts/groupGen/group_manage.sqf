//Made by Shay_Gman (c) 09.10
MCC_groupGenRefreshTerminate = true; 
waituntil {!MCC_groupGenRefreshLoop};

MCC_groupGenGroupStatus = _this;	//Which faction
if (count MCC_groupGenGroupStatus > 1) then {MCC_UMstatus = 0} else
{
	private "_side"; 
	_side = MCC_groupGenGroupStatus select 0;
	
	MCC_UMstatus = switch (_side) do
		{
			case east: {1};
			case west: {2};			
			case resistance: {3};
			case civilian: {4};
		};
}; 
[] spawn MCC_fnc_groupGenRefresh; 
[] spawn MCC_fnc_groupGenUMRefresh; 

	
					