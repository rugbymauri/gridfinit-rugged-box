//*******************************************************************************************************
//
//    Universal parametic rugged Box
//
//  2023 by Rainer Backes
//
//   based on ideas of yanew and Whity
//
//*******************************************************************************************************


/* [View] */

xsize = 5;
ysize = 4;
zsize_bottom = 9;
zsize_lid = 2;
tolerance = 0.5;
// Select View
View="Complete Open";  // [Complete, Complete Open, Parts, Lid, Bottom, Latch, Seal ]
// Open Angle for complete Open
ViewAngle = 120; //[0:180]

/* [General] */
// Chamfer of inner Box (horizontal)
InnerChamferSize=1.5;

// Length of Screw
ScrewLength=30;
// Diameter of Screw
ScrewDiameter=3;
// Tolerance for Latch holes
ScrewTol = 0.4;

ScrewThreadDiameter=ScrewDiameter-0.15;
// Wall Thickness 
WallThickness=2.4;
// Number of Hinges(1-3)
NumHinge=2;
// Number of Latches (1-3)
NumLatch=2;
// Additional Height for TPU-Seal
TSealHeight = 0;
// Apply Interior to Lid
InteriorToLid=true;




/* [Hinges] */
// Offset of Hinge and Latchs to inner side corner
HingeLatchOffset = 30;

HingeWidthTolerance=0.25;

// With of Front and Back Ribs
HingeLatchRibWidth=3.2;

HingeOuterDiameter=6.8;
HingeOuterExtend=3;
HingeBottomLength=HingeLatchRibWidth+HingeOuterExtend;
HingeLidLength=ScrewLength-2*HingeBottomLength-HingeWidthTolerance;

/* [Side Ribs] */
// Number of Side rib Pairs
NumRibs=1;
// if more than 1 Side Rib Pair, distance of Ribs to the inner corner
RibOffset=18;
// Width of Ribs
RibWidth=5;
// Distance between Ribs
RibDist=20;


/* [Latches] */
// Distance of the screws making the Latch
LatchDistance=16;
// Latch Displacement downwards
LatchDisplacement = 2;

LatchWidthTolerance=0.4;
BoxLatchRibChamfer=17;
LidLatchRibChamfer=13;


// Latch: Radius of the rounding
LatchRoundRad= 15;
// Latch Wall thickness
LatchWall=3;
// Length of the Latch Handle
LatchHandleLen= 11;
// Ofset of Handle from vertical
LatchHandleOfs=4;


/* [Seal] */
// Height of Seal
SealHeight=1.4;
// Height of Lid protion, if TPUSeal > 0
TSealLid = 0.5;
// Tolerance for the TPU-Seal ( 1 layer )
TSealTol = 0.2;

SealWall=WallThickness/2;
// Additional wall tickness of box for seal
SealThick=1.9;
// Toleance
SealTol=0.2;
// Chanfer Angle for Seal-Support
SealCAng=70;
// Heigth of Seal support
SealBHeigh=8;


// Interior definition, everything here get masked an added to the interior of bottom and optional lid
module Interior (){
//    frame_plain(ysize, xsize);
}

// evertything here gets substracted (difference() ) from the lid
module liddiff () {

}

// evertything here gets added to the lid
module lidadd () {
     translate([0, 0, WallThickness]) frame_plain(ysize, xsize);
}

// evertything here gets substracted (difference() ) from the bottom
module bottomdiff () {
}

// evertything here gets added to the bottom

module bottomadd () {
   translate([0, 0, WallThickness]) frame_plain(ysize, xsize);
}

module frame_plain(num_x, num_y, extra_down=0, trim=0) {
  ht = extra_down > 0 ? 4.4 : 5;
  corner_radius = 3.75;
  corner_position = gridfinity_pitch/2-corner_radius-trim;
  xOffset = -num_x*gridfinity_pitch/2-gridfinity_pitch/2+gridfinity_pitch;
  yOffset = -num_y*gridfinity_pitch/2-gridfinity_pitch/2+gridfinity_pitch;
  difference() {
    hull() cornercopy(corner_position, num_x, num_y)
    translate([xOffset, yOffset, -extra_down]) cylinder(r=corner_radius, h=ht+extra_down, $fn=44);
    translate([xOffset, yOffset, trim ? 0 : -0.01])
    render() gridcopy(num_x, num_y) pad_oversize(margins=1);
  }
}


include <gridfinity_modules.scad>
include <rugbox.scad>
