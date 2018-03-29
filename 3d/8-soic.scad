
// the body of the IC
module body(label) {

translate([0,1,0]) { 
    difference() {
        color("SlateGrey")
 polyhedron(
    // clockwise looking down from z axis from origin
    points=[ 
    [0.1,0.1,0], [4.9,0.1,0], [4.9,3.9,0], [0.1,3.9,0], // the bottom rectangle
    [0,0,0.875], [5,0,0.875], [5,4,0.875], [0,4,0.875], // the middle horizontal
    [0.08,0.05,1.50], [4.90,0.05,1.50], // points on lower of angled edge
    [0.15,0.35,1.75], [4.85,0.35,1.75], [4.85,3.9,1.75], [0.15,3.85,1.75] // the top rectangle, less the angled face
    ],
    faces=[ [0,1,2,3], // bottom
    [0,4,5,1], [1,5,6,2], [2,6,7,3], [3,7,4,0], // lower vertical faces
    [4,8,9,5], [5,9,11,12,6],[6,12,13,7],[7,13,10,8,4], // upper vertical faces
    [8,10,11,9],// the angled face
    [10,13,12,11] // top
    ] 
    );
    
    translate([0.85, 1.05, 1.7]) cylinder(h=0.05, r=0.40, $fn=20); // the dot for pin 1
    translate([1.10 , 1.8, 1.7]) color("White") linear_extrude(height=0.05) { text(label, size=0.7);}     // the label
};
 
}
}

// offset to first leg = (5 - (1.27*3))/2=0.595
module leg(num) {
    translate([-0.175,0,0])
    color("Silver") 
    
    union() {
        polyhedron(
            points=[[0,0,0], [0.35,0,0], [0.35,0.4,0], [0,0.4,0],
                    [0,0,0.1],[0.35,0,0.1],[0.35,0.3,0.1],[0,0.3,0.1]],
            faces=[ [0,1,2,3],      // bottom
                    [0,4,5,1],      // end cap
                    [4,7,6,5],      // top
                    [1,5,6,2],      // side
                    [0,3,7,4],      // side
                    [2,6,7,3]       // end cap
                  ]
        );
        
        polyhedron(
            points=[[0,0.3,0.1],[0.35,0.3,0.1],[0.35,0.4,0], [0,0.4,0], , 
                    [0,0.5,0.85],[0.35,0.5,0.85],[0.35,0.6,0.75],[0,0.6,0.75],],
            faces=[ [0,1,2,3],      // bottom
                    [0,4,5,1],      // end cap
                    [4,7,6,5],      // top
                    [1,5,6,2],      // side
                    [0,3,7,4],      // side
                    [2,6,7,3]       // end cap
                  ]
        );
       
        polyhedron(
            points=[[0,0.6,0.75],[0.35,0.6,0.75],[0.35,1.0,0.75],[0,1.0,0.75],
                [0,0.5,0.85],[0.35,0.5,0.85],[0.35,1,0.85],[0,1,0.85] ],
            faces=[ 
                    [0,1,2,3],      // bottom
                    [0,4,5,1],      // end cap
                    [4,7,6,5],      // top
                    [1,5,6,2],      // side
                    [0,3,7,4],      // side
                    [2,6,7,3]       // end cap
                  ]
        );
    }
    
}

module ic(label) {
    union() {
        body(label);
        
        translate([0.595+0*1.27,0,0]) leg();
        translate([0.595+1.27,0,0]) leg();
        translate([0.595+2*1.27,0,0]) leg();
        translate([0.595+3*1.27,0,0]) leg();

        translate([0.595+0*1.27,6,0]) rotate([0,0,180])leg();
        translate([0.595+1*1.27,6,0]) rotate([0,0,180])leg();
        translate([0.595+2*1.27,6,0]) rotate([0,0,180])leg();
        translate([0.595+3*1.27,6,0]) rotate([0,0,180])leg();
    }
}

ic("SOIC-8");

