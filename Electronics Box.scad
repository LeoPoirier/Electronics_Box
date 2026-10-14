//
// Parametric electronic project box - side-opening version
// OpenSCAD
//
/* [Display Options] */
$fn = 64;

show_box = true;
show_lid = true;
lid_on_side = true;

// ============================================================
// Main enclosure parameters
// ============================================================
/* [Box & Lid basic setting] */
//Exterior depth (PCB depth+ Closed_end_thickness)
box_depth  = 120.0; 
//Recomended PCB WIdth + Wall Thickness (PCB enters wall on half its thickness)
box_width  = 80.0;
//exterior Height
box_height = 40.0;

//Thickness of the 4 walls Perpendiculars to the Lid
wall_thickness  = 2.4;
//Thickness of the wall Parallel to the Lid
closed_end_thickness = 3.0;

// ============================================================
// Fillet parameters
// ============================================================

//Corner fillets for Box
enable_box_fillet = true;
//Corner fillets for Lid
enable_lid_fillet  = true;

fillet_radius = 2.0;

// ============================================================
// PCB groove parameters
// ============================================================

//With of the PCB+ clearance
pcb_width = 78.0;
//Height of the PCB + clearance
groove_height  = 2.0;
//distance from the bottom of the groove to the bottom Wall
groove_bottom  = 16.0;

inner_cavity_width = box_width - 2 * wall_thickness;
groove_depth = (pcb_width - inner_cavity_width) / 2;
echo("Computed groove_depth =", groove_depth);

// ============================================================
// Lid parameters
// ============================================================

lid_thickness     = 3.0;
lid_overhang       = 0.0;
lid_display_gap    = 6.0;



// ============================================================
// Screw / boss parameters
// ============================================================

/* [Screw Holes parameters] */

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

screw_boss_chamfer_depth = 3.0;

// include


include <Wall_Features.scad>

// ============================================================
// Wall / Lid Features
// ============================================================
// face:  0 = lid, 1 = closed end, 2 = left wall,
//        3 = right wall, 4 = bottom, 5 = top
// u, v:  position in that face's local frame (mm), origin at
//        the bottom-left corner as seen from outside
// rot:   in-plane rotation of the feature (degrees)
// a-d:   generic parameter slots, meaning depends on `type`
//        (circular_hole: a = diameter)
// ============================================================

/* [Feature 1] */
feature1_enabled = true;
feature1_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature1_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature1_u       = 20;
feature1_v       = 10;
feature1_rot     = 0;
feature1_a       = 5;
feature1_b       = 0;
feature1_c       = 0;
feature1_d       = 0;

/* [Feature 2] */
feature2_enabled = false;
feature2_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature2_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature2_u       = 20;
feature2_v       = 10;
feature2_rot     = 0;
feature2_a       = 5;
feature2_b       = 0;
feature2_c       = 0;
feature2_d       = 0;

/* [Feature 3] */
feature3_enabled = false;
feature3_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature3_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature3_u       = 20;
feature3_v       = 10;
feature3_rot     = 0;
feature3_a       = 5;
feature3_b       = 0;
feature3_c       = 0;
feature3_d       = 0;

/* [Feature 4] */
feature4_enabled = false;
feature4_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature4_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature4_u       = 20;
feature4_v       = 10;
feature4_rot     = 0;
feature4_a       = 5;
feature4_b       = 0;
feature4_c       = 0;
feature4_d       = 0;

/* [Feature 5] */
feature5_enabled = false;
feature5_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature5_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature5_u       = 20;
feature5_v       = 10;
feature5_rot     = 0;
feature5_a       = 5;
feature5_b       = 0;
feature5_c       = 0;
feature5_d       = 0;

/* [Feature 6] */
feature6_enabled = false;
feature6_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature6_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature6_u       = 20;
feature6_v       = 10;
feature6_rot     = 0;
feature6_a       = 5;
feature6_b       = 0;
feature6_c       = 0;
feature6_d       = 0;

