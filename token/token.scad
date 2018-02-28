module tore(smallr, bigr)
{
    rotate_extrude() translate([bigr, 0, 0]) circle(r=smallr);
}

$fn=100;
under=0.8;
scale(1.6) difference()
{
    union()
    {
        tore(1, 6);
        translate([-3.8, -4, 0]) scale([0.7, 0.7, 1]) linear_extrude(height=1) text("Ğ");
        translate([0, 0, -under]) cylinder(h=under, r=6);
    }
    translate([-10, -10, -20-under]) cube([20, 20, 20]);
}
