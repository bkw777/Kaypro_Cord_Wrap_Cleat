// Cord-Wrap cleat on the back of Kaypro
// Brian K. White - b.kenyon.w@hgmail.com

major_corner_radius = 3.5;
minor_corner_radius = 1;

depth = 20.75;
width = 40;
height = 25;
hook_thickness = 4.75;
post_width = 22;
prong_cut_height = 12.3;
prong_cut_width = 18;
prongs_gap = 11.25;
gnd_cut_depth = 4.8;
gnd_cut_height = 15.7;
gnd_grip_bump = 0.3;
screw_hole_diameter = 3.8;
screw_head_diameter = 7.7;
screw_head_height = 12.4;
screw_x = 4.4;
registration_pin_diameter = 3.3;
registration_pin_height = 1.3;
registration_pin_x = 12.8;


/* [Hidden] */

e = 0.1; // epsilon

// arc smoothness
//$fn = 32;
$fa = 6;
$fs = 0.1;

cr = minor_corner_radius;
crh = major_corner_radius;

include <lib/handy.scad>

module cleat () {
  hh = hook_thickness * 2;
  ph = height-hook_thickness+e;

  difference () {
    group () {
      // hook
      translate([0,0,ph-e]) difference() {
        rounded_cube(w=width,d=depth,h=hh,rh=crh,rv=cr);
        translate([0,0,-hh/2]) cube([width+1,depth+1,hh],center=true);
      }
      // post
      translate([width/2-post_width/2,0,ph/2]) rounded_cube(w=post_width,d=depth,h=ph,rh=crh,rv=0);
    }

    translate([screw_x,0,0]) {
      // screw
      translate([0,0,-e]) cylinder(h=height, d=screw_hole_diameter);
      // screw head
      translate([0,0,screw_head_height]) cylinder(h=height, d=screw_head_diameter);
    }
    // gnd
    translate([width/2+screw_x,0,height/2+gnd_cut_height]) cube([width,gnd_cut_depth,height],center=true);
    // prongs
    mirror_copy([0,1,0]) translate([width-prong_cut_width,depth-prongs_gap/2,-height/2+prong_cut_height]) cube([width,depth,height],center=true);
  }

  // registration pin
  translate([screw_x+registration_pin_x,0,-registration_pin_height+e]) cylinder(h = registration_pin_height, d = registration_pin_diameter);
  
  // gnd grips
  gp = 4;
  gh = height - gnd_cut_height - cr;
  mirror_copy([0,1,0]) translate([width/2-gp/2,gnd_cut_depth/2+gp/2-gnd_grip_bump,gnd_cut_height-e]) for (i=[0:1:2]) {
    translate([-gp*i,0,0]) cylinder(h=gh,d=gp);
  }
}

cleat();