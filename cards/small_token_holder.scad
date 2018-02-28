module token_holder()
{
    scale(1.6) difference()
    {
        union()
        {
            cylinder(h=14, r=8.5);
            cylinder(h=0.5, r=8.5);
        }
        translate([0, 0, 1]) cylinder(h=14, r=7.5);
        translate([7, 7, -1]) cylinder(h=16, r=7.5);
    }
}

$fn=100;
token_holder();
