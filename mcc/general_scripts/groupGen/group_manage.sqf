//Made by Shay_Gman (c) 09.10

MCC_groupGenGroupStatus = _this;	//Which faction

MCC_groupGenRefreshTerminate = true; 
waituntil {!MCC_groupGenRefreshLoop};
[] call MCC_fnc_groupGenRefresh; 

	
					