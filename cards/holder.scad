module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module slit_polyhedron_broken()
{
	polyhedron(
		points=[[-2.5, 0, 15], [2.5, 0, 15], [-0.5, -40, 0], [0.5, -40, 0], [-0.5, 40, 0], [0.5, 40, 0], [-0.5, 80, 65], [0.5, 80, 65], [-0.5, -80, 65], [0.5, -80, 65], [-1.5, 0, 55], [1.5, 0, 55]],
		faces=[[0, 2, 3, 1], [0, 1, 5, 4], [8, 9, 3, 2], [7, 6, 4, 5], [10, 11, 6, 7], [9, 8, 11, 10], [9, 10, 1, 3], [10, 7, 5, 1], [6, 11, 0, 4], [11, 8, 2, 0]]
	);
}

module slit_prism()
{
	maxspace=2.5;
	// Inner space for the cards
	translate([-maxspace, 0, 4])
		union()
		{
			translate([maxspace*2, -100, 1]) rotate([0, 0,  90]) prism(200, maxspace, 80);
			translate([0,           100, 1]) rotate([0, 0, -90]) prism(200, maxspace, 80);
		}
}

module slit_sphere()
{
	union()
	{
		ray=1700;
		maxspace=2.4;
		intersection()
		{
			translate([-maxspace, -100, 0]) cube([maxspace, 200, 100]);
			$fn=1000;
			translate([ray-maxspace, 0, 15])
				//sphere(r=ray);
				// Because a sphere is too costly in computation, optimize this with only what we need
				rotate([0, 0, 180-5]) rotate_extrude(angle=10) intersection()
				{
					circle(r=ray);
					translate([ray-maxspace, -100]) square([maxspace, 200]);
				}
		}
		intersection()
		{
			translate([0, -100, 0]) cube([maxspace, 200, 100]);
			$fn=1000;
			translate([-ray+maxspace, 0, 15])
				//sphere(r=ray);
				// Because a sphere is too costly in computation, optimize this with only what we need
				rotate([0, 0, -5]) rotate_extrude(angle=10) intersection()
				{
					circle(r=ray);
					translate([ray-maxspace, -100]) square([maxspace, 200]);
				}
		}
	}
}

module token()
{
    $fn=100;
    under=0.8;
    scale(1.65) difference()
    {
        union()
        {
            tore(1, 6);
            cylinder(h=1, r=6);
            translate([0, 0, -under]) cylinder(h=under, r=6);
        }
        translate([-10, -10, -20-under]) cube([20, 20, 20]);
    }
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
        translate([0, 0, 1]) cylinder(h=14, r=8);
        translate([7, 7, -1]) cylinder(h=16, r=7.5);
    }
}

module token_holder_vert()
{
    rotate([0, 80, 0]) union()
    {
        cylinder(h=16, r=12);
        translate([-12-12, -12, 0]) cube([24, 24, 16]);
    }
}

module token_holder_horiz()
{
	union()
	{
		cylinder(h=25, r=11.5);
		translate([8, -8, -1.5]) rotate([0, 0, 90]) linear_extrude(height=2) text("Ğ", size=14);
	}
}

module tore(smallr, bigr, angle=360)
{
    rotate([0, 0, -angle/2]) rotate_extrude(angle=angle) translate([bigr, 0, 0]) circle(r=smallr);
}

