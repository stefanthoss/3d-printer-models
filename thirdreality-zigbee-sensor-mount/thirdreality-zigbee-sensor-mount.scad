device_w = 62;
device_d = 20.5;
device_h = 37;

cutout_w = 40;
cutout_bottom = 10;

side_flap = 5;
box_t = 2;

$fn = 80;

difference() {
    group() {
        translate([0,(device_d+box_t)/2,0])
            cube([device_w+2*side_flap, box_t, device_h], center = true);
        
        translate([0,0,-device_h/2])
            linear_extrude(device_h)
                offset(r=box_t) offset(delta=-box_t)
                        square([device_w+2*box_t, device_d+2*box_t], center = true);
    }
    group() {
        translate([0,0,box_t-device_h/2])
            linear_extrude(device_h)
                offset(r=box_t*2) offset(delta=-box_t*2)
                        square([device_w, device_d], center = true);

        translate([0, 0, cutout_bottom])
            cube([cutout_w, 2*device_d, device_h], center = true);
    }
}

/* Left flap */
translate([side_flap+device_w/2-1.5*box_t,device_d/2+1*box_t,-device_h/2])
    rotate([0,0,270])
        rotate_extrude(angle=90)
            square([side_flap,device_h]);

/* Right flap */
translate([-side_flap-device_w/2+1.5*box_t,device_d/2+1*box_t,-device_h/2])
    rotate([0,0,180])
        rotate_extrude(angle=90)
            square([side_flap,device_h]);
