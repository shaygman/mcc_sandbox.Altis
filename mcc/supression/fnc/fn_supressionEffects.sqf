/*================================================================MCC_fnc_supressionEffects================================================================================
  Effects of being supressed
  IN <>
    hit
*/
private ["_blurEffects"];
params ["_ratio","_dir"];

//Hit direction
if (missionNamespace getVariable ["MCC_hitRadar",true]) then {
	switch (true) do
	{
		case (_dir > 315 || _dir <= 45):
		{
			systemChat "up";
		};

		case (_dir > 45 && _dir <= 135):
		{
			systemChat "right";
		};

		case (_dir > 135 && _dir <= 225):
		{
			systemChat "down";
		};

		default
		{
			systemChat "left";
		};
	};
};

// RBlur
_blurEffects = ppEffectCreate ["DynamicBlur", 440];
_blurEffects ppEffectAdjust [_ratio];
_blurEffects ppEffectEnable true;

_blurEffects ppEffectCommit 0;

enableCamShake true;
resetCamShake;
addCamShake [(_ratio * 5),_ratio, _ratio*80];

sleep 0.5;
ppEffectDestroy [_blurEffects];