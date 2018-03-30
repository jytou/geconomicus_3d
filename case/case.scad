module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module token_holder(nbtokens)
{
    tokenh=1.8;
    scale(1.6) translate([8.5, 0, 0]) rotate([0, 0, 45]) difference()
    {
        cylinder(h=nbtokens*tokenh, r=8.5);
        translate([0, 0, 1]) cylinder(h=nbtokens*tokenh, r=7.5);
        translate([7, 7, -1]) cylinder(h=nbtokens*tokenh + 2, r=7.5);
    }
}

module cover(nbtokens)
{
    tokenh=1.8;
    scale(1.6) translate([8.5, 0, 0]) rotate([0, 0, 45]) union()
    {
        translate([0, 0, nbtokens*tokenh]) cylinder(h=1, r=8.5);
        translate([0, 0, 0]) intersection()
        {
            difference()
            {
                cylinder(h=nbtokens*tokenh, r=8.5);
                translate([0, 0, -1]) cylinder(h=nbtokens*tokenh+1, r=7.5);
            }
            translate([7.5, 7.5, -1]) cylinder(h=nbtokens*tokenh + 3, r=7.5);
        }
    }
}

module latch_up(width)
{
    union()
    {
        difference()
        {
            union()
            {
                //translate([-2.84, 0, -1]) rotate([180, 0, 90]) prism(5, width, 10);
                rotate([-90, 0, 0]) cylinder(h=width*3, r=3);
                translate([-2.5, 0, 0]) cube([6, width*3, 3]);
            }
            translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(h=width*3+2, r=1.5);
            translate([2, -1, -10]) cube([2, width*3+2, 20]);
            translate([-5, width-0.5, -5]) cube([10, width+1, 10]);
        }
        // The part that links to the cover
        translate([10, 8, 3]) difference()
        {
            cylinder(h=1.6, r=15);
            translate([5, -20,-0.1]) cube([40, 40, 2]);
        }
    }
}

module latch_down(width)
{
    difference()
    {
        union()
        {
            translate([-2.84, 0, -1]) rotate([180, 0, 90]) prism(5, width, 10);
            rotate([-90, 0, 0]) cylinder(h=width, r=3);
        }
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(h=width+2, r=1.5);
    }
}

nbtoks=20;
nbrows=6;
latch_width=5;
cover_only=false;

$fn=100;
union()
{
	if (cover_only)
	{
		// Cover
		translate([0, 0, 0]) union()
		{
			for (x = [0:nbrows-1])
			{
				translate([x * 16*1.6, 16*1.6, 0]) cover(nbtoks);
				translate([(x+1) * 16*1.6+1.6, 0, 0]) rotate([0, 0, 180]) cover(nbtoks);
			}
			translate([0, 0, nbtoks*1.8*1.6]) cube([nbrows*1.6*16+1.6, 25, 1.6]);
			translate([-2, 13-3*latch_width/2, nbtoks*1.8*1.6-3]) latch_up(latch_width);
			translate([nbrows*1.6*16+3.6, 13+5/2+5, nbtoks*1.8*1.6-3]) rotate([0, 0, 180]) latch_up(latch_width);
		}
	}
	else
	{
	    // Case
		for (x = [0:nbrows-1])
		{
			translate([x * 16*1.6, 16*1.6, 0]) token_holder(nbtoks);
			translate([(x+1) * 16*1.6+1.6, 0, 0]) rotate([0, 0, 180]) token_holder(nbtoks);
		}
		cube([nbrows*1.6*16, 25, 1.6]);
		cube([1.6, 25, nbtoks*1.8*1.6]);
		translate([nbrows*1.6*16, 0, 0]) cube([1.6, 25, nbtoks*1.8*1.6]);
		translate([-2, 13-5/2, nbtoks*1.8*1.6-3]) latch_down(5);
		translate([-1.4+nbrows*1.6*16+5, 13+5/2, nbtoks*1.8*1.6-3]) rotate([0, 0, 180]) latch_down(5);
	}
}
