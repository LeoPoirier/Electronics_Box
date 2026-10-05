//
// Parametric electronic project box - side-opening version
// OpenSCAD
//

$fn = 64;


// ============================================================
// Main enclosure parameters
// ============================================================

box_width  = 120;
box_depth  = 80;
box_height = 40;

wall_thickness  = 2.4;
closed_end_thickness = 3.0;


// ============================================================
// PCB groove parameters
// ============================================================

pcb_thickness  = 1.6;
pcb_clearance  = 0.3;
groove_height  = pcb_thickness + 2 * pcb_clearance;
groove_depth   = 1.5;
groove_bottom  = 16;
groove_on_top_bottom = false;


// ============================================================
// Lid parameters
// ============================================================

lid_thickness     = 3.0;
lid_overhang       = 1.0;
lid_display_gap    = 6.0;
show_lid           = true;


// ============================================================
// Screw / boss parameters
// ============================================================

screw_offset = 8.0;

// How far the boss extends past the screw center, into the box
screw_boss_margin = 6.0;

// Fillet radius on the boss's inner corner (facing the cavity)
screw_boss_corner_radius = 4.0;

// How far the boss protrudes inward from the opening face
screw_boss_depth = 6.0;

base_pilot_hole_diameter   = 2.6;
lid_clearance_hole_diameter = 3.4;

epsilon = 0.05;


// ============================================================
// Validation
// ============================================================

assert(wall_thickness > 0);
assert(closed_end_thickness > 0);
assert(groove_depth > 0);
assert(groove_depth < wall_thickness);
assert(groove_bottom >= wall_thickness);
assert(groove_bottom + groove_height <= box_height - wall_thickness);
assert(box_width  > 2 * wall_thickness);
assert(box_depth  > 2 * wall_thickness);
assert(box_height > 2 * wall_thickness);
assert(screw_boss_corner_radius < screw_boss_margin,
    "screw_boss_corner_radius must be smaller than screw_boss_margin");
assert(screw_offset + screw_boss_margin < box_depth  / 2);
assert(screw_offset + screw_boss_margin < box_height / 2);


// ============================================================
// Screw center positions (Y-Z plane of the opening face)
// ============================================================

screw_centers_yz = [
    [screw_offset,                 screw_offset],
    [box_depth  - screw_offset,    screw_offset],
    [box_depth  - screw_offset,    box_height - screw_offset],
    [screw_offset,                 box_height - screw_offset]
];


// ============================================================
// Basic shell
// ============================================================

module basic_shell() {
    difference() {
        cube([box_width, box_depth, box_height]);

        translate([
            closed_end_thickness,
            wall_thickness,
            wall_thickness
        ])
        cube([
            box_width - closed_end_thickness + epsilon,
            box_depth  - 2 * wall_thickness,
            box_height - 2 * wall_thickness
        ]);
    }
}


// ============================================================
// PCB groove cutters (fixed: stops before the closed end wall)
// ============================================================

module pcb_groove_cutters() {

    groove_length = box_width - closed_end_thickness + epsilon;

    translate([
        closed_end_thickness - epsilon,
        box_depth - wall_thickness - epsilon,
        groove_bottom
    ])
    cube([groove_length, groove_depth + epsilon, groove_height]);

    translate([
        closed_end_thickness - epsilon,
        wall_thickness - groove_depth,
        groove_bottom
    ])
    cube([groove_length, groove_depth + epsilon, groove_height]);

    if (groove_on_top_bottom) {

        translate([
            closed_end_thickness - epsilon,
            wall_thickness,
            wall_thickness - groove_depth
        ])
        cube([groove_length, box_depth - 2 * wall_thickness, groove_depth + epsilon]);

        translate([
            closed_end_thickness - epsilon,
            wall_thickness,
            box_height - wall_thickness - epsilon
        ])
        cube([groove_length, box_depth - 2 * wall_thickness, groove_depth + epsilon]);
    }
}


// ============================================================
// Screw bosses: flat posts, flush with both walls,
// rounded only on the inner corner facing the cavity
// ============================================================

module screw_boss(position) {
    corner_y = (position[0] < box_depth  / 2) ? 0 : box_depth;
    corner_z = (position[1] < box_height / 2) ? 0 : box_height;

    dir_y = (corner_y == 0) ? 1 : -1;
    dir_z = (corner_z == 0) ? 1 : -1;

    inner_y = position[0] + dir_y * screw_boss_margin;
    inner_z = position[1] + dir_z * screw_boss_margin;

    ymin = min(corner_y, inner_y);
    ymax = max(corner_y, inner_y);
    zmin = min(corner_z, inner_z);
    zmax = max(corner_z, inner_z);

    r = screw_boss_corner_radius;

    // Slab A: full Y span, shortened in Z on the inner side by r
    zminA = (dir_z > 0) ? zmin : zmin + r;
    zmaxA = (dir_z > 0) ? zmax - r : zmax;

    // Slab B: full Z span, shortened in Y on the inner side by r
    yminB = (dir_y > 0) ? ymin : ymin + r;
    ymaxB = (dir_y > 0) ? ymax - r : ymax;

    // Fillet cylinder center, pulled back by r from the inner corner
    cyl_y = inner_y - dir_y * r;
    cyl_z = inner_z - dir_z * r;

    translate([box_width - screw_boss_depth, 0, 0])
    hull() {
        translate([0, ymin, zminA])
            cube([screw_boss_depth, ymax - ymin, zmaxA - zminA]);

        translate([0, yminB, zmin])
            cube([screw_boss_depth, ymaxB - yminB, zmax - zmin]);

        translate([0, cyl_y, cyl_z])
        rotate([0, 90, 0])
        cylinder(h = screw_boss_depth, r = r);
    }
}

module screw_bosses() {
    for (position = screw_centers_yz) {
        screw_boss(position);
    }
}


// ============================================================
// Pilot holes in the box (fixed: now actually cuts into the boss)
// ============================================================

module base_screw_holes() {
    for (position = screw_centers_yz) {
        translate([
            box_width - screw_boss_depth - epsilon,
            position[0],
            position[1]
        ])
        rotate([0, 90, 0])
        cylinder(
            h = screw_boss_depth + 2 * epsilon,
            d = base_pilot_hole_diameter
        );
    }
}


// ============================================================
// Complete box base
// ============================================================

module box_base() {
    difference() {
        union() {
            basic_shell();
            screw_bosses();
        }

        pcb_groove_cutters();
        base_screw_holes();
    }
}


// ============================================================
// Lid screw holes
// ============================================================

module lid_screw_holes() {
    for (position = screw_centers_yz) {
        translate([
            -epsilon,
            position[0] + lid_overhang,
            position[1] + lid_overhang
        ])
        rotate([0, 90, 0])
        cylinder(
            h = lid_thickness + 2 * epsilon,
            d = lid_clearance_hole_diameter
        );
    }
}


// ============================================================
// Complete lid
// ============================================================

module box_lid() {
    translate([
        box_width + lid_display_gap,
        -lid_overhang,
        -lid_overhang
    ])
    difference() {
        cube([
            lid_thickness,
            box_depth  + 2 * lid_overhang,
            box_height + 2 * lid_overhang
        ]);

        lid_screw_holes();
    }
}


// ============================================================
// Assembly
// ============================================================

box_base();

if (show_lid) {
    box_lid();
}