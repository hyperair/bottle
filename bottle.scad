include <MCAD/units/metric.scad>
use <MCAD/shapes/polyhole.scad>
use <MCAD/shapes/2Dshapes.scad>

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
    // circle (d = bottle_od);
    ellipse (width = 31, height = 15);
}

module offset_extrude (h, r = 0)
{
    linear_extrude (height = h)
        offset (r = r)
        children ();
}

module bottle_male ()
{
    difference () {
        h = bottle_h / 2;

        union () {
            offset_extrude (h = h)
                children ();

            translate ([0, 0, h - epsilon])
                offset_extrude (h = joint_length + epsilon,
                                r = -wall_thickness / 2)
                children ();
        }

        translate ([0, 0, wall_thickness])
            offset_extrude (h = h + joint_length, r = -wall_thickness)
            children ();
    }
}

module bottle_female ()
{
    difference () {
        h = bottle_h / 2;

        offset_extrude (h = h)
            children ();

        translate ([0, 0, wall_thickness])
            offset_extrude (h = h, r = -wall_thickness)
            children ();

        translate ([0, 0, h - joint_length - clearance])
            offset_extrude (h = h,
                            r = -(wall_thickness / 2 - clearance))
            children ();
    }
}

module bottle_pair (separation = [40, 0, 0])
{
    bottle_male ()
        children ();

    translate (separation)
        bottle_female ()
        children ();
}

bottle_pair ()
ellipse (width = 31, height = 15);

translate ([0, 20, 0])
bottle_pair ()
square ([31, 15], center = true);

translate ([0, 40, 0])
bottle_pair ()
offset (r = 4)
offset (r = -4)
square ([31, 15], center = true);

translate ([0, 70, 0])
bottle_pair ()
circle (d = 31);
