use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  
//use <z-butt.scad>

/*DES (Distorted Elliptical Saddle) Sculpted Profile for 6x3 and corne thumb 
Version 2: Eliptical Rectangle

*/
keycap(
  keyID  = 0, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  Dish   = true, //turn on dish cut
  Stab   = 0, 
  visualizeDish = false, // turn on debug visual of Dish 
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
);
 
//Parameters
wallthickness = 1.5; // 1.5 for norm, 1.25 for cast master
topthickness  = 2.9;   // 3 for norm, 2.5 for cast master
stepsize      = 40;  //resolution of Trajectory
step          = 6;   //resolution of ellipes 
fn            = 60;  //resolution of Rounded Rectangles: 60 for output, 16 for tests
layers        = 50;  //resolution of vertical Sweep: 50 for output, 40 for tests
dotRadius     = 0.55;   //home dot size
//---Stem param
Tol    =  0.0; // дополнительное расширение крестика в стэме
stemRot = 0;
stemWid = 7.55;
stemLen = 5.55 ;
stemCrossHeight = 4;
extra_vertical  = 0.6;
StemBrimDep     = -0.85; //торчание стема
stemLayers      = 50; //resolution of stem to cap top transition


//BotWid - ширина основания
//BotLen - длина основания
//TWDif - уменьшение ширины в верхней части кнопки 
//TLDif - уменьшение длины в верхней части кнопки 
//keyh - высота 
//WSft - смещение верхней части по Х 
//LSft - смещение верхней части по У
//XSkew - поворот верхнего диша вокруг оси Х (вперед-назад) 
//YSkew - поворот верхнего диша вокруг оси У (вправо-влево)
//ZSkew - поворот верхнего диша вокруг оси Z (по часовой-против часовой)
//WEx - расширитель по ширине. работает странно на 1 делает прямые боковины, 2 по умолчанию, на 3 и больше вытягивает их какбы вверх
//LEx - расширитель по длине
//CapR0i - закругление северной и южной нижних граней 
//CapR0f - закругление северной и южной верхних граней
//CapR1i - закругление восточной и западной нижних граней
//CapR1f - закругление восточной и западной верхних граней
//CapREx - радиус вытяжения боковых граней вверх. чем больше, тем грани больше стремятся вверх и меньше скругляются
//StemEx - не заметил изменений

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//Column high sculpt 3 row system 
    // matrix
    [17.16,  17.16,   6.5, 	 6.5, 5.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2 0
    [17.16,  17.16,   6.5, 	 6.5, 4.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 1
    [17.16,  17.16,   6.5, 	 6.5, 6.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 2
    
    // inner index column
    [17.16,  17.16,   6.5, 	 6.5, 7.75,    0,    0,   -16,    12,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2 3
    [17.16,  17.16,   6.5, 	 6.5, 6.75,    0,   .5,     4,    12,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 4
    [17.16,  17.16,   6.5, 	 6.5, 8.55,    0,    0,    18,    12,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 5

    // thumb
    [17.16,  17.16,     4, 	   6,   7,    0,    0,    -12,    10,    15,   2,   2,      1,      5,      1,      2,     2,       2], //outer  6  
    [17.16,  17.16,     4, 	   5,   6,    0,    0,    -12,     0,     0,   2,   2,      1,      5,      1,      3,     2,       2], //center 7
    [17.16,  17.16,     4, 	   5, 5.5,    0,    0,     -8,    -5,   -15,   2,   2,      1,   4.85,      1,      3,     2,       2], //inner  8
];

//FFwd1 - расстояние до переднего загиба вниз
//FFwd2 - радиус переднего загиба вниз
//FPit1 - угол переднего загиба вверх
//FPit2 - похоже на вытянутость диша вперед, я не понял это значение
//DshDep - глубина диша
//DshHDif - вдавливание диша вниз
//FArcIn - ширина начала передней арки
//FArcFn - ширина конца передней арки
//FArcEx - похоже на расстояние до расширения
//BFwd1 - расстояние до заднего загиба вниз
//BFwd2 - радиус заднего загиба вниз
//BPit1 - угол заднего загиба вверх
//BPit2 - похоже на вытянутость диша назад
//BArcIn - ширина начала передней арки
//BArcFn - ширина конца передней арки
//BArcEx - похоже на расстояние до расширения

dishParameters = //dishParameter[keyID][ParameteID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  // matrix
  [ 6.5,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [   6,    3,   10,  -55,      5,    1.8,   8.5,    15,     2,        6,  3.7,   10,  -55,    8.5,    15,     2], //R3
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,      5.5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  
  // inner index column
  [ 6.5,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [   6,    3,   10,  -55,      5,    1.8,   8.5,    15,     2,        6,  3.7,   10,  -55,    8.5,    15,     2], //R3
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,      5.8,  4.4,    5,  -55,    8.8,    15,     2], //R4
  
  // thumb
  [ 6.5,  4.8,    5,  -48,      4,    2.0,    11,    12,     2,        5,    4,    5,  -48,     11,    12,     2], //R5
  [   6,  4.8,    5,  -48,      5,    2.2,  10.5,    10,     2,        6,    4,    0,  -30,   10.5,    18,     2], //R5
  [ 6.5,  4.8,    5,  -48,      4,    2.0,   9.5,    10,     2,       10,    4,   13,  -30,    9.5,    20,     2], //R5

];
 
function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  // 
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepth(keyID)     = dishParameters[keyID][4];  //
function DishHeightDif(keyID) = dishParameters[keyID][5];  //
function FrontInitArc(keyID)  = dishParameters[keyID][6];
function FrontFinArc(keyID)   = dishParameters[keyID][7];
function FrontArcExpo(keyID)  = dishParameters[keyID][8];
function BackForward1(keyID)  = dishParameters[keyID][9];  //
function BackForward2(keyID)  = dishParameters[keyID][10];  // 
function BackPitch1(keyID)    = dishParameters[keyID][11];  //
function BackPitch2(keyID)    = dishParameters[keyID][12];  //
function BackInitArc(keyID)   = dishParameters[keyID][13];
function BackFinArc(keyID)    = dishParameters[keyID][14];
function BackArcExpo(keyID)   = dishParameters[keyID][15];

function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  // 
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4];  //
function TopWidShift(keyID)  = keyParameters[keyID][5];
function TopLenShift(keyID)  = keyParameters[keyID][6];
function XAngleSkew(keyID)   = keyParameters[keyID][7];
function YAngleSkew(keyID)   = keyParameters[keyID][8];
function ZAngleSkew(keyID)   = keyParameters[keyID][9];
function WidExponent(keyID)  = keyParameters[keyID][10];
function LenExponent(keyID)  = keyParameters[keyID][11];
function CapRound0i(keyID)   = keyParameters[keyID][12];
function CapRound0f(keyID)   = keyParameters[keyID][13];
function CapRound1i(keyID)   = keyParameters[keyID][14];
function CapRound1f(keyID)   = keyParameters[keyID][15];
function ChamExponent(keyID) = keyParameters[keyID][16];
function StemExponent(keyID) = keyParameters[keyID][17];

function FrontTrajectory(keyID) = 
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID)),
    trajectory(forward = BackForward2(keyID), pitch =  BackPitch2(keyID)),
  ];

//------- function defining Dish Shapes

function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (t = [rot1:step:rot2]) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b,c,d) = 
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0,rot1 = 90, rot2 = 270)
//   [[c+a,-b]]
  );

