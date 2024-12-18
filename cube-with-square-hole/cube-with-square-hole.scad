/* https://danielupshaw.com/openscad-rounded-corners */
include <roundedcube.scad>;

cube_size=40;
cutout_size=15;

$fn=80;

difference() {
    roundedcube(cube_size, center=true, radius=2);
    
    group() {
        rotate([45,0,0]) {
            cube([60,cutout_size,cutout_size], center=true);
        }
        rotate([45,90,0]) {
            cube([60,cutout_size,cutout_size], center=true);
        }
        rotate([45,0,90]) {
            cube([60,cutout_size,cutout_size], center=true);
        }
    }
}
