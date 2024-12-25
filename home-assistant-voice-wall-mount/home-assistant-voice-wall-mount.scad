/* https://github.com/BelfrySCAD/BOSL2 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

device_w = 83.5;
device_h = 83.5;
device_d = 21.5;

bottom_h = 37;
cutout_r = 27.5;
cutout_offset = 27.5;

cable_cutout_w = 46;
cable_cutout_d = 11;
cable_cutout_rounding = 1;

box_t = 2;
back_t = 3.5;
box_rounding = 3;
device_rounding = 7;

screw_r = 4.6;
screw_offset = 0.5;

$fn = 80;

module ScrewHole() {
    rotate([90,-90,0]) {
        screw_hole("#8,1/4",head="flat",anchor=TOP);
        cylinder(h = screw_offset, r = screw_r);
    }
}

difference() {
    group() {
        /* Main holder */
        translate([0,(back_t-box_t)/2,-(device_h-bottom_h+box_t)/2])
            cuboid([device_w+2*box_t,device_d+back_t+box_t,bottom_h+box_t], rounding = box_rounding, except = TOP);

        /* Back plate */
        translate([0,(device_d+back_t)/2,0])
            cuboid([device_w-device_rounding,back_t,device_w-device_rounding], rounding = device_rounding, edges="Y");
    }
    group() {
        /* Device cutout */
        translate([0,0,0])
            cuboid([device_w, device_d, device_h], rounding = device_rounding, edges = [BOT+LEFT, BOT+RIGHT]);

        /* Round cutout */
        translate([0,-device_d/2,0])
            rotate([90,0,0])
                cylinder(h = device_d, r = cutout_r, center = true);
        
        /* Screw holes */
        translate([-device_w/4,device_d/2+screw_offset,0])
            ScrewHole();
        translate([device_w/4,device_d/2+screw_offset,0])
            ScrewHole();
        
        /* Plug cutout */
        translate([0,0,-device_h/2])
            cuboid([cable_cutout_w,cable_cutout_d,bottom_h], rounding = cable_cutout_rounding);
    }
}
