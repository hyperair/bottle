include <MCAD/units/metric.scad>
use <MCAD/shapes/polyhole.scad>

tube_d = 31;
tube_h = 120;

wall_thickness = 1.6;

bottle_od = tube_d + wall_thickness * 2;
bottle_h = tube_h + wall_thickness * 2;

joint_length = 10;

clearance = 0.3;

$fs = 0.4;
$fa = 1;

module tube_male ()
{
    difference () {
        h = bottle_h / 2;

        union () {
            cylinder (d = bottle_od, h = h);

            translate ([0, 0, h - epsilon])
                cylinder (d = bottle_od - wall_thickness, h = joint_length);
        }

        translate ([0, 0, wall_thickness])
            cylinder (d = tube_d, h = h + joint_length);
    }
}

module tube_female ()
{
    difference () {
        h = bottle_h / 2;

        cylinder (d = bottle_od, h = h);

        union () {
            translate ([0, 0, wall_thickness])
                cylinder (d = tube_d, h = h);

            translate ([0, 0, h - joint_length - clearance])
                mcad_polyhole (d = tube_d + wall_thickness + clearance,
                               h = joint_length + clearance + epsilon);
        }
    }
}

tube_male ();

translate ([40, 0, 0])
tube_female ();
