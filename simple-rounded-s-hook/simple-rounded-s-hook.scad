/* https://github.com/BelfrySCAD/BOSL2 */
include <BOSL2/std.scad>
include <BOSL2/skin.scad>

loop_r = 30;
hook_d = 15;
hook_angle = 145;
straight_l = 85;
flatten_h = hook_d/20;

$fn=80;

difference() {
    /* Hook */
    group() {
        /* Start cap */
        rotate([0,-90,0]) {
            rotate_extrude(){
                intersection(){
                    circle(d=hook_d);
                    square(hook_d);
                }
            }
        }

        /* Draw the hook */
        turtle_cmds = ["arcrightto", loop_r, hook_angle,
                       "move", straight_l,
                       "arcleftto", loop_r, 0];
        path = turtle(turtle_cmds,
                       state=[0,0],
                       full_state=false);
        path_sweep(circle(d = hook_d), path);

        /* End cap */
        translate(path[len(path) - 1]) {
            rotate([0,90,0]) {
                rotate_extrude(){
                    intersection(){
                        circle(d=hook_d);
                        square(hook_d);
                    }
                }
            }
        }
    }
    
    /* Flatten the hook with two  */
    group(){
        translate([-4*straight_l+2*loop_r,-2*straight_l+loop_r,(hook_d/2)-flatten_h]) {
            cube([4*straight_l,2*straight_l,flatten_h]);
        }
        translate([-4*straight_l+2*loop_r,-2*straight_l+loop_r,-(hook_d/2)]) {
            cube([4*straight_l,2*straight_l,flatten_h]);
        }
    }
}