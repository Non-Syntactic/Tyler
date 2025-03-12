include <tyler.scad>

a=5;
b=3;

c=1;
d=6;

function hex_extrude(x,y) = x*y;
function grid_extrude(x,y) = x*y;
function wave_extrude(x,y) = x*y;


hex([a,b],[d,c],custom_extrude=true,center=true);
translate([-50,0]) grid([a,b],[d,c],custom_extrude=true,center=true);
translate([50,0]) wave([a,b],[d,c],[39,10,0],custom_extrude=true,center=true);