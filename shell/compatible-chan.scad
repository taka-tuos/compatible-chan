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
    difference() {
        outershell(54, 5, 1.8, 13);
        translate([0, 0, 11.5]) {
            difference() {
                outershell(54-1.4, 5-0.7, 1.8, 2.5);
                cube([54-20, 60, 12], true);
                cube([60, 54-15, 12], true);
            }
        }
        if(!m_led) {
            translate([-10, 0, 10]) {
                cube([60, 35, 25], true);
            }
        }
        translate([0, 0, 7.2+5]) {
            cube([60, 35, 10], true);
        }
    }
    
    translate([-(27-5.1),-(27-5.1), 1.5]) screwstand(2.1, 4.5, 9, 5, 0, 1, 1, 0); 
    translate([-(27-5.1), (27-5.1), 1.5]) screwstand(2.1, 4.5, 9, 5, 1, 0, 0, 1); 
    translate([ (27-5.1),-(27-5.1), 1.5]) screwstand(2.1, 4.5, 9, 5, 1, 0, 0, 1); 
    translate([ (27-5.1), (27-5.1), 1.5]) screwstand(2.1, 4.5, 9, 5, 0, 1, 1, 0); 
    
    translate([-13, -(27-4), 1.5]) screwstand(1.6, 3.5, 5.6, 5, 1, 0, 1, 0);
    translate([-13,  (27-4), 1.5]) screwstand(1.6, 3.5, 5.6, 5, 0, 1, 0, 1);
    
    translate([ 13, -(27-4), 1.5]) screwstand(1.6, 3.5, 5.6, 5, 1, 0, 1, 0);
    translate([ 13,  (27-4), 1.5]) screwstand(1.6, 3.5, 5.6, 5, 0, 1, 0, 1);
    
    if(!m_led) {
        translate([47.8 / 2 - 1.7 + 0.5, 0, 1.5 + 0.5]) cube([1, 36, 1], true);
    }
    
    if($preview) {
        /*translate([0, -2, 2.8]) {
            color("SteelBlue") {
                difference() {
                    translate([0, 0, 0.6]) cube([34, 47, 1.2], true);
                    translate([-(29/2), -(42/2), -2]) cylinder(4, 1.1, 1.1);
                    translate([ (29/2), -(42/2), -2]) cylinder(4, 1.1, 1.1);
                    translate([-(29/2),  (42/2), -2]) cylinder(4, 1.1, 1.1);
                    translate([ (29/2),  (42/2), -2]) cylinder(4, 1.1, 1.1);
                }
            }
            
            color("DarkGray") {
                translate([0, 2.819, -0.75]) cube([28.86, 28.86, 1.8], true);
            }
            
            color("DimGray") {
                translate([0, 0.5, -0.7]) cube([33.9, 37.3, 1.7], true);
            }
            
            color("DimGray") {
                translate([0, 22, 2.54]) cube([10.16, 2.54, 2.54], true);
            }
            
            color("Gold") {
                translate([-1.27     , 22, -1.8+6]) cube([0.6, 0.6, 1.8+1.2+2.54+6], true);
                translate([-1.27-2.54, 22, -1.8+6]) cube([0.6, 0.6, 1.8+1.2+2.54+6], true);
                translate([ 1.27     , 22, -1.8+6]) cube([0.6, 0.6, 1.8+1.2+2.54+6], true);
                translate([ 1.27+2.54, 22, -1.8+6]) cube([0.6, 0.6, 1.8+1.2+2.54+6], true);
            }
        }*/
        
        if(!m_led) {
            translate([-1.7, 0, 1.05 + 1.5]) {
                color("Silver") {
                    translate([0, 0, 0]) cube([47.8, 34.6, 2.05], true);
                }
                
                color("DimGray") {
                    translate([1.7, 0, -0.1]) cube([40.8, 30.6, 2.0], true);
                }
            }
        } else {
            //color("Green", 0.6) {
                translate([0, 0, 6.6 + 1.6]) {
                    rotate([0, 180, 0]) {
                        //import("compatible-chan-v0-led.stl", convexity = 2);
                        TXFM_1();
                    }
                }
            //}
        }
    }
    
    color("DimGray", 0.6) {
        difference() {
            translate([0, 0, 0.3]) linear_extrude(1.2, convexity = 2) roundsquare(54-0.9, 5-0.45);
            if(!m_led) {
                cube([40.8, 30.6, 4], true);
            } else {
                
            }
            
            //cube([27.972, 32.634, 4], true);
            //translate([0, 2.819-2, 0]) cube([28.86, 28.86, 4], true);
            //translate([0, 2, 0]) cylinder(4, 16, 16);
            //translate([0, 0, 1.5]) cube([42.04, 27.22, 1.0], true);
        }
    }
}