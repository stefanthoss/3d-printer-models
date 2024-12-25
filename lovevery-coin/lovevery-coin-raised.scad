coin_d = 2*25.4;  // 2"
coin_h = (9/64)*25.4;  // 9/64"

space = 10;
smoothing = 1;

$fn = 100;

module Text(character) {
    offset(r=smoothing) offset(r=-2*smoothing) offset(r=smoothing)
        text(character, size = 35, font = "Liberation Mono:style=Bold", halign = "center", valign = "center");
}

module CharCoin(character) {
    difference() {
        cylinder(h = coin_h, d = coin_d, center = true);
        group() {
            translate([0,0,-0.5*coin_h])
                linear_extrude(coin_h/4)
                    rotate([0,180,0])
                        Text(character);
            translate([0,0,0.25*coin_h])
                linear_extrude(coin_h/4)
                    Text(character);
        }
    }

}

for(num = [0 : 9])
    translate([(num%3)*(coin_d+space),-(num/3)*(coin_d+space),0])
        CharCoin(str(num));

// CharCoin("8");
