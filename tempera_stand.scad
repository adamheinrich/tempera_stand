/*
 *  Parametric stand for the Tempera synthesizer
 *
 *  Copyright (C) 2024 Adam Heinrich <adam@beetlecrab.audio>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

$fn = 100;

include <test_models.scad>;

/* Gear geometry: */
gear_size = 194;

gear_feet_size = 16;
gear_feet_to_hole = 31;
gear_feet_depth = 2.6;

mounting_hole_offset = 47;
mounting_hole_dist = 100; // VESA 100x100

/* Stand geometry: */
stand_thickness = 10;
stand_width = 22;

step_front = 10;
step_rear = step_front; // Useful for reversible stands (set step_rear = step_front)

shear = 0;
angle = 28;

r2 = 1.5;
r1 = r2 * 2;

/* Screw parameters
   MPN: DIN464-M4-8: */
screw_head_diameter = 12;
screw_thread_length = 8;

screw_depth = 5.5; // How much the screw is recessed inside the stand
screw_through = false;

/* Bottom rubber feet parameters
   MPN: 3M SJ5012 (7000001884): */
has_bottom_feet = true;
has_rear_feet = true;
foot_diameter = 12.7 + 0.8;
foot_depth = 1.0;
foot_edge_distance = 10;

/* Computed global variables: */
hyp = gear_size;
x = hyp * cos(angle);
y = hyp * sin(angle);

module stand_2d() {
    pts=[[0, step_front],
         [0, 0],
         [x + shear + step_rear, 0],
         [x + step_rear, y + step_front],
         [x, y + step_front]];

    difference() {
        offset(r=r2) offset(delta=-r2) {
            polygon(pts);
        }

        offset(r=r1) offset(delta = -(stand_thickness + r1)) {
            polygon(pts);
        }
    }
}

module stand_3d() {
    mirror([0, 0, 1])
    difference() {
        /* Main body: */
        linear_extrude(stand_width, center=true) {
            stand_2d();
        }

        /* Counterbore screw holes: */
        translate([0, step_front, 0]) {
            rotate([-90, 0, angle]) {
                for (p=[0, mounting_hole_dist]) {
                    dz = 0.05; // Why is this needed?
                    translate([mounting_hole_offset + p, 0, -stand_thickness - dz]) {
                        cylinder(d=4.4, h=1000);
                        cylinder(d=screw_head_diameter, h=screw_depth);

                        if (screw_through) {
                            rotate([0,180,0]) {
                                cylinder(d=screw_head_diameter, h=1000);
                            }
                        }
                    }
                }
            }
        }

        /* Gear feet cutouts (Tempera specific): */
        translate([0, step_front, 0]) {
            rotate([-90, 0, angle]) {
                for (p=[0, mounting_hole_dist] + [-1, 1] * gear_feet_to_hole) {
                    translate([mounting_hole_offset + p, stand_width/2, 0]) {
                        cube(
                            [gear_feet_size, stand_width, gear_feet_depth*2],
                            center=true
                        );
                    }
                }
            }
        }

        /* Bottom feet: */
        if (has_bottom_feet) {
            foot_pts = [
                foot_edge_distance + foot_diameter / 2,
                x + shear + step_rear - foot_edge_distance - foot_diameter / 2,
            ];
            rotate([90, 0, 0]) {
                for (dx=foot_pts) {
                translate([dx, 0, -foot_depth])
                    cylinder(d=foot_diameter, h=1000);
                }
            }
        }

        /* Rear feet: */
        if (has_rear_feet) {
            foot_pts = [
                foot_edge_distance + foot_diameter / 2,
                y + step_rear - foot_edge_distance - foot_diameter / 2,
            ];
            rotate([0, 90, 0]) {
                for (dy=foot_pts) {
                    translate([0, dy, x + shear + step_rear - foot_depth]) {
                        cylinder(d=foot_diameter, h=1000);
                    }
                }
            }
        }
    }
}


/* Output: */

thread_length_inside = screw_thread_length - (stand_thickness - screw_depth);
echo(str("Thread length inside Tempera: ", thread_length_inside, "mm"));

assert(
    thread_length_inside <= 5.0,
    "Thread length inside Tempera must be less than 5 mm, risk of damage!"
);

render_default = true; // Allows to override the rendering step
render_assembly = false; // Renders assembly for visual verification

if (render_default) {
    if (render_assembly) {
        stand_3d();
        tempera();
        screws_din464(0);
        //screws_inbus(0);
    } else {
        //mirror([0, 0, 1])
        stand_3d();
    }
}
