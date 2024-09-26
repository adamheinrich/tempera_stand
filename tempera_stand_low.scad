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

include <tempera_stand.scad>;

/* Stand geometry: */
step_front = 10;
step_rear = 0; // Disable rear step as reversibility will not work here

shear = 0;
angle = 15;

has_rear_feet = false;

/* Screw parameters (M4x10 inbus): */
screw_head_diameter = 8;
screw_thread_length = 10;

screw_depth = 5; // How much the screw is recessed inside the stand
screw_through = true;

/* Output: */

render_default = false; // Disable the rendering step from tempera_stand.scad
render_assembly = false; // Set true for visual inspection

if (render_assembly) {
    stand_3d();
    tempera();
    screws_inbus(23);
} else {
    //mirror([0, 0, 1])
    stand_3d();
}
