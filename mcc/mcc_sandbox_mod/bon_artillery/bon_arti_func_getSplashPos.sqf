//by Bon_Inf*
// INPUT: x-coord, y-coord, direction, distance, height difference
// OUTPUT: the vector of [x-coord,y-coord] + distance in the direction

_xpos = _this select 0;
_ypos = _this select 1;
_dir = _this select 2;
_dist = _this select 3;
_height = _this select 4;


// using Pythagoras' a^2+b^2=c^2 to compensate height dispersion
_actualdistance = sqrt (_dist^2 - _height^2);

// getting what we want:
_newpos = [round (_xpos + _actualdistance*sin(_dir)), round (_ypos + _actualdistance*cos(_dir)),0];


_newpos