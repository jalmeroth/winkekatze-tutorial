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
    $s=1;
    $i=3.5;
    $x=$front_x;
    $y=4;
    $z=6;
    $d=3;
    $r=$d/2;
    translate([($base_x-$front_x)/2,$front_y,$base_z])
    difference() {
        color("blue")
        cube([$x,$y,$z]);
        translate([$s,$s,0])
        cube([$x-2*$s,$y-2*$s,$z]);
        rotate([-90,0,0])
        translate([$r+$i,-($base_z+$r),0])
        cylinder(h=$z, d=$d);
        rotate([-90,0,0])
        translate([$front_x-$r-$i,-($base_z+$r),0])
        cylinder(h=$z, d=$d);
    }
}

module leg($d) {
    $h=6;
    difference() {
        cylinder(h=$h, d=$d);
        cylinder(h=$h, d=$d-2);
    }
}

module terminal() {
    $b=9;
    $d=4;
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
$base_z=1;

$front_x=20;
$front_y=15;

difference() {
    base();
    cut_front();
    cut_side();
}
terminal();
mothers();
