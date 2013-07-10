#define ExtrasDialog3_IDD 2996

private ["_type","_pos","_zoneX","_zoneY","_activate","_cond","_angle","_shape","_text","_capture","_trigger","_s"];

_type = _this select 0;
switch (_type) do
{
	case 0:	//Generate
	{ 
		_pos = _this select 1;	
		_zoneX = (_this select 2) select 0;	
		_zoneY = (_this select 2) select 1;	
		_activate = _this select 3;	
		_cond = _this select 4;	
		_shape = _this select 5;	
		_text = _this select 6;	
		_capture = _this select 7;	
		
		createmarkerlocal [_text, _pos];	//create trigger marker for MM
		_text setMarkerColorLocal "ColorOrange";
		_text setMarkerSizeLocal [_zoneX, _zoneY];
		_text setMarkerShapeLocal  _shape;
		_text setMarkerBrushLocal  "SOLID";
				
		if (_shape == "RECTANGLE") then {_s = true} else {_s = false}; //rectangel or elipse

		_trigger = createTrigger ["EmptyDetector", _pos];
		_trigger setpos _pos;
		_trigger setTriggerArea [_zoneX, _zoneY, 0, _s];
		_trigger setTriggerStatements ["this", format ["%1",_capture] , ""];
		_trigger setTriggerText _text;
		_trigger setTriggerActivation [_activate, _cond, false];
		MCC_triggers set [count MCC_triggers,[_text,_trigger]];
	};
	
		case 1:	//Move
	{ 
		_pos = _this select 1;	
		_text = _this select 2;	
		_trigger = _this select 3;	
		_text setMarkerPosLocal _pos;
		_trigger setpos _pos;
	};
};


