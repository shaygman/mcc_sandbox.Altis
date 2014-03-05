//Made by Shay_Gman (c) 09.10
MCC_groupGenRefreshTerminate = true; 
waituntil {!MCC_groupGenRefreshLoop};

MCC_groupGenGroupStatus = _this;	//Which faction

[] spawn MCC_fnc_groupGenRefresh; 
					