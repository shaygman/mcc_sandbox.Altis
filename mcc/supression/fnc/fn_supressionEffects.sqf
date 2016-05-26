/*=================================================================MCC_fnc_supressionEffects================================================================================
  Effects of being supressed
  IN <>
    hit
*/
private ["_blurEffects"];
params ["_hit","_ratio"];
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