/* [Feature 7] */
feature7_enabled = false;
feature7_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature7_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature7_u       = 20;
feature7_v       = 10;
feature7_rot     = 0;
feature7_a       = 5;
feature7_b       = 0;
feature7_c       = 0;
feature7_d       = 0;

/* [Feature 8] */
feature8_enabled = false;
feature8_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature8_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature8_u       = 20;
feature8_v       = 10;
feature8_rot     = 0;
feature8_a       = 5;
feature8_b       = 0;
feature8_c       = 0;
feature8_d       = 0;

/* [Feature 9] */
feature9_enabled = false;
feature9_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature9_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature9_u       = 20;
feature9_v       = 10;
feature9_rot     = 0;
feature9_a       = 5;
feature9_b       = 0;
feature9_c       = 0;
feature9_d       = 0;

/* [Feature 10] */
feature10_enabled = false;
feature10_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature10_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature10_u       = 20;
feature10_v       = 10;
feature10_rot     = 0;
feature10_a       = 5;
feature10_b       = 0;
feature10_c       = 0;
feature10_d       = 0;

/* [Feature 11] */
feature11_enabled = false;
feature11_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature11_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature11_u       = 20;
feature11_v       = 10;
feature11_rot     = 0;
feature11_a       = 5;
feature11_b       = 0;
feature11_c       = 0;
feature11_d       = 0;

/* [Feature 12] */
feature12_enabled = false;
feature12_type    = "circular_hole"; // [circular_hole, rectangular_hole, ventilation_hole]
feature12_face    = 2; // [0:Lid, 1:Closed end, 2:Left wall, 3:Right wall, 4:Bottom, 5:Top]
feature12_u       = 20;
feature12_v       = 10;
feature12_rot     = 0;
feature12_a       = 5;
feature12_b       = 0;
feature12_c       = 0;
feature12_d       = 0;

// ============================================================
// Validation
// ============================================================

//assert(wall_thickness > 0);
//assert(closed_end_thickness > 0);
//assert(groove_depth > 0);
//assert(groove_depth > 0,
//    "pcb_width must be larger than the inner cavity width (box_width - 2*wall_thickness)");
//assert(groove_depth < wall_thickness,
//    "pcb_width is too large for the current wall_thickness/box_width - groove would cut through the wall");
//assert(groove_bottom >= wall_thickness);
//assert(groove_bottom + groove_height <= box_height - wall_thickness);
//assert(box_depth  > 2 * wall_thickness);
//assert(box_width  > 2 * wall_thickness);
//assert(box_height > 2 * wall_thickness);
//assert(screw_boss_corner_radius < screw_boss_margin,
//    "screw_boss_corner_radius must be smaller than screw_boss_margin");
//assert(screw_offset + screw_boss_margin < box_width  / 2);
//assert(screw_offset + screw_boss_margin < box_height / 2);

//assert(screw_boss_chamfer_depth >= 0 && screw_boss_chamfer_depth < screw_boss_margin,
//    "screw_boss_chamfer_depth must be between 0 and screw_boss_margin");
// ============================================================
// Lid base offset — single source of truth for where the lid's
// local origin sits in global space. Used by box_lid() and by
// place_on_lid_face(), so they can never drift out of sync.
// ============================================================

function lid_base_offset() =
    lid_on_side
        ? [0, box_width + lid_display_gap, 0]
        : [box_depth + lid_display_gap, 0, 0];



// ============================================================
// Screw center positions (Y-Z plane of the opening face)
// ============================================================

screw_centers_yz = [
    [screw_offset,                 screw_offset],
    [box_width  - screw_offset,    screw_offset],
    [box_width  - screw_offset,    box_height - screw_offset],
    [screw_offset,                 box_height - screw_offset]
];

