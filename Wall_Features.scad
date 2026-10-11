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
// Feature: circular_hole
// param_a = diameter
// ------------------------------------------------------------
module feature_circular_hole(diameter) {
    cylinder(h = 2 * cut_depth, r = diameter / 2, center = true);
}


// ------------------------------------------------------------
// cut_depth: how far the cutter extends on each side of Z=0.
// Must safely exceed the thickest wall in the design.
// Defined here so every feature module can share one constant;
// override it in the main file if your wall ever gets thicker.
// ------------------------------------------------------------
cut_depth = 10;


// ------------------------------------------------------------
// Dispatch: single place to add a new `else if` per feature type
// a, b, c, d = generic parameter slots (meaning depends on type)
// ------------------------------------------------------------
module feature_cutter(type, a = 0, b = 0, c = 0, d = 0) {
    if (type == "circular_hole") {
        feature_circular_hole(a);
    } else {
        assert(false, str("feature_cutter: unknown type '", type, "'"));
    }
}