/* https://github.com/BelfrySCAD/BOSL2 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

clip_h = 12;
inner_r = 12;
wall_t = 5;
wall_w = 12;
screw_r = 4.6;
opening_w = 22;
clip_space = 12;

outer_r = inner_r + 2;

$fn=80;

/* First clip */
WallClip();

/* Second clip with bar in-between */
translate([0,0,clip_h+clip_space])
    WallClip();
translate([inner_r,-wall_w/2,clip_space])
    cube([wall_t,wall_w,clip_h]);

module WallClip() {
    difference() {
        /* Clip */
        group() {
            linear_extrude(clip_h) {
                difference() {
                    circle(r = outer_r);
                    circle(r = inner_r);
                }
            }

            translate([inner_r,-wall_w/2,0])
                cube([wall_t,wall_w,clip_h]);
        }

        group() {
            /* Screw hole */
            translate([outer_r,0,clip_h/2]) {
                group() {
                    rotate([0,-90,0]) {
                        screw_hole("#8,1/4",head="flat",anchor=TOP);
                        cylinder(h = 2*(outer_r-inner_r), r = screw_r);
                    }
                }
            }

            /* Clip front */
            translate([-inner_r,0,clip_h/2])
                cube([2*outer_r,opening_w,clip_h], center = true);
        }
    }
}
