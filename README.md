# DES keycaps for MX low profile switches

Based on honourable @pseudoku's [DES](https://github.com/pseudoku/PseudoMakeMeKeyCapProfiles)

Contains 3 rows (R2, R3, R4) and 3 keys for thumbs.
Row keys has tilted version for inner index.

Tested and fits:
- Gateron low profile (KS-27 and KS-33)
- Nuphy&Gateron low profile
- Keychron low profile optical
- Kailh Choc V2

## OpenSCAD sources

Source code is in `openscad` directory.

`key.scad` generates single keycap.

You can generate whole row with support for MJF print in `generator.scad`. 


### How to
* make sure OpenSCAD is up to date.
* copy `libraries` into your OpenSCAD libraries
* select keycap you want to render by changing KeyID value in `key.scad`
* or select row by changing row value in `generator.scad`
* press F5 to review
* press F6 to render
* press F7 to export as STL


## STLs

There are prerendered STLs for each keycap and each row in `stls` directory.
