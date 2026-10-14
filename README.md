# Parametric Electronic Project Box (OpenSCAD)

A fully parametric, side-opening enclosure for electronic projects, built in
OpenSCAD. The box, lid, PCB groove, and screw bosses are generated from a
small set of dimensions, and an extensible **feature system** lets you cut
arbitrary holes/cutouts (USB-C, round holes, rectangular holes, etc.) into
any wall or the lid — purely by filling in Customizer fields, no code
editing required for day-to-day use.

Two files:
- **Main `.scad` file** — box/lid geometry, screw bosses, PCB groove,
  Customizer parameters, feature placement, and final assembly.
- **`Wall_Features.scad`** — the feature cutter library (one module per
  cutout shape + a dispatch function). `include`d from the main file.

---

## 1. How the box is built

- The box is a rectangular shell (`box_depth` x `box_width` x `box_height`)
  with one open end (the "opening face", where the lid slides on) and
  rounded long edges (fillets) on request.
- A **lid** closes the opening. It is modeled as a separate flat panel,
  rendered off to the side (or past the end) of the box for visualization,
  offset by `lid_display_gap`. `lid_on_side` chooses whether it's drawn
  beside the box or past its open end — this is purely a *display* offset
  and does not affect how the lid would actually mate with the box.
- A **PCB groove** is cut into the two side walls to slide a PCB in from
  the open end, stopping before the closed end wall.
- **Screw bosses** are molded into the 4 inner corners near the opening
  face, with a pilot hole in the box and a clearance hole through the lid,
  plus an optional chamfer so the boss prints without needing support
  material.
- An optional **feature system** (see §3) cuts arbitrary holes into any of
  the 5 box walls or the lid face.

---

## 2. Parameters

### Main enclosure
| Parameter | Meaning |
|---|---|
| `box_depth` | Length of the box along the insertion/opening axis (X). |
| `box_width` | Width of the box (Y). Should be PCB width + wall clearance. |
| `box_height` | Height of the box (Z). |
| `wall_thickness` | Thickness of the 4 walls perpendicular to the lid (top, bottom, left, right). |
| `closed_end_thickness` | Thickness of the closed end wall (parallel to the lid, opposite the opening). |

### Fillets
| Parameter | Meaning |
|---|---|
| `enable_box_fillet` | Round the 4 long edges of the box shell. |
| `enable_lid_fillet` | Round the 4 long edges of the lid panel. |
| `fillet_radius` | Shared radius for both, in mm. |

### PCB groove
| Parameter | Meaning |
|---|---|
| `pcb_width` | PCB width including clearance. Must be slightly larger than the inner cavity width so the groove has material to bite into, and smaller than `box_width` by less than `2 * wall_thickness`. |
| `groove_height` | Height (Z extent) of the groove slot. |
| `groove_bottom` | Distance from the box floor to the bottom of the groove. |
| `inner_cavity_width` *(computed)* | `box_width - 2*wall_thickness`. |
| `groove_depth` *(computed)* | How far the groove cuts into each side wall; must stay less than `wall_thickness` or it will cut through. |

### Lid
| Parameter | Meaning |
|---|---|
| `lid_thickness` | Thickness of the lid panel. |
| `lid_overhang` | Optional lid oversize relative to the box opening (0 = flush). |
| `lid_display_gap` | Visual gap between box and lid when both are rendered (does not affect fit). |
| `lid_on_side` | `true` = lid drawn beside the box; `false` = lid drawn past the open end. |

### Screws / bosses
| Parameter | Meaning |
|---|---|
| `screw_offset` | Distance of each screw center from the two nearest edges of the opening face, in the box's local Y-Z plane. |
| `screw_boss_margin` | How far each boss extends from the screw center into the box. |
| `screw_boss_corner_radius` | Fillet on the boss's inner corner (facing the cavity). |
| `screw_boss_depth` | How far the boss protrudes inward from the opening face. |
| `screw_boss_chamfer_depth` | Length of the 45° taper at the boss's inner (unsupported) end, for printability. |
| `base_pilot_hole_diameter` | Pilot hole diameter in the box-side boss (for a self-tapping screw). |
| `lid_clearance_hole_diameter` | Clearance hole diameter through the lid. |

