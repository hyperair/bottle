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

module bottle_cross_section ()
{
    circle (d = bottle_od);
}

module extruded_bottle (h, offset_r = 0)
{
    linear_extrude (height = h)
        offset (r = offset_r)
        bottle_cross_section ();
}

module bottle_male ()
{
    difference () {
        h = bottle_h / 2;

        union () {
            extruded_bottle (h = h);

            translate ([0, 0, h - epsilon])
                extruded_bottle (h = joint_length + epsilon,
                                 offset_r = -wall_thickness / 2);
        }

        translate ([0, 0, wall_thickness])
            extruded_bottle (h = h + joint_length, offset_r = -wall_thickness);
    }
}

module bottle_female ()
{
    difference () {
        h = bottle_h / 2;

        extruded_bottle (h = h);

        translate ([0, 0, wall_thickness])
            extruded_bottle (h = h, offset_r = -wall_thickness);

        translate ([0, 0, h - joint_length - clearance])
            extruded_bottle (h = h,
                             offset_r = -(wall_thickness / 2 - clearance));
    }
}

bottle_male ();

translate ([40, 0, 0])
bottle_female ();
