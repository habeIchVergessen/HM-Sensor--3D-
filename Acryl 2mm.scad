// variables
Grundplatte=1;
Grundplatte_Platinenaussparung=0;
Grundplatte_Kabelschacht=0;
Deckel=0;
Deckel_CR2032=0;

// Maße Grundplatte
pH=20;  // gesamt
kH=6;   // kabel

//
module roundedEdge(x=0, y=0, z=-1, a=0, l=30, h=pH+2, s=0) 
{
    fa=5;
    fs=0.1;

    translate([x, y, z]) rotate(a)
    difference() {
        translate([0, 0, 0])
        linear_extrude(h) 
        polygon([[-1, -1], [l/2, -1], [-1, l/2]]);
        if (s==0) {
            translate([l/2, l/2, 0]) cylinder(r=l/2, h=h+2, $fa = fa, $fs = fs);
        } else if (s==1)
        {
            translate([l/2, l/2, l/2]) cylinder(r=l/2, h=h+2, $fa = fa, $fs = fs);
            translate([l/2, l/2, l/2]) 
            sphere(r=l/2, $fa = fa, $fs = fs);
        } else if (s==2) {
            translate([l/2, l/2, 0]) cylinder(r=l/2, h=h+2-l/2, $fa = fa, $fs = fs);
            translate([l/2, l/2, h-l/2]) 
            sphere(r=l/2, $fa = fa, $fs = fs);
        } else {
            translate([l/2, l/2, l/2]) cylinder(r=l/2, h=h+2-l, $fa = fa, $fs = fs);
            translate([l/2, l/2, l/2]) 
            sphere(r=l/2, $fa = fa, $fs = fs);
            translate([l/2, l/2, h-l/2]) 
            sphere(r=l/2, $fa = fa, $fs = fs);
        }
    }
}

// Grundplatte
if (Grundplatte == 1) {
    scale([0.1, 0.1, 0.1])
    difference() {
    translate([0, 0, -1])
    cube([300, 1200, pH], center=false);

    // befestigung
    translate([150, 105, -1])
    cylinder(r=50, h=pH+2, center=false);
    translate([150, 540, -1])
    cylinder(r=50, h=pH+2, center=false);
    // vierkant
    translate([150, 320, -1])
    cylinder(r=90, h=pH+2, center=false);
    // reed
    translate([242, 270, -1])
    cube([22, 200, pH+2], center=false);
    translate([36, 270, -1])
    cube([22, 200, pH+2], center=false);

    // platine
    if (Grundplatte_Platinenaussparung == 1) {
        translate([30, 710, 14])
        cube([61, 61, 7], center=false);
        translate([50, 730, 6])
        cube([41, 41, 15], center=false);
    }
    translate([90, 710, -1])
    cube([180, 61, pH+2], center=false);

    translate([30, 770, -1])
    cube([240, 340, pH+2], center=false);

    if (Grundplatte_Platinenaussparung == 1) {
        translate([210, 1109, 14])
        cube([61, 61, 7], center=false);
        translate([210, 1109, 6])
        cube([41, 41, 15], center=false);
    }
    translate([30, 1109, -1])
    cube([181, 61, pH+2], center=false);

    if (Grundplatte_Kabelschacht == 1) {
        // kabel
        translate([250, 469, -1])
        cube([kH, 242, kH], center=false);
        translate([46, 469, -1])
        cube([210, kH, kH], center=false);
        roundedEdge(x=251, y=474, h=6, a=90);

        // antenne    
        translate([25, 355, -1])
        cube([kH, 422, kH], center=false);

        roundedEdge(l=50);
        roundedEdge(x=300, y=-1, a=90, l=50);
        roundedEdge(x=301, y=1200, a=180, l=50);
        roundedEdge(y=1201, a=270, l=50);
        }
    }

}

// Deckel
if (Deckel == 1) {
    dH=80;  // gesamt

    scale([0.1, 0.1, 0.1])
    translate([0, 0, -1])
    union() {
        difference() {
            translate([400, 680, 0])
            cube([300, 520, dH], center=false);

            translate([430, 710, 11])
            cube([240, 460, dH+2], center=false);

            roundedEdge(x=400, y=1200, a=270, h=dH+2, l=50, s=1);
            roundedEdge(x=700, y=1200, a=180, h=dH+2, l=50, s=1);
                
            translate([700, 1200, 0]) rotate([90, 0, 270]) roundedEdge(x=0, y=0, h=302, l=50, s=3);
            translate([400, 680, 0]) rotate([90, 270, 180]) roundedEdge(x=0, y=0, h=522, l=50, s=2);
            translate([700, 680, 0]) rotate([90, 0, 180]) roundedEdge(x=0, y=0, h=522, l=50, s=2);
        }

        translate([420, 710, 10])
        cube([260, 30, dH-20], center=false);
        difference() {
            translate([490, 720, 0])
            cube([120, 20, dH+2+18], center=false);
            roundedEdge(x=490, y=720, z=dH-18, a=0, h=dH+2+18, l=20);
            roundedEdge(x=490+120, y=720, z=dH-18, a=90, h=dH+2+18, l=20);
        }
        translate([420, 1140, 10])
        cube([260, 30, dH-20], center=false);
        difference() {
            translate([490, 1140, 0])
            cube([120, 20, dH+2+18], center=false);
            roundedEdge(x=490, y=1140+20, z=dH-18, a=270, h=dH+2+18, l=20);
            roundedEdge(x=490+120, y=1140+20, z=dH-18, a=180, h=dH+2+18, l=20);
        }
        
        if (Deckel_CR2032 == 1) {
            difference() {
                translate([430, 880, 0])
                cube([240, 120, dH-20], center=false);
                translate([550, 940, 0])
                cylinder(r=100, h=dH-18, $fa = 5, $fs = 0.1);
            }
        }
    }
}