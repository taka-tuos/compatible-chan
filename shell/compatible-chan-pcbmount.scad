use <pcb.scad>

$fn = $preview ? 16 : 48;
m_led = true;

module roundsquare(s, r) {
    union() {
        square(s-r*2, true);
        translate([-(s/2-r),-(s/2-r), 0]) circle(r);
        translate([ (s/2-r),-(s/2-r), 0]) circle(r);
        translate([-(s/2-r), (s/2-r), 0]) circle(r);
        translate([ (s/2-r), (s/2-r), 0]) circle(r);
        translate([-(s/2-r), 0, 0]) square([r*2, s-r*2], true);
        translate([ (s/2-r), 0, 0]) square([r*2, s-r*2], true);
        translate([0,-(s/2-r), 0]) square([s-r*2, r*2], true);
        translate([0, (s/2-r), 0]) square([s-r*2, r*2], true);
    }
}

module outershell(s, r, t, h) {
    linear_extrude(h, convexity = 2) {
        difference() {
            roundsquare(s, r);
            roundsquare(s - t, r - t/2);
        }
    }
}

module screwstand(r1, r2, h, d, b1 = 0, b2 = 0, b3 = 0, b4 = 0) {
    union(){
        linear_extrude(h, convexity = 2) {
            difference() {
                circle(r2);
                circle(r1);
            }
        }
        cylinder(h - d, r2, r2);
        
        difference() {
            union() {
                if(b1 == 1) {
                    translate([-(r2/2), -(r2/2), h / 2]) cube([r2, r2, h], true);
                }
                
                if(b2 == 1) {
                    translate([-(r2/2),  (r2/2), h / 2]) cube([r2, r2, h], true);
                }
                
                if(b3 == 1) {
                    translate([ (r2/2), -(r2/2), h / 2]) cube([r2, r2, h], true);
                }
                
                if(b4 == 1) {
                    translate([ (r2/2),  (r2/2), h / 2]) cube([r2, r2, h], true);
                }
            }
            translate([0, 0, -1]) cylinder(h + 2, r2, r2);
        }
    }
}

union() {
    translate([-(27-5.1),-(27-5.1), 0]) screwstand(2.0, 4.6, 3, 5, 0, 1, 1, 0); 
    translate([-(27-5.1), (27-5.1), 0]) screwstand(2.0, 4.6, 3, 5, 1, 0, 0, 1); 
    translate([ (27-5.1),-(27-5.1), 0]) screwstand(2.0, 4.6, 3, 5, 1, 0, 0, 1); 
    translate([ (27-5.1), (27-5.1), 0]) screwstand(2.0, 4.6, 3, 5, 0, 1, 1, 0); 
    
    translate([-13, -(27-4), 0]) screwstand(1.75, 3.5, 6, 8, 1, 1, 0, 0);
    translate([-13,  (27-4), 0]) screwstand(1.75, 3.5, 6, 8, 1, 1, 0, 0);
    translate([ 13, -(27-4), 0]) screwstand(1.75, 3.5, 6, 8, 0, 0, 1, 1);
    translate([ 13,  (27-4), 0]) screwstand(1.75, 3.5, 6, 8, 0, 0, 1, 1);
    
    linear_extrude(3, convexity = 2) {
        translate([0, -(27-4)]) square([22, 3],true);
        translate([0,  (27-4)]) square([22, 3],true);
        
        translate([-(27-2), 0]) square([3, 35],true);
        translate([ (27-2), 0]) square([3, 35],true);
        
        translate([-(27-9), -(27-4)]) square([3, 7],true);
        translate([-(27-9),  (27-4)]) square([3, 7],true);
        translate([ (27-9), -(27-4)]) square([3, 7],true);
        translate([ (27-9),  (27-4)]) square([3, 7],true);
    }
}