$fn=200;
tokens_ring=false;
horizontal_tokens=true;
difference()
{
	union()
	{
		union()
		{
			intersection()
			{
				large=145;
				high=120;
				translate([0, 0, 0]) union()
				{
					translate([-10, -large/2, 0]) cube([20, large, 40]);
					translate([-10, -high/2, 0]) cube([20, high, 62]);
					translate([-10, -59, 46]) rotate([0, 90, 0]) cylinder(h=20, r=16.8);
					translate([-10, 59, 46]) rotate([0, 90, 0]) cylinder(h=20, r=16.8);
				}
				difference()
				{
					// Main cube
					translate([-3.5, -100, 0]) cube([7, 200, 80]);
					union()
					{
						// Truncation of the side of the main cube
						translate([-4, 50, 0]) prism(8, 50, 80);
						// Truncation of the other side
						rotate([0, 0, 180]) translate([-4, 50, 0]) prism(8, 50, 80);
						difference()
						{
							slit_sphere();
							// The sides are full
							translate([-3.5, 40, 0]) prism(7, 60, 80);
							rotate([0, 0, 180]) translate([-3.5, 40, 0]) prism(7, 60, 80);
						}
						// Round truncation of the top
						translate([0, 0, 240]) rotate([0, 90, 0]) cylinder(h=9, r1=190, r2=180);
						translate([0, 0, 240]) rotate([0, 90, 180]) cylinder(h=9, r1=190, r2=180);
					}
				}
			}
			// Inside round so that cards make a nice round
			difference()
			{
				translate([-2.5, 0, -85]) rotate([0, 90, 0]) cylinder(h=5, r=100);
				translate([-5, -200, -400]) cube([10, 400, 400]);
				translate([-3.5, 50, 0]) prism(7, 50, 80);
				rotate([0, 0, 180]) translate([-3.5, 50, 0]) prism(7, 50, 80);
			}

			if (tokens_ring)
			{
				// The ring on which the token holders are placed
				difference()
				{
					translate([0, 0, 5]) tore(10, 35);
					translate([-97, -50, -20]) cube([100, 100, 100]);
					translate([0, -50, -30]) cube([60, 100, 30]);
					translate([17, -33, 0]) scale(1.6) cylinder(h=30, r=9);
					translate([40, 0, 0]) scale(1.6) cylinder(h=30, r=9);
					translate([17, 33, 0]) scale(1.6) cylinder(h=30, r=9);
				}
				// The token holders - 3 of them
				translate([17, -33, 0]) rotate([0, 0, -90]) token_holder();
				translate([40, 0, 0]) rotate([0, 0, -45]) token_holder();
				translate([17, 33, 0]) rotate([0, 0, 0]) token_holder();
			}
			else
			// Round grip on the front rather than the ring
			{
				difference()
				{
					intersection()
					{
						difference()
						{
							union()
							{
								translate([-28, -60, 35]) rotate([-55, 0, 0]) tore(8, 30, 70);
								translate([-28, 60, 35]) rotate([55, 0, 0]) tore(8, 30, 70);
								if (horizontal_tokens)
									translate([-26, 0, 15]) tore(30, 30, 120);
								else
								{
									translate([-26, 0, 10]) tore(25, 35, 120);
									translate([31, -5, 21]) rotate([0, 48, 0]) rotate([0, 0, 90]) linear_extrude(height=2) text("Ğ", size=10);
								}
							}
						}
						translate([3.5, -100, 0]) cube([40, 200, 100]);
					}
					if (horizontal_tokens)
					{
						translate([22, 0, 22]) token_holder_horiz();
						translate([15, 25, 22]) rotate([0, 0, 30]) token_holder_horiz();
						translate([15, -25, 22]) rotate([0, 0, -30]) token_holder_horiz();
					}
					else
					{
						translate([5.2, 0, 29]) token_holder_vert();
						translate([5, 26, 25]) token_holder_vert();
						translate([5, -26, 25]) token_holder_vert();
					}
					// Areas for the thumbs
					translate([33, -14, 12]) rotate([90, 0, 0]) cylinder(h=30, r=10);
					translate([33, -14, 12]) sphere(r=10);
					translate([33, 14, 12]) rotate([-90, 0, 0]) cylinder(h=30, r=10);
					translate([33, 14, 12]) sphere(r=10);
				}
			}
		}
/*		union()
		{
			// Some token samples
			for (x = [0:4])
			{
				translate([5, 0, 29]) rotate([0, 80, 0]) translate([0, 0, 2+x*3]) token();
				translate([5, 26, 25]) rotate([0, 80, 0]) translate([0, 0, 2+x*3]) token();
				translate([5, -26, 25]) rotate([0, 80, 0]) translate([0, 0, 2+x*3]) token();
			}
		}*/
		union()
		// The front round to help the user get a better grip
		{
			intersection()
			{
				translate([85, 0, 10]) rotate([0, 0, 180]) tore(20, 80, 60);
				translate([-20-3.5, -100, 0]) cube([20, 200, 50]);
			}
		}
		if (tokens_ring)
			union()
			// The extra part near the thumb to stick some gentler stuff there
			{
				translate([24, 0, 9]) rotate([0, 90, 0]) cylinder(h=2.5, r=9);
				translate([24, -11, 0]) cube([2.5, 22, 8]);
			}
	}
	if (!tokens_ring && !horizontal_tokens)
	{
		difference()
		{
			union()
			{
				translate([18.5, 0, 38]) rotate([0, 10, 0]) union()
				{
					cylinder(h=20, r=16);
					sphere(r=16);
				}
				translate([18.5, 26, 36]) rotate([0, 10, 0]) union()
				{
					cylinder(h=20, r=16);
					sphere(r=16);
				}
				translate([18.5, -26, 36]) rotate([0, 10, 0]) union()
				{
					cylinder(h=20, r=16);
					sphere(r=16);
				}
			}
			translate([7, -100, 0]) cube([50, 200, 100]);
		}
	}
//	translate([-100, -100, 0]) cube([100, 200, 100]);
}