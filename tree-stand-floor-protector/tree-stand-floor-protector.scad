ellipse_w = 46;
ellipse_d = 40;
ellipse_h = 2;
lip = 2;
peg_h = 6;
peg_d = 6;

$fn=100;

linear_extrude(ellipse_h) {
    resize([ellipse_w+2*lip,ellipse_d+2*lip]) {
        circle(d=ellipse_w);
    }
}

translate([0,0,ellipse_h]){
    difference() {
        linear_extrude(lip) {
            resize([ellipse_w+2*lip,ellipse_d+2*lip]) {
                circle(d=ellipse_w);
            }
        }
        linear_extrude(lip) {
            group() {
                resize([ellipse_w,ellipse_d]) {
                    circle(d=ellipse_w);
                }
                translate([ellipse_w/2,0,0]) {
                    square([ellipse_w,ellipse_d], center=true);
                }
            }
        }
    }
}


linear_extrude(peg_h) {
    circle(d = peg_d);
}

translate([0,0,peg_h]) {
    rotate_extrude(){
        intersection(){
            circle(d=peg_d);
            square(peg_d);
        }
    }
}
