/*
This file contains all tiling patterns in one.
Move me to your openscad library folder!
    - Date: 2025
    - Author: Nonsyntactic
*/

// HEX EXAMPLE:
// hex(size=[5,5],style=[10,1],custom_extrude=false,center=false,echo_info=false);

module hex(size=[5,5],style=[10,1],custom_extrude=false,center=false,echo_info=false) {
    /* Unpacking variables */
    xlen = size[0];
    ylen = size[1];
    
    width = style[0];
    space = style[1];
    
    /* Magic Maths */
    h=0.866*width;
    a=sqrt(pow(width/2,2)-pow(h/2,2));
    
    /* Defines what should be tiled */
    module shape(childlen) {
        if (childlen > 0) children(0);
        else circle(d=width-space,$fn=6);
    }
    
    /* Module for tiling the object */
    module tile(childlen) {
        //translate([width/2,h/2]) // Add a tiny bit to align the pattern properly
        for(x=[0:xlen],y=[0:ylen]) {
            if(x%2) { // Runs only on every second iteration
                translate([x*(width-a),(h/2)+y*h,0])  // Apply the calculated translation
                if (custom_extrude) { // Check for a custom extrude function
                    linear_extrude(hex_extrude(x,y))
                        shape(childlen) children(0);
                }
                else { // Create object as 2D
                    shape(childlen) children(0);
                }
            }
            else {
                translate([x*(width-a),+y*h,0]) // Apply the calculated translation
                if (custom_extrude) { // Check for a custom extrude function
                    linear_extrude(hex_extrude(x,y))
                        shape(childlen) children(0);
                }
                else{ // Create object as 2D
                    shape(childlen) children(0);
                }
            }
        }
    }
    
    /* Echo variables if enabled */
    if (echo_info == true) {
        echo("Pattern Width: ",(width/2+a)*xlen+width/2+a*2);
        echo("Pattern Height: ",h*ylen+h+h/2);
        echo("Tile Width: ",h);
        echo("**These variables will only apply when the defult shape is given**");
    }
    
    /* TILE!! */
    if (center==true) {
        translate([(width/2+a)*-xlen/2,-h*ylen/2]) tile($children) children(); // Runs with center translations
    }
    else {
        tile($children) children();
    }
}


// GRID EXAMPLE:
// grid(size=[5,5],style=[10,1],custom_extrude=false,center=false,echo_info=false);

module grid(size=[5,5],style=[5,1],custom_extrude=false,center=false,echo_info=false) {
    /* Unpacking variables */
    xlen = size[0];
    ylen = size[1];
    
    width = style[0];
    space = style[1];
    
    
    /* Defines what should be tiled */
    module shape(childlen) {
        if (childlen > 0) children(0);
        else square(width-space);
    }
    
    /* Module for tiling the object */
    module tile(childlen) {
        for(x=[0:xlen],y=[0:ylen]) {
            translate([x*width,y*width,0])  // Translate with the grid pattern
            if (custom_extrude) { // Check for a custom extrude function
                linear_extrude(grid_extrude(x,y))
                    shape(childlen) children(0);
            }
            else { // Create object as 2D
                shape(childlen) children(0);
            }
        }
    }
    
    /* Echo variables if enabled */
    if (echo_info == true) {
        echo("Pattern Width: ",(width+space)*xlen);
        echo("Pattern Height: ",(width+space)*ylen);
        echo("Tile Width: ",width);
        echo("**These variables will only apply when the defult shape is given**");
    }
    
    /* TILE!! */
    if (center==true) {
        translate([-width*(xlen+1)/2,-width*(ylen+1)/2])
            tile($children) children(); // Runs with center translations
    }
    else {
        tile($children) children();
    }
}

// WAVE EXAMPLE:
//wave(size=[20,2],style=[5,1],wave=[60,5,0],custom_extrude=false,center=false,echo_info=false)


module wave(size=[20,2],style=[5,1],wave=[60,5,0],custom_extrude=false,center=false,echo_info=false) {
    /* Unpacking variables */
    xlen = size[0];
    ylen = size[1];
    
    width = style[0];
    space = style[1];
    
    wave_height = wave[0];
    wave_freq = wave[1];
    wave_offset = wave[2];
    
    
    /* Defines what should be tiled */
    module shape(childlen) {
        if (childlen > 0) children(0);
        else circle(d=width-space,$fn=20);
    }
    
    /* Module for tiling the object */
    module tile(childlen) {
        for(x=[0:xlen],y=[0:ylen]) {
            translate([x*width,y*width+sin(x*wave_height+wave_offset)*wave_freq,0])  
            if (custom_extrude) { // Check for a custom extrude function
                linear_extrude(wave_extrude(x,y))
                    shape(childlen) children(0);
            }
            else { // Create object as 2D
                shape(childlen) children(0);
            }
        }
    }
    
    /* Echo variables if enabled */
    if (echo_info == true) {
        echo("Pattern Width: ",(width+space)*xlen+width-space);
        echo("Pattern Height: ",(width+space)*ylen+width-space+wave_height/2);
        echo("Tile Width: ",width);
        echo("**These variables will only apply when the defult shape is given**");
    }
    
    /* TILE!! */
    if (center==true) {
        translate([-width*(xlen+1)/2,-width*(ylen+1)/2])
            tile($children) children(); // Runs with center translations
    }
    else {
        tile($children) children();
    }
}