private ["_count"];

_count = 0;
if (!(simulationEnabled (leader _this))) then {
	private ["_x"];
	_x = leader _this;

        _x allowDamage true;
        _x enableSimulation true;
                
        _x enableAI "TARGET";
        _x enableAI "AUTOTARGET";
        _x enableAI "MOVE";
        _x enableAI "ANIM";
        _x enableAI "FSM";
                
        _count = _count + 1;
};