// ============================================================
// Screw bosses, clipped to the box's outer surface so their
// outer corner follows the fillet instead of sticking past it
// ============================================================

module screw_bosses_final() {
    if (enable_box_fillet) {
        intersection() {
            screw_bosses();
            box_outer_solid();
        }
    } else {
        screw_bosses();
    }
}
// ============================================================
// Outer solid of the box (before the cavity is cut),
// used both for the shell and to clip the screw bosses
// so they never poke past a rounded exterior corner.
// ============================================================

module box_outer_solid() {
    if (enable_box_fillet) {
        rounded_box_outer(box_depth, box_width, box_height, fillet_radius);
    } else {
        cube([box_depth, box_width, box_height]);
    }
}

// ============================================================
// Rounded rectangular prism, extruded along X.
// Rounds only the 4 long edges parallel to X (the "horizontal"
// edges, since X is the insertion/opening axis). The flat end
// caps and the vertical corner edges stay sharp.
// ============================================================

module rounded_box_outer(length_x, width_y, height_z, r) {
    if (r <= 0) {
        cube([length_x, width_y, height_z]);
    } else {
        hull() {
            for (yy = [r, width_y - r]) {
                for (zz = [r, height_z - r]) {
                    translate([0, yy, zz])
                    rotate([0, 90, 0])
                    cylinder(h = length_x, r = r);
                }
            }
        }
    }
}

// ============================================================
// Basic shell
// ============================================================

module basic_shell() {
    difference() {
        box_outer_solid();

        translate([
            closed_end_thickness,
            wall_thickness,
            wall_thickness
        ])
        cube([
            box_depth - closed_end_thickness + epsilon,
            box_width  - 2 * wall_thickness,
            box_height - 2 * wall_thickness
        ]);
    }
}


// ============================================================
// PCB groove cutters (fixed: stops before the closed end wall)
// ============================================================

// ============================================================
// PCB groove cutters (side walls only, stops before the
// closed end wall)
// ============================================================

module pcb_groove_cutters() {

    groove_length = box_depth - closed_end_thickness + epsilon;

    translate([
        closed_end_thickness - epsilon,
        box_width - wall_thickness - epsilon,
        groove_bottom
    ])
    cube([groove_length, groove_depth + epsilon, groove_height]);

    translate([
        closed_end_thickness - epsilon,
        wall_thickness - groove_depth,
        groove_bottom
    ])
    cube([groove_length, groove_depth + epsilon, groove_height]);
}


// ============================================================
// Screw boss cross-section, extruded by `depth` along X,
// starting at local X = 0. Reused both for the straight part
// of the boss and for the chamfer transition.
// ============================================================

module screw_boss_prism(position, margin, depth) {
    corner_y = (position[0] < box_width  / 2) ? 0 : box_width;
    corner_z = (position[1] < box_height / 2) ? 0 : box_height;

    dir_y = (corner_y == 0) ? 1 : -1;
    dir_z = (corner_z == 0) ? 1 : -1;

    inner_y = position[0] + dir_y * margin;
    inner_z = position[1] + dir_z * margin;

    ymin = min(corner_y, inner_y);
    ymax = max(corner_y, inner_y);
    zmin = min(corner_z, inner_z);
    zmax = max(corner_z, inner_z);

    r = min(screw_boss_corner_radius, margin);

    zminA = (dir_z > 0) ? zmin : zmin + r;
    zmaxA = (dir_z > 0) ? zmax - r : zmax;

    yminB = (dir_y > 0) ? ymin : ymin + r;
    ymaxB = (dir_y > 0) ? ymax - r : ymax;

    cyl_y = inner_y - dir_y * r;
    cyl_z = inner_z - dir_z * r;

    hull() {
        translate([0, ymin, zminA])
            cube([depth, ymax - ymin, zmaxA - zminA]);

        translate([0, yminB, zmin])
            cube([depth, ymaxB - yminB, zmax - zmin]);

        translate([0, cyl_y, cyl_z])
        rotate([0, 90, 0])
        cylinder(h = depth, r = r);
    }
}