### Misc
| Parameter | Meaning |
|---|---|
| `epsilon` | Small overlap value used to avoid coincident-face rendering artifacts in boolean operations. |
| `show_box` / `show_lid` | Top-level toggles for rendering the box and/or lid. |

---

## 3. Feature system

The feature system lets you cut up to **12 independent cutouts** into the
box walls or the lid, each individually enabled, typed, positioned, and
sized — entirely through Customizer fields, no code changes needed to use
an existing feature type.

### 3.1 Concepts

- **Face** — which surface the feature is cut into:
  - `0` = Lid
  - `1` = Closed end wall
  - `2` = Left wall
  - `3` = Right wall
  - `4` = Bottom
  - `5` = Top
  (There is no opening-face option — that's where the lid mates, so there's
  nothing to cut a hole into there.)
- **u, v** — the feature's position within that face's own local 2D frame.
  The origin (`u=0, v=0`) is the face's bottom-left corner, as seen by
  someone standing outside the box looking directly at that face. `u`
  increases to the right, `v` increases upward.
- **rot** — in-plane rotation of the feature's cutout shape, in degrees,
  about its own center.
- **a, b, c, d** — four generic numeric parameter slots. Their meaning
  depends on the feature `type` (e.g. for `circular_hole`, `a` = diameter;
  `b`, `c`, `d` are unused). See §3.3 for the current list.

Each of the 12 Customizer blocks (`feature1_*` ... `feature12_*`) exposes
exactly these fields: `enabled`, `type`, `face`, `u`, `v`, `rot`, `a`, `b`,
`c`, `d`.

### 3.2 How it's wired together

1. `place_on_feature(face, u, v, rot) { children(); }` (main file) —
   translates/rotates its children from the shared local convention (see
   §4) onto the chosen face, at the chosen position and orientation.
2. `feature_cutter(type, a, b, c, d)` (`Wall_Features.scad`) — dispatches
   to the correct cutter module based on `type`.
3. The 12 flat Customizer blocks are packed into one `features` array of
   records, then two loops (`box_feature_cutters()`, `lid_feature_cutters()`)
   iterate over it, each only processing the features whose `face` belongs
   to that solid, and subtract the cutters from `box_base()` / `box_lid()`
   respectively in the final assembly.

### 3.3 Included feature types

<!-- Add one entry per feature type as it's implemented in
     Wall_Features.scad. Keep this in sync with the `type` dropdown
     comment on the 12 Customizer blocks in the main file. -->

| Type string | Parameters (a, b, c, d) | Description |
|---|---|---|
| `circular_hole` | `a` = diameter | A simple round hole, e.g. for cables, LEDs, buttons. |
| `rectangular_hole` | `a` = width, `b` = height, `c` = corner fillet radius | A rectangular cutout with optional rounded corners. Set `c = 0` for sharp corners. `c` must stay smaller than half of `a` and half of `b`, or the shape becomes invalid. |
| `ventilation_hole` | `a` = style (`0`/`1`/`2`), `b` = quantity 1, `c` = quantity 2, `d` = hole dimension | A grid or row of ventilation holes. See breakdown below — the meaning of `b`, `c`, and `d` depends on the chosen style. |
| _(more to come — usb_c, etc.)_ | | |

#### `ventilation_hole` styles

- **Style `0` — square matrix**: a `b` x `c` grid of round holes, each with
  diameter `d`. Center-to-center spacing is `1.5 * d` in both directions,
  so holes never overlap. `c` is unused by styles `1`.
- **Style `1` — oblong row**: a single row of `b` oblong (pill-shaped)
  holes, each `d` wide and `5 * d` long (fixed 5:1 aspect ratio), long axis
  horizontal, packed side by side with `1.5 * (5*d)` center spacing.
  `c` is ignored for this style.
