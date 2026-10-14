// ============================================================
// Wall_Features.scad
//
// Feature cutter library for the parametric electronics box.
// Each feature module draws its cutter shape:
//   - centered at the origin
//   - lying in the local X-Y plane
//   - extruded symmetrically along Z (both +Z and -Z)
// so it always overshoots whatever wall thickness it's placed
// against, regardless of direction, with no z-fighting.
//
// This file is `include`d (not `use`d) from the main file, so it
// can see global parameters (e.g. epsilon) if a feature ever needs
// them. It must come after globals are defined in the main file.
// ============================================================


// ------------------------------------------------------------
// cut_depth: how far the cutter extends on each side of Z=0.
// Must safely exceed the thickest wall in the design.
// Defined here so every feature module can share one constant;
// override it in the main file (after the include) if your wall
// ever gets thicker.
// ------------------------------------------------------------
cut_depth = 10;


// ------------------------------------------------------------
// Feature: circular_hole
// param_a = diameter
// param_b, c, d = unused
// ------------------------------------------------------------
module feature_circular_hole(diameter) {
    cylinder(h = 2 * cut_depth, r = diameter / 2, center = true);
}


// ------------------------------------------------------------
// Feature: rectangular_hole
// param_a = width
// param_b = height
// param_c = corner fillet radius (0 = sharp corners)
// param_d = unused
// ------------------------------------------------------------
module feature_rectangular_hole(width, height, corner_r) {
    linear_extrude(height = 2 * cut_depth, center = true)
    offset(r = corner_r)
    square([width - 2 * corner_r, height - 2 * corner_r], center = true);
}


// ------------------------------------------------------------
// Feature: ventilation_hole
// param_a = style   (0 = square matrix, 1 = oblong row,
//                     2 = staggered oblong grid / brick pattern)
// param_b = quantity 1 (columns, or hole count for style 1)
// param_c = quantity 2 (rows; unused for style 1)
// param_d = hole dimension (diameter for style 0,
//                            width for styles 1/2)
// ------------------------------------------------------------

module feature_ventilation_hole(style, qty1, qty2, dimension) {
    if (style == 0) {
        vent_square_matrix(qty1, qty2, dimension);
    } else if (style == 1) {
        vent_oblong_row(qty1, dimension);
    } else if (style == 2) {
        vent_oblong_staggered(qty1, qty2, dimension);
    } else {
        assert(false, str("feature_ventilation_hole: unknown style '", style, "'"));
    }
}


// ---- style 0: square matrix of round holes, b x c ----------
// ---- spacing = 1.5 * diameter (no-overlap rule) -------------
module vent_square_matrix(cols, rows, diameter) {
    spacing = 1.5 * diameter;

    total_u = (cols - 1) * spacing;
    total_v = (rows - 1) * spacing;

    for (i = [0 : cols - 1]) {
        for (j = [0 : rows - 1]) {
            translate([
                i * spacing - total_u / 2,
                j * spacing - total_v / 2,
                0
            ])
            feature_circular_hole(diameter);
        }
    }
}


// ---- shared oblong primitive: width = d, length = 5*d, -----
// ---- long axis along local U (horizontal) -------------------
module vent_oblong(width) {
    length = 5 * width;
    hull() {
        translate([ (length - width) / 2, 0, 0])
        cylinder(h = 2 * cut_depth, r = width / 2, center = true);

        translate([-(length - width) / 2, 0, 0])
        cylinder(h = 2 * cut_depth, r = width / 2, center = true);
    }
}


// ---- style 1: single row of b oblong holes, side by side ---
// ---- along U, spacing = 1.5 * length (long-axis packing) ----
module vent_oblong_row(qty, width) {
    length = 5 * width;
    spacing = 1.5 * length;
    total_u = (qty - 1) * spacing;

    for (i = [0 : qty - 1]) {
        translate([i * spacing - total_u / 2, 0, 0])
        vent_oblong(width);
    }
}


// ---- style 2: b columns x c rows of oblong holes, with -----
// ---- alternating rows offset horizontally by half spacing ---
// ---- (classic brick / running-bond pattern) ------------------
module vent_oblong_staggered(cols, rows, width) {
    length    = 5 * width;
    spacing_u = 1.5 * length;   // horizontal spacing between holes in a row
    spacing_v = 1.5 * width;    // vertical spacing between rows

    total_u = (cols - 1) * spacing_u + spacing_u / 2; // extra half-column for stagger
    total_v = (rows - 1) * spacing_v;

    for (j = [0 : rows - 1]) {
        stagger_offset = (j % 2 == 1) ? spacing_u / 2 : 0;
        for (i = [0 : cols - 1]) {
            translate([
                i * spacing_u - total_u / 2 + stagger_offset,
                j * spacing_v - total_v / 2,
                0
            ])
            vent_oblong(width);
        }
    }
}


// ------------------------------------------------------------
// Dispatch: single place to add a new `else if` per feature type
// a, b, c, d = generic parameter slots (meaning depends on type)
// ------------------------------------------------------------
module feature_cutter(type, a = 0, b = 0, c = 0, d = 0) {
    if (type == "circular_hole") {
        feature_circular_hole(a);
    } else if (type == "rectangular_hole") {
        feature_rectangular_hole(a, b, c);
    } else if (type == "ventilation_hole") {
        feature_ventilation_hole(a, b, c, d);
    } else {
        assert(false, str("feature_cutter: unknown type '", type, "'"));
    }
}