function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , // 
 b*sin(phi),
]; 
  
path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];


//--------------Function definng Cap 
function CapTranslation(t, keyID) = 
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

function InnerTranslation(t, keyID) =
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*(KeyHeight(keyID)-topthickness))    //Z shift
  ];

function CapRotation(t, keyID) =
  [
    ((1-t)/layers*XAngleSkew(keyID)),   //X shift
    ((1-t)/layers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/layers*ZAngleSkew(keyID))    //Z shift
  ];

function CapTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
function CapRoundness(t, keyID) = 
  [
    pow(t/layers, ChamExponent(keyID))*(CapRound0f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound0i(keyID),
    pow(t/layers, ChamExponent(keyID))*(CapRound1f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound1i(keyID)
  ];
  
function CapRadius(t, keyID) = pow(t/layers, ChamExponent(keyID))*ChamfFinRad(keyID) + (1-pow(t/layers, ChamExponent(keyID)))*ChamfInitRad(keyID);

function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  
function StemTranslation(t, keyID) =
  [
    ((1-t)/stemLayers*TopWidShift(keyID)),   //X shift
    ((1-t)/stemLayers*TopLenShift(keyID)),   //Y shift
    stemCrossHeight+.1+StemBrimDep + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1 -StemBrimDep))    //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((1-t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((1-t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent 


///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, crossSection = true,Legends = false, homeDot = false, Stab = 0) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), 1, d = 0)) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i), 1, d = 0)) ];
  
  //builds
  difference(){
    union(){
      difference(){
        skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        
        //Cut inner shell
        if(Stem == true){ 
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
        }
      }
      if(Stem == true){
         translate([0,0,StemBrimDep])rotate(stemRot)difference(){   
          cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
          skin(StemCurve);
          skin(StemCurve2);
        }
//        translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), rounded_rectangle_profile(StemTransform(i, keyID),fn=fn,r=StemRadius(i, keyID)))]); //Transition Support for taller profile
      }
    //cut for fonts and extra pattern for light?
    }
    
    //Cuts
    
    //Fonts
    if(Legends ==  true){
//          #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])
      translate([0,0,KeyHeight(keyID)-5])linear_extrude(height =5)text( text = "A", font = "Calibri:style=Bold", size = 4, valign = "center", halign = "center" );
      //  #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,-3.5,0])linear_extrude(height = 0.5)text( text = "Me", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
      translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } else {
      #translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)]) rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } 
   }
     if(crossSection == true) {
       translate([0,-15,-.1])cube([15,30,20]); 
//      translate([-15.1,-15,-.1])cube([15,30,20]); 
     }
    if(homeDot == true){
      // center dot
      #translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-0.1])sphere(r = dotRadius); // center dot
      // double bar dots
//      rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([.75,-4.5,KeyHeight(keyID)-DishHeightDif(keyID)+0.5])sphere(r = dotRadius); // center dot
//      rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-.75,-4.5,KeyHeight(keyID)-DishHeightDif(keyID)+0.5])sphere(r = dotRadius); // center dot
      //tri center dots
//     #rotate([0,YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-0.1]){
//        rotate([0,0,0])translate([0,.75,0])sphere(r = dotRadius); // center dot
//        rotate([0,0,120])translate([0,.75,0])sphere(r = dotRadius); // center dot
//        rotate([0,0,240])translate([0,.75,0])sphere(r = dotRadius); // center dot
//      }
    }
  }
  //Homing dot
  
}
//------------------stems 