- **Style `2` — staggered oblong grid**: a `b` x `c` grid of the same
  oblong shape as style `1`, arranged in a brick/running-bond pattern —
  alternating rows are offset horizontally by half the row spacing, matching
  the look of a standard perforated-metal ventilation panel.

In all three styles, the hole pattern is centered on the feature's `(u, v)`
placement point, and `rot` rotates the entire pattern in-plane.

---

## 4. Adding your own cutout type

This section is written to be used as context for an LLM (or a human)
implementing a new feature type. Follow this convention exactly — the
whole system depends on every cutter module obeying the same contract.

### Contract for a cutter module

- Lives in `Wall_Features.scad`.
- Named `feature_<type_name>(...)`, with up to 4 numeric parameters,
  named for clarity inside the module (the generic `a,b,c,d` naming only
  happens at the `feature_cutter()` dispatch boundary).
- Must draw its cutter shape:
  - **centered at the origin** (not offset),
  - **lying in the local X-Y plane** (its 2D outline is in X/Y),
  - **extruded symmetrically along Z**, using `center = true` (or
    equivalent), extending far enough past `cut_depth` on both +Z and -Z
    to safely overshoot any wall thickness in the design, regardless of
    which direction it ends up facing once placed.
- Must NOT call `translate()`, `rotate()`, or reference any box/lid
  dimension, screw/boss parameter, or face — placement is handled entirely
  by `place_on_feature()`, which the module has no awareness of. This
  separation is what lets one cutter module work identically on any face.

### Steps to add a new type (e.g. `rect_hole`)

1. **Write the module** in `Wall_Features.scad`:
   ```openscad
   // rect_hole: a = width, b = height, c = corner radius, d = unused
   module feature_rect_hole(width, height, corner_r) {
       linear_extrude(height = 2 * cut_depth, center = true)
       offset(r = corner_r)
       square([width - 2*corner_r, height - 2*corner_r], center = true);
   }
   ```
2. **Register it in the dispatch function**, same file:
   ```openscad
   module feature_cutter(type, a = 0, b = 0, c = 0, d = 0) {
       if (type == "circular_hole") {
           feature_circular_hole(a);
       } else if (type == "rect_hole") {
           feature_rect_hole(a, b, c);
       } else {
           assert(false, str("feature_cutter: unknown type '", type, "'"));
       }
   }
   ```
3. **Extend the `type` dropdown** on all 12 Customizer blocks in the main
   file (currently `// [circular_hole]`) to also list the new type, e.g.
   `// [circular_hole, rect_hole]`. This is a mechanical find-and-replace
   across all 12 lines — Customizer requires the option list as a literal
   comment on each line, so it cannot be generated or shared from one
   place.
4. **Document the type** in the table in §3.3 above (type string,
   meaning of `a/b/c/d`, one-line description).
5. **Validate it in isolation** before trusting it across all 12 slots —
   e.g. temporarily set `feature1_type` to the new type with reasonable
   test values, render, and confirm:
   - the cutout appears centered correctly on the chosen face at `(u, v)`,
   - it cuts fully through the wall with no residual membrane,
   - `rot` rotates it in the expected direction,
   - it does not collide with a screw boss, groove, or the box edge for
     the test position used (bounds-checking across arbitrary positions
     is the user's responsibility — there is no automatic collision
     guard).

### Things to avoid

- Don't give a cutter module fewer or more than the 4 generic parameter
  slots at the dispatch boundary — if a shape needs more inputs, repurpose
  unused slots (`b/c/d`) rather than changing `feature_cutter()`'s
  signature, since that signature is called generically from the main
  file's loop.
- Don't hardcode a face, offset, or rotation inside a cutter module —
  that logic belongs exclusively to `place_on_feature()`.
- Don't change the record layout (`[enabled, type, face, u, v, rot, a, b,
  c, d]`) packed in the main file's `features` array when adding a type —
  it's intentionally generic and already supports any shape describable
  with up to 4 numeric parameters.
