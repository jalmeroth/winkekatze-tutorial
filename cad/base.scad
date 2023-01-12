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

module cut_front() {
    translate([($base_x-$front_x)/2,0,0])
    cube([$front_x,$front_y,$base_z]);
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
    $ip=3.8;        // inner padding    
    $ws=1;          // wall size
    $sz=2.25;       // mother's height
    $x=$front_x;    // width
    $y=$sz+2*$ws;   // depth
    $z=5.5;         // height    
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

module leg($d) {
    $h=6; // 14 kleiner Motor
    difference() {
        cylinder(h=$h, d=$d);
        cylinder(h=$h, d=2);
    }
}

module terminal() {
    $b=8.5;
    $d=5;
    $r=$d/2;
    translate([$r+$b,$r,$base_z])
    leg($d);
    translate([$r+$b,$d+$r+21,$base_z])
    leg($d);
    translate([$base_x-$r-$b,$r,$base_z])
    leg($d);
    translate([$base_x-$r-$b,$d+$r+21,$base_z])
    leg($d);
}

$base_x=50;
$base_y=40;
$base_z=1.6;

$front_x=20;
$front_y=15;

difference() {
    base();
    cut_front();
    cut_side();
}
terminal();
mothers();
