private ["_unit"];

_unit = _this;

createMarkerLocal [format["%1", _unit],getpos _unit];
format["%1", _unit] setMarkerTypelocal "waypoint";
format["%1", _unit] setMarkerColorlocal "ColorBlue";
format["%1", _unit] setMarkerTextLocal (format ["%1",_unit]);

