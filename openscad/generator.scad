use <./key.scad>



// Generate whole row
// Change row name here
generate_row(
  row = Thumb
);



// Numbers are key ids from key.scad
R2 = [0, 0, 0, 0, 3]; // "3" is tilted version. Replace with "0" if you want plain keycaps only.
R3 = [1, 1, 1, 1, 4]; // "4" is tilted version. Replace with "1" if you want plain keycaps only.
R4 = [2, 2, 2, 2, 5]; // "5" is tilted version. Replace with "2" if you want plain keycaps only.
Thumb = [8, 7, 6];

pitch = 19; // distance between key centers

/* Support generation */
generate_support = true;
support_radius = 0.75;
key_size = 17.16;



module generate_row(row) {
  generate_side(row);
  mirror([len(row) * 19, 0, 0]) generate_side(row);	
}

module mjf_support() {
  extra_side = 3.5;
  extra_height = 0.1;
  $fn = 16;

  color("red") {
    translate([0,0,support_radius]) {
      translate([support_radius, key_size/2 + support_radius - 0.45, -support_radius * 3])
	    rotate([180,90,0])
          cylinder(h=key_size + extra_side,r=support_radius);
      translate([0, key_size/2 + support_radius - 0.45, -support_radius + extra_height])
	    rotate([0,180,0])
	      cylinder(h=support_radius * 2 + extra_height,r=support_radius);
	  }
  }
  children();
}

module generate_side(row) {
  for ( i = [ 0 : 1 : len(row) - 1]) {
  	translate([pitch * (i + 0.5), 0]) {
      if (generate_support) {
	      mjf_support();
      }
      
	    keycap(
        keyID  = row[i], 
        cutLen = 0, //Don't change. for chopped caps
        Stem   = true, //tusn on shell and stems
        Dish   = true, //turn on dish cut
        Stab   = 0, 
        visualizeDish = false, // turn on debug visual of Dish 
        crossSection  = false, // center cut to check internal
        homeDot = false, //turn on homedots
        Legends = false
	    );
    }
  }
}
