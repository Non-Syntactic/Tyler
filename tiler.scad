

function tile_extrude(x,y) = 5;
//hex(false,20,20,20,2,1) square(5);



module hex(custom_shape=false,xlen=5,ylen=5,width=10,space=1,sca=1) {
    /* Defines what should be tiled */
    module shape() {
        if (custom_shape) children(0);
        else circle(d=width-space,$fn=6);
    }


    /* Magic Maths */
    h=0.866*width;
    a=sqrt(pow(width/2,2)-pow(h/2,2));

    /* TILE!! */
    for(x=[0:xlen],y=[0:ylen]) {
        if(x%2) {
            translate([x*(width-a),(h/2)+y*h,0]) linear_extrude(tile_extrude(x,y),scale=sca)
                shape() children(0);
        }
        else {
            translate([x*(width-a),+y*h,0]) linear_extrude(tile_extrude(x,y),scale=sca)
                shape() children(0);
        }
    }
}


/*
module hex(custom_shape=false,xlen=5,ylen=5,xspace=8.6,yspace=10) {
    sx=xspace;//-0.8;
    sy=yspace;//-0.45;
    module shape() {
        if (custom_shape) children(0);
        else circle(d=11,$fn=6);
    }
    
    for(x=[0:xlen],y=[0:ylen-1]) linear_extrude(tile_extrude(x,y)){
        if (x%2==0) translate([x*sx,y*sy]) shape() children(0);
        if (x%2==1) translate([x*sx,y*sy+sy/2]) shape() children(0);
    }
}
*/