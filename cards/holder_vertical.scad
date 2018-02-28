module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module token_holder()
{
    scale(1.6) difference()
    {
        union()
        {
            cylinder(h=14, r=9);
            cylinder(h=0.5, r=9);
        }
        translate([-10, 0, -1]) cube([20, 20, 20]);
        translate([0, 0, 1]) cylinder(h=14, r=8);
        //translate([7, 7, -1]) cylinder(h=16, r=7.5);
    }
}

module tore(smallr, bigr)
{
    rotate_extrude() translate([bigr, 0, 0]) circle(r=smallr);
}

$fn=100;
intersection()
{
    union()
    {
        difference()
        {
            union()
            {
                // Main cube
                translate([-3.5, -100, 0]) cube([7, 200, 80]);
            }
            union()
            {
                // Truncation of the side of the main cube
                translate([-4, 50, 0]) prism(8, 50, 80);
                // Truncation of the other side
                rotate([0, 0, 180]) translate([-4, 50, 0]) prism(8, 50, 80);
                difference()
                {
                    // Inner space for the cards
                    translate([-1.5, 0, 4])
                        union()
                        {
                            translate([3, -100, 10]) rotate([0, 0, 90]) prism(200, 1.5, 80);
                            translate([0, 100, 10]) rotate([0, 0, -90]) prism(200, 1.5, 80);
                        }
                    // The sides are full
                    translate([-3.5, 40, 0]) prism(7, 60, 80);
                    rotate([0, 0, 180]) translate([-3.5, 40, 0]) prism(7, 60, 80);
                }
                // Round truncation of the top
                translate([-4.5, 0, 245]) rotate([0, 90, 0]) cylinder(h=9, r=190);
            }
        }
        // Inside round so that cards make a nice round
        difference()
        {
            translate([-2.5, 0, -75]) rotate([0, 90, 0]) cylinder(h=5, r=100);
            translate([-5, -200, -400]) cube([10, 400, 400]);
            translate([-3.5, 50, 0]) prism(7, 50, 80);
            rotate([0, 0, 180]) translate([-3.5, 50, 0]) prism(7, 50, 80);
        }
        
        translate([25, -33, 30]) rotate([90, 0, -90]) token_holder();
        translate([25, 0, 30]) rotate([90, 0, -90]) token_holder();
        translate([25, 33, 30]) rotate([90, 0, -90]) token_holder();
    }
    translate([-20, 0, 72]) // move it up
        rotate([0, 90, 0]) // rotate it
            translate([0, -90, 0]) // center it
                linear_extrude(height=100) offset(r=4, chamfer=true) square([100, 180]);
}