// ============================================================
// Screw boss: straight section flush with the opening face,
// plus an optional tapered chamfer at the inner (unsupported) end
// ============================================================

module screw_boss(position) {
    x_boss_start = box_depth - screw_boss_depth;

    // Straight part, full size, full depth
    translate([x_boss_start, 0, 0])
    screw_boss_prism(position, screw_boss_margin, screw_boss_depth);

    // 45-degree taper extending inward from the boss's inner end
    if (screw_boss_chamfer_depth > 0) {
        chamfer_margin = screw_boss_margin - screw_boss_chamfer_depth;

        hull() {
            translate([x_boss_start - screw_boss_chamfer_depth, 0, 0])
            screw_boss_prism(position, chamfer_margin, epsilon);

            translate([x_boss_start, 0, 0])
            screw_boss_prism(position, screw_boss_margin, epsilon);
        }
    }
}


module screw_bosses() {
    for (position = screw_centers_yz) {
        screw_boss(position);
    }
}


// // ============================================================
// Pilot holes in the box, spanning the full boss length
// (straight section plus chamfer)
// ============================================================

module base_screw_holes() {
    total_boss_depth = screw_boss_depth + screw_boss_chamfer_depth;

    for (position = screw_centers_yz) {
        translate([
            box_depth - total_boss_depth - epsilon,
            position[0],
            position[1]
        ])
        rotate([0, 90, 0])
        cylinder(
            h = total_boss_depth + 2 * epsilon,
            d = base_pilot_hole_diameter
        );
    }
}



// ============================================================
// Face enum — origin (u=0,v=0) is the bottom-left corner of
// the face as seen by someone standing outside, facing it,
// with "up" = +Z (or +X for faces 4/5, the horizontal ones).
//   0 = opening face   (x = box_depth)   u = Y            v = Z
//   1 = closed end     (x = 0)           u = box_width - Y v = Z
//   2 = left wall       (y = 0)           u = X            v = Z
//   3 = right wall      (y = box_width)   u = box_depth - X v = Z
//   4 = bottom          (z = 0)           u = X            v = box_width - Y
//   5 = top             (z = box_height)  u = X            v = Y
// ============================================================
module place_on_feature(face, u, v, rot = 0) {

    if (0 < face && face < 6) {
        // ---- box faces ----
        position =
            (face == 1) ? [0,         box_width - u,  v] :
            (face == 2) ? [u,         0,              v] :
            (face == 3) ? [box_depth - u, box_width,  v] :
            (face == 4) ? [u,         box_width - v,  0] :
            (face == 5) ? [u,         v,              box_height] :
            assert(false, "place_on_feature: invalid box face");

        face_rot =
            (face == 1) ? [-90,  -180, 90] :
            (face == 2) ? [90,   0, 0] :
            (face == 3) ? [90,  0, 180] :
            (face == 4) ? [180,  0, 0] :
            (face == 5) ? [0,    0, 0] :
            [0,0,0];

        translate(position)
        rotate(face_rot)
        rotate([0, 0, rot])
        children();

    } else {
        // ---- lid, single outward face ----
        translate(lid_base_offset() + [0, -lid_overhang, -lid_overhang])
        translate([lid_thickness, u, v])
        rotate([90, 0, 90])
        rotate([0, 0, rot])
        children();
    }
}



// ============================================================
// Complete box base
// ============================================================

