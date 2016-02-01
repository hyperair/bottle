include <MCAD/units/metric.scad>
use <MCAD/shapes/polyhole.scad>

bottle_id = 31;
bottle_ih = 120;

wall_thickness = 1.6;

bottle_od = bottle_id + wall_thickness * 2;
bottle_h = bottle_ih + wall_thickness * 2;

joint_length = 10;

clearance = 0.3;

$fs = 0.4;
$fa = 1;

module bottle_male ()
{
    difference () {
        h = bottle_h / 2;

        union () {
            cylinder (d = bottle_od, h = h);

            translate ([0, 0, h - epsilon])
                cylinder (d = bottle_od - wall_thickness, h = joint_length);
        }

        translate ([0, 0, wall_thickness])
            cylinder (d = bottle_id, h = h + joint_length);
    }
}

module bottle_female ()
{
    difference () {
        h = bottle_h / 2;

        cylinder (d = bottle_od, h = h);

        union () {
            translate ([0, 0, wall_thickness])
                cylinder (d = bottle_id, h = h);

            translate ([0, 0, h - joint_length - clearance])
                mcad_polyhole (d = bottle_id + wall_thickness + clearance,
                               h = joint_length + clearance + epsilon);
        }
    }
}

bottle_male ();

translate ([40, 0, 0])
bottle_female ();
