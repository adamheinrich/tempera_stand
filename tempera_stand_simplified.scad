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
step_rear = 0; // Disable rear step as reversibility will not work here
has_rear_feet = false;