module box_base() {
    difference() {
        union() {
            basic_shell();
            screw_bosses_final();
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
    translate(lid_base_offset() + [0, -lid_overhang, -lid_overhang])
    difference() {
        if (enable_lid_fillet) {
            rounded_box_outer(
                lid_thickness,
                box_width  + 2 * lid_overhang,
                box_height + 2 * lid_overhang,
                fillet_radius
            );
        } else {
            cube([
                lid_thickness,
                box_width  + 2 * lid_overhang,
                box_height + 2 * lid_overhang
            ]);
        }

        lid_screw_holes();
    }
}

// ============================================================
// Assembly
// ============================================================

// ============================================================
// Feature list — packs the 12 flat Customizer blocks into one
// array of records: [enabled, type, face, u, v, rot, a, b, c, d]
// ============================================================

features = [
    [feature1_enabled,  feature1_type,  feature1_face,  feature1_u,  feature1_v,  feature1_rot,  feature1_a,  feature1_b,  feature1_c,  feature1_d],
    [feature2_enabled,  feature2_type,  feature2_face,  feature2_u,  feature2_v,  feature2_rot,  feature2_a,  feature2_b,  feature2_c,  feature2_d],
    [feature3_enabled,  feature3_type,  feature3_face,  feature3_u,  feature3_v,  feature3_rot,  feature3_a,  feature3_b,  feature3_c,  feature3_d],
    [feature4_enabled,  feature4_type,  feature4_face,  feature4_u,  feature4_v,  feature4_rot,  feature4_a,  feature4_b,  feature4_c,  feature4_d],
    [feature5_enabled,  feature5_type,  feature5_face,  feature5_u,  feature5_v,  feature5_rot,  feature5_a,  feature5_b,  feature5_c,  feature5_d],
    [feature6_enabled,  feature6_type,  feature6_face,  feature6_u,  feature6_v,  feature6_rot,  feature6_a,  feature6_b,  feature6_c,  feature6_d],
    [feature7_enabled,  feature7_type,  feature7_face,  feature7_u,  feature7_v,  feature7_rot,  feature7_a,  feature7_b,  feature7_c,  feature7_d],
    [feature8_enabled,  feature8_type,  feature8_face,  feature8_u,  feature8_v,  feature8_rot,  feature8_a,  feature8_b,  feature8_c,  feature8_d],
    [feature9_enabled,  feature9_type,  feature9_face,  feature9_u,  feature9_v,  feature9_rot,  feature9_a,  feature9_b,  feature9_c,  feature9_d],
    [feature10_enabled, feature10_type, feature10_face, feature10_u, feature10_v, feature10_rot, feature10_a, feature10_b, feature10_c, feature10_d],
    [feature11_enabled, feature11_type, feature11_face, feature11_u, feature11_v, feature11_rot, feature11_a, feature11_b, feature11_c, feature11_d],
    [feature12_enabled, feature12_type, feature12_face, feature12_u, feature12_v, feature12_rot, feature12_a, feature12_b, feature12_c, feature12_d],
];

// record field indices, for readability at call sites
F_ENABLED = 0; F_TYPE = 1; F_FACE = 2; F_U = 3; F_V = 4;
F_ROT     = 5; F_A    = 6; F_B    = 7; F_C = 8; F_D = 9;


// ============================================================
// Cutter loops — split by target solid, since lid (face 0) and
// box (faces 1-5) are different objects in different places.
// ============================================================

module box_feature_cutters() {
    for (f = features) {
        if (f[F_ENABLED] && f[F_FACE] > 0) {
            place_on_feature(f[F_FACE], f[F_U], f[F_V], f[F_ROT])
            feature_cutter(f[F_TYPE], f[F_A], f[F_B], f[F_C], f[F_D]);
        }
    }
}

module lid_feature_cutters() {
    for (f = features) {
        if (f[F_ENABLED] && f[F_FACE] == 0) {
            place_on_feature(f[F_FACE], f[F_U], f[F_V], f[F_ROT])
            feature_cutter(f[F_TYPE], f[F_A], f[F_B], f[F_C], f[F_D]);
        }
    }
}


// ============================================================
// Assembly
// ============================================================

if (show_box) {
    difference() {
        box_base();
        box_feature_cutters();
    }
}
if (show_lid) {
    difference() {
        box_lid();
        lid_feature_cutters();
    }
}
