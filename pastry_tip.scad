$fn = 100;

use <MCAD/regular_shapes.scad>

outer_body_diam1     = 17.5;  // Approx opening diam of a #9 pastry tip
outer_body_diam2     = 1.5 * outer_body_diam1;
// outer_body_height is shorter to account for the top spherical edge
outer_body_height    = 2.0 * outer_body_diam1 - 0.2 * outer_body_diam1;
body_hole_height     = 1.5 * outer_body_height;
body_hole_diam1      = 0.7 * outer_body_diam1;
body_hole_diam2      = 0.8 * outer_body_diam2;

module triangular_fins(h, r) {
triangle_prism(h, r);
rotate([0, 0, 30])
    triangle_prism(h, r);
rotate([0, 0, 60])
    triangle_prism(h, r);
rotate([0, 0, 90])
    triangle_prism(h, r);
}

module positioned_tri_fins(z) {
    translate([0, 0, z])
    union() {
        color("red")
        triangular_fins(0.8 * outer_body_height, 0.55 * outer_body_diam1);
    }
}

difference() {
    union() {
        // main body
        color("grey")
        translate([0, 0, 0])
        cylinder(h=outer_body_height, d2=outer_body_diam1, d1=outer_body_diam2);

        // spherical top
        color("orange")
        translate([0, 0, outer_body_height])
        sphere(r=0.5*outer_body_diam1);
    }

    // body negative
    color("red")
    translate([0, 0, -2])
        cylinder(h=body_hole_height, d2=body_hole_diam1, d1=body_hole_diam2);

    // tri fin negative
    positioned_tri_fins(0.85 * outer_body_height);
}
