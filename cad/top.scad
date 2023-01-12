$fn=100;

module base() {
    $h=0.1;
    $d=5;
    $r=$d/2;
    translate([$r,$r,0])
    minkowski() {
        cube([$base_x-$d,$base_y-$d,$base_z-$h]);
        cylinder(h=$h, d=$d);
    }
}

module cut_side() {
    $x=5;
    $y=5;
    $z=$base_z;
    translate([0,$base_y-$y-10,0])
    union() {
        cube([$x,$y,$z]);        
        translate([$x,0,0])
        linear_extrude(height=$base_z) {
            hull() {
                translate([0,$y,0]) circle(2);
                circle(2);
            }
        }
    }
}

module mothers() {
    $ip=3.5;        // inner padding    
    $ws=1;          // wall size
    $sz=2.25;       // mother's height
    $x=$front_x;    // width
    $y=$sz+2*$ws;   // depth
    $z=6;           // height    
    $d=3;           // screw's d
    $r=$d/2;        // screw's r

    translate([($base_x-$front_x)/2,$front_y,$base_z])

    difference() {
        cube([$x,$y,$z]);
        translate([$ws,$ws,0])
        cube([$x-2*$ws,$sz,$z]);

        rotate([-90,0,0])
        translate([$r+$ip,-($z-$d),0])
        cylinder(h=$z, d=$d);

        rotate([-90,0,0])
        translate([$front_x-$r-$ip,-($z-$d),0])
        cylinder(h=$z, d=$d);
    }
}

$base_x=40;
$base_y=30;
$base_z=10;

$ws=1.6;

$front_x=20;
$front_y=15;


difference() {
    base();
    color("blue")
    translate([0, $ws, 0])
    cube([$base_x,$base_y-2*$ws,$base_z-$ws]);
//    cut_side();
}
mothers();
