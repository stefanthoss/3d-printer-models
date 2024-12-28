/* https://github.com/BelfrySCAD/BOSL2 */
include <BOSL2/std.scad>

device_w = 24.5;
device_h = 24.5;
device_d = 17;

cutout_border = 2;
cable_cutout_rounding = 1;

box_t = 2;
box_rounding = 2;
device_rounding = 2;

hex_plug_diameter = 0.99*15.47;  // Slightly reduced from spec of 15.47mm
hex_plug_short_side = sqrt(3)*(hex_plug_diameter/2);
hex_plug_depth = 10;

$fn = 80;

difference() {
    group() {
        /* Main holder */
        translate([0,0,0])
            cuboid([device_w+2*box_t,device_d+2*box_t,device_h+box_t], rounding = box_rounding, except = [TOP,BACK]);
    }
    group() {
        /* Device cutout */
        translate([0,0,box_t])
            cuboid([device_w,device_d,device_h+box_t], rounding = device_rounding, edges = [BOT+LEFT, BOT+RIGHT]);

        /* Front cutout */
        translate([0,-box_t-2*cutout_border,box_t])
            cuboid([device_w-2*cutout_border, device_d-2*cutout_border, device_h-cutout_border], rounding = box_rounding, edges = [BOT+LEFT, BOT+RIGHT]);

        /* Plug cutout */
        translate([0,0,-device_h/2])
            cuboid([device_w-2*cutout_border,device_d-2*cutout_border,device_h], rounding = cable_cutout_rounding);
    }
}

/* Hex plug */
translate([0,hex_plug_depth/2+device_d/2+box_t,hex_plug_short_side/2-device_h/2-box_t/2])
    rotate([-90,0,0])
        cylinder(h = hex_plug_depth, d = hex_plug_diameter, center = true, $fn = 6);
