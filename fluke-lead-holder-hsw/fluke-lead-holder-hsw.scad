/* https://github.com/BelfrySCAD/BOSL2 */
include <BOSL2/std.scad>

hex_plug_diameter = 0.99*15.47;  // Slightly reduced from spec of 15.47mm
hex_plug_short_side = sqrt(3)*(hex_plug_diameter/2);
hex_plug_depth = 10;

hex_base_depth = 2.5;
hex_base_diameter = hex_plug_diameter + 2*hex_base_depth;

holder_diameter = 4;
holder_gap = 11;
holder_length = 35;

$fn = 80;

module Holder() {
    /* Long straight */
    rotate([90,0,0])
        cylinder(h = holder_length, d = holder_diameter);
    
    /* Curvy part */
    translate([0,-holder_length,2*holder_diameter])
        rotate([180,90,0])
            rotate_extrude(angle = 60)
                translate([2*holder_diameter,0,0])
                    circle(d = holder_diameter);
    
    /* Round tip */
    translate([0,-holder_length,2*holder_diameter])
        rotate(a = [-60,0,0])
            translate([0,0,-2*holder_diameter])
                rotate([90,0,0])
                    rotate_extrude()
                        intersection() {
                            circle(d=holder_diameter);
                            square(holder_diameter);
                        }
}

/* Hex plug */
rotate([90,0,0])
    cylinder(h = hex_plug_depth, d = hex_plug_diameter, center = true, $fn = 6);

/* Hex base */
translate([0,-hex_plug_depth/2,0])
    rotate([90,0,0])
        cylinder(h = hex_base_depth/2, d1 = hex_plug_diameter, d2 = hex_base_diameter, center = true, $fn = 6);
translate([0,-hex_plug_depth/2-hex_base_depth/2,0])
    rotate([90,0,0])
        cylinder(h = hex_base_depth/2, d = hex_base_diameter, center = true, $fn = 6);

translate([-(holder_gap+holder_diameter)/2,-hex_plug_depth/2-hex_base_depth/2,0])
    Holder();

translate([(holder_gap+holder_diameter)/2,-hex_plug_depth/2-hex_base_depth/2,0])
    Holder();
