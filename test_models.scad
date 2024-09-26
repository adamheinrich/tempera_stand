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

/* Tempera body */
module tempera() {
    tempera_size = 194;
    tempera_width = 20;
    tempera_height = 34;

    translate([0, step_front, -tempera_height/2]) {
        rotate([0, 0, angle]) {
            translate([0, 0, 0])
            color("black") {
                cube([tempera_size, tempera_width, tempera_height]);
            }
        }
    }
}

/* DIN464 M4x8 screw */
module screws_din464(assembly_depth = 0) {
    translate([0, step_front, 0]) {
        rotate([-90, 0, angle]) {
            for (p=[0, mounting_hole_dist]) {
                translate([mounting_hole_offset + p, 0, -stand_thickness - assembly_depth]) {
                    translate([0, 0, screw_depth - 9.5]) {
                        color("black") {
                            cylinder(d=8, h=9.5);
                            cylinder(d=16, h=3.5);
                        }
                    }

                    translate([0, 0, screw_depth]) {
                        color("black") {
                            cylinder(d=4, h=8);
                        }
                    }
                }
            }
        }
    }
}

/* DIN912 M4x10 inbus screw */
module screws_inbus(assembly_depth = 0) {
    translate([0, step_front, 0]) {
        rotate([-90, 0, angle]) {
            for (p=[0, mounting_hole_dist]) {
                translate([mounting_hole_offset + p, 0, -stand_thickness - assembly_depth]) {
                    translate([0, 0, screw_depth - 4]) {
                        color("silver") {
                            cylinder(d=7, h=4);
                        }
                    }

                    translate([0, 0, screw_depth]) {
                        color("silver") {
                            cylinder(d=4, h=10);
                        }
                    }
                }
            }
        }
    }
}