MXWid = 4.03/2+Tol; //horizontal lenght
MXLen = 4.23/2+Tol; //vertical length

MXWidT = 1.15/2+Tol; //horizontal thickness
MXLenT = 1.25/2+Tol; //vertical thickness

function stem_internal(sc=1) = sc*[
[MXLenT, MXLen],[MXLenT, MXWidT],[MXWid, MXWidT],
[MXWid, -MXWidT],[MXLenT, -MXWidT],[MXLenT, -MXLen],
[-MXLenT, -MXLen],[-MXLenT, -MXWidT],[-MXWid, -MXWidT],
[-MXWid,MXWidT],[-MXLenT, MXWidT],[-MXLenT, MXLen]
];  //2D stem cross with tolance offset and additonal transformation via jog 
//trajectory();
function StemTrajectory() = 
  [ trajectory(forward = 5.25) ];
  
  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() = 
  [trajectory(forward = .5)];

StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
StemCurve2  = [for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]), stem_internal())]; 


module choc_stem() {
  
    translate([5.7/2,0,-3.4/2+2])difference(){
    cube([1.25,3, 3.4], center= true);
    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
  }
  translate([-5.7/2,0,-3.4/2+2])difference(){
    cube([1.25,3, 3.4], center= true);
    translate([3.9,0,0])cylinder(d=7,3.4,center = true);
    translate([-3.9,0,0])cylinder(d=7,3.4,center = true);
  }
  
}
/// ----- helper functions 
function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360) 
			r * [cos(a), sin(a)] 
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];

function elliptical_rectangle(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;

function sign_x(i,n) = 
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) = 
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;

//#square([18.16, 18.16], center = true);
//#square([41.3, 19.05], center = true);
//scale(1.03)difference(){// assume 1% from infill and 2% for easy removal
//translate([0,0,13/2+.1])cube([21,21,13], center = true);
//
// projection()
// translate([0,28,0])rotate([0,-90,0]){
//translate([0,0,0])mx_master_base(xu = 7, yu = 1 );  