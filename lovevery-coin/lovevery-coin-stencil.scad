coin_d = 2*25.4;  // 2"
coin_h = (9/64)*25.4;  // 9/64"

space = 10;

$fn = 100;

module Text(character) {
    /* Font: https://www.omnibus-type.com/fonts/saira-stencil-one */
    text(character, size = 30, font = "Saira Stencil One:style=Regular", halign = "center", valign = "center");
}

module CharCoin(character) {
    difference() {
        cylinder(h = coin_h, d = coin_d, center = true);

        translate([0,0,-coin_h/2])
            linear_extrude(coin_h)
                Text(character);
    }
}

for(num = [0 : 9])
    translate([(num%3)*(coin_d+space),-(num/3)*(coin_d+space),0])
        CharCoin(str(num));

// CharCoin("8");
