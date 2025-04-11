include  <tyler.scad>

function hex_extrude(x,y) = sin(x*20)*20+20 + sin(y*20)*20+20; // Dual axis sine wave


color("orange")
hex(size=[20,20],style=[10,1],custom_extrude=true);

translate([+30,-140,50]) rotate([45,0,45])
linear_extrude(10) 
intersection() {
    hex(size=[50,20],style=[10,1]);
    translate([10,20]) text("Tyler",60);
}