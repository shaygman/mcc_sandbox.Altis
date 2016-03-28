//===============================================================MCC_fnc_VONRadiofindChannel=====================================================================================
//==============================================================================================================================================================================
switch _this do {
	case localize "str_channel_global" : {["str_channel_global",0]};
	case localize "str_channel_side" : {["str_channel_side",1]};
	case localize "str_channel_command" : {["str_channel_command",2]};
	case localize "str_channel_group" : {["str_channel_group",3]};
	case localize "str_channel_vehicle" : {["str_channel_vehicle",4]};
	case localize "str_channel_direct" : {["str_channel_direct",5]};
	default {["",-1]};
};