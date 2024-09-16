use <key.scad>

// 

test = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2 
  [ // R2
    [ 3,   ["Й",  "Q"]],
  ],
  [
    [ 4,   ["Ц",  "W"]],
  ],
  [ // thumbs
    [ 5,   ["W",  "N"]],
  ],
];

/*
 * Preset for keycaps without legends
 */

leftNoLegends = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2  Leg3  Leg4  Leg5
  [ // R2
    [ 0, false],
    [ 0, false],
    [ 0, false],
    [ 0, false],
    [ 3, false],
    [11, false], // inner thumbs
  ],
  [ // R3
    [ 1, false],
    [ 1, false],
    [ 1, false],
    [ 1, false],
    [ 4, false],
    [ 9, false], // home thumbs
  ],
  [ // R4
    [ 2, false],
    [ 2, false],
    [ 2, false],
    [ 2, false],
    [ 5, false],
    [10, false], // outer thumbs
  ],
];

rightNoLegends = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2 
  [ // R2
    [ 6, false],
    [ 0, false],
    [ 0, false],
    [ 0, false],
    [ 0, false],
    [12, false], // outer thumbs
  ],
  [ // R3
    [ 7, false],
    [ 1, false],
    [ 1, false],
    [ 1, false],
    [ 1, false], 
    [ 9, false], // home thumbs
  ],
  [ // R4
    [ 8, false],
    [ 2, false],
    [ 2, false],
    [ 2, false],
    [ 2, false],
    [13, false], // inner thumbs
  ],
];


/*
 * Preset for English Qwerty layout
 * - english symbols are in top left corners of keycaps
 */

leftQuerty = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2  Leg3  Leg4  Leg5
  [ // R2
    [ 0, ["Q"]],
    [ 0, ["W"]],
    [ 0, ["E"]],
    [ 0, ["R"]],
    [ 3, ["T"]],
    [11, [["space.svg", 5],  ["arrows.svg", 3.5]]], // inner thumbs
  ],
  [ // R3
    [ 1, ["A", "control.svg"]],
    [ 1, ["S", "option.svg"]],
    [ 1, ["D", "command.svg"]],
    [ 1, ["F", "shift.svg"]],
    [ 4, ["G"]],
    [ 9, [["tab.svg", 5],  "Fn"]], // home thumbs
  ],
  [ // R4
    [ 2, ["Z"]],
    [ 2, ["X",   "",   "",   "",  "1"]],
    [ 2, ["C",   "",   "",   "",  "2"]],
    [ 2, ["V",   "",   "",   "",  "3"]],
    [ 5, ["B"]],
    [10, [["ESC", 2.5],  ["media.svg", 3.5]]], // outer thumbs
  ],
];

rightQwerty = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2 
  [ // R2
    [ 6, ["Y"]],
    [ 0, ["U"]],
    [ 0, ["I"]],
    [ 0, ["O"]],
    [ 0, ["P"]],
    [12, [["return.svg", 5],  ["#", 3.5]]], // outer thumbs
  ],
  [ // R3
    [ 7, ["H"]],
    [ 1, ["J", "shift.svg"]],
    [ 1, ["K", "command.svg"]],
    [ 1, ["L", "option.svg"]],
    [ 1, [";", "control.svg"]], 
    [ 9, [["shift.svg", 5],  ""]], // home thumbs
  ],
  [ // R4
    [ 8, ["N"]],
    [ 2, ["M",   "",   "",   "",  "paste.svg"]],
    [ 2, [",",   "",   "",   "",  "copy.svg"]],
    [ 2, [".",   "",   "",   "",  "cut.svg"]],
    [ 2, ["/"]],
    [13, [["backspace.svg", 5],  "123"]], // inner thumbs
  ],
];

/*
 * Preset for Russian and English layouts
 * - russian symbols are in top left corners
 * - english symbols in bottom right corners (Qwerty layout)
 */

leftRussianEnglishQuerty = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2  Leg3  Leg4  Leg5
  [ // R2
    [ 0, ["Й",  "Q"]],
    [ 0, ["Ц",  "W"]],
    [ 0, ["У",  "E"]],
    [ 0, ["К",  "R"]],
    [ 3, ["Е",  "T"]],
    [11, [["space.svg", 5],  ["arrows.svg", 3.5]]], // inner thumbs
  ],
  [ // R3
    [ 1, ["Ф",  "A", "control.svg"]],
    [ 1, ["Ы",  "S", "option.svg"]],
    [ 1, ["В",  "D", "command.svg"]],
    [ 1, ["А",  "F", "shift.svg"]],
    [ 4, ["П",  "G"]],
    [ 9, [["tab.svg", 5],  "Fn"]], // home thumbs
  ],
  [ // R4
    [ 2, ["Я",  "Z"]],
    [ 2, ["Ч",  "X",   "",   "",  "1"]],
    [ 2, ["С",  "C",   "",   "",  "2"]],
    [ 2, ["М",  "V",   "",   "",  "3"]],
    [ 5, ["И",  "B"]],
    [10, [["ESC", 2.5],  ["media.svg", 3.5]]], // outer thumbs
  ],
];

rightRussianEnglishQuerty = [
  // keys by rows in left to right order
  // ID   Leg1  Leg2 
  [ // R2
    [ 6, ["Н",  "Y"]],
    [ 0, ["Г",  "U"]],
    [ 0, ["Ш",  "I"]],
    [ 0, ["Щ",  "O"]],
    [ 0, ["З",  "P"]],
    [12, [["return.svg", 5],  ["#", 3.5]]], // outer thumbs
  ],
  [ // R3
    [ 7, ["Р",  "H"]],
    [ 1, ["О",  "J", "shift.svg"]],
    [ 1, ["Л",  "K", "command.svg"]],
    [ 1, ["Д",  "L", "option.svg"]],
    [ 1, ["Ж",  ";", "control.svg"]], 
    [ 9, [["shift.svg", 5],  ""]], // home thumbs
  ],
  [ // R4
    [ 8, ["Т",  "N"]],
    [ 2, ["Ь",  "M", "", "", "paste.svg"]],
    [ 2, ["Б",  ",", "", "", "copy.svg"]],
    [ 2, ["Ю",  ".", "", "", "cut.svg"]],
    [ 2, [".",  "/"]],
    [13, [["backspace.svg", 5],  "123"]], // inner thumbs
  ],
];


horizontalPitch = 19; // distance between key centers

rows = [
// YOffset XRotate
  [     0,     -45],
  [    25,     -45],
  [    50,     -45],
];


// Generates keys for whole part
module generate_part(part) {
  for (row = [0:len(part)-1])
    for (key = [0:len(part[row])-1])
      translate([key * horizontalPitch, -rows[row][0], 0])
        rotate([rows[row][1], 0, 0])
  	      keycap(
            keyID  = part[row][key][0], 
            Legends = part[row][key][1],
            cutLen = 0, //Don't change. for chopped caps
            Stem   = true, //tusn on shell and stems
            Dish   = true, //turn on dish cut
            Stab   = 0, 
            visualizeDish = false, // turn on debug visual of Dish 
            crossSection  = false, // center cut to check internal
            homeDot = false, //turn on homedots
          );
}
