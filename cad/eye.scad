$fn=100;

$material=2;
$base_w=50;
$base_d=16;
$led_space = 31.5;
$led_d=8;
$cabel_w=5;
$cabel_d=10;

difference() {
    cube([$base_w, $base_d, $material]);

    translate([
        ($base_w-$led_space)/2,
        $base_d/2,
        0
    ])
    cylinder(h=$material, d=$led_d, center=false);

    translate([
    ($base_w-$cabel_w)/2,
    ($base_d-$cabel_d)/2,
    0
    ])
    cube([$cabel_w,$cabel_d,$material]);

    translate([
        $base_w-(($base_w-$led_space)/2),
        $base_d/2,
        0
    ])
    cylinder(h=$material, d=$led_d, center=false);
}