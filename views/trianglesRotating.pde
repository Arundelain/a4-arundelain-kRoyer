/**
* Karen Royer - Rotated Triangles - 2018
* An exercise in changing parameters
**/


int rotAngle = 36;
int numSides = 10;
int xOrigin = 0;
int yOrigin = 0;

//counter has to get to at least the same number as the number of sides
//to be able to complete a shape. Further it must continue to be incremented
//to keep the pinwheel drawing the shape and rotation
int counter = 0;
int fRate = int(random(10, 100));

// All of the equations below are in terms of RsubNot.
// For any regular polygon, RsubNot points into the verts, aSubNot
// is the length of a side and rSubNot is the length of the
// radius from the center of the form to the middle of the side
float RsubNot = 50;
float aSubNot = 2*RsubNot*sin(PI/numSides);
float rSubNot = RsubNot*cos(PI/numSides);

float RsubOne = RsubNot + aSubNot;
float aSubOne = RsubNot;
float rSubOne = sqrt(sq(RsubOne)-sq(.5*aSubOne));
float c = sqrt(sq(aSubNot)-sq(.5*RsubNot));
float b = rSubOne - c;

float RsubTwo = RsubOne + aSubOne;
float aSubTwo = RsubOne;
float rSubTwo = sqrt(sq(RsubTwo)-sq(aSubOne));

float RsubThree = RsubTwo + aSubNot;
float aSubThree = 2*aSubNot;
float rSubThree = sqrt(sq(RsubThree)-sq(.5*aSubThree));

float RsubFour = RsubTwo + aSubOne;
float aSubFour = 2*RsubFour*sin(PI/numSides);
float rSubFour = sqrt(sq(RsubFour)-sq(.5*aSubFour));

float h =  random(255);
float j =  random(255);
float k =  random(255);

color from = color (h, j, k);
color to = color(random(255 - h), random(j, 255), 255-k/2, random(1));

//A xOrigin,yOrigin
//B aSubNot, RsubNot*cos(PI/numSides)
//C -1*aSubNot, RsubNot*cos(PI/numSides)
//D 0,b
//E RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides)
//F -1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides)
//G 0, (rSubOne + c)
//H RsubNot*sin(PI/numSides), (rSubTwo - c)
//I -1* RsubNot*sin(PI/numSides, (rSubTwo - c)
//J 1/2*aSubTwo, rSubTwo
//K (2*RsubOne*sin(PI/numSides) - (1/2*aSubTwo), rSubTwo
//L -2 * RsubOne*sin(PI/numSides) + (1/2*aSubTwo), rSubTwo
//M -1/2*aSubTwo, rSubTwo
//N aSubOne, rSubThree
//O xOrigin, rSubThree
//P -1*aSubOne, rSubThree
//Q 1/2*aSubFour, rsubFour
//R RsubOne*sin(PI/numSides), rSubFour
//S 1/2*(rSubOne - c), rSubFour
//T -1/2*(rSubOne - c), rSubFour
//U -1*RsubOne*sin(PI/numSides), rSubFour
//V -1/2*aSubFour, rSubFour

void setup()
{
  size(1000, 1000);
  background(255);
  smooth();
  noStroke();
  frameRate(fRate);
}

//triangle needs first two points are coordinates for first vert
//second two points are second vert and third points are third vert
void draw() {

  if (mouseX<50) {
    RsubNot = mouseX;
    xOrigin = mouseX;
    yOrigin = mouseY;
  }

// Set a gradient from the color declared above to
// the last color "to".
  color interA = lerpColor(from, to, .125);
  color interB = lerpColor(from, to, .25);
  color interC = lerpColor(from, to, .375);
  color interD = lerpColor(from, to, .5);
  color interE = lerpColor(from, to, .625);
  color interF = lerpColor(from, to, .75);
  color interG = lerpColor(from, to, .875);
  xOrigin = mouseX-500;
  yOrigin = mouseY-500;
  pushMatrix();
  // move the origin to the pivot point
  translate(mouseX, mouseY);
  rotate(radians(rotAngle*counter));
  fill(from);
  triangle(xOrigin, yOrigin, aSubNot, RsubNot*cos(PI/numSides), -1*aSubNot, RsubNot*cos(PI/numSides));
  fill(interA);
  triangle(aSubNot, RsubNot*cos(PI/numSides), -1*aSubNot, RsubNot*cos(PI/numSides), 0, b );
  fill(interB);
  triangle(aSubNot, RsubNot*cos(PI/numSides), 0, b, RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides));
  triangle(-1*aSubNot, RsubNot*cos(PI/numSides), 0, b, -1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides));
  fill(interC);
  triangle(0, b, RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), -1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides));
  triangle(-1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), 0, (rSubOne + c));
  triangle(RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), 0, (rSubOne + c), RsubNot*sin(PI/numSides), (rSubTwo - c));
  triangle(RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), RsubNot*sin(PI/numSides), (rSubTwo - c), (1/2*aSubTwo), rSubTwo);
  triangle(-1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), 0, (rSubOne + c), -1* RsubNot*sin(PI/numSides), (rSubTwo - c));
  triangle(-1 * RsubOne*sin(PI/numSides), RsubOne*cos(PI/numSides), -1* RsubNot*sin(PI/numSides), (rSubTwo - c), -1/2*aSubTwo, rSubTwo);
  fill(interD);
  triangle(RsubNot*sin(PI/numSides), rSubTwo - c, 2*RsubOne*sin(PI/numSides) - (1/2*aSubTwo), rSubTwo, 1/2*aSubTwo, rSubTwo);
  triangle(-1* RsubNot*sin(PI/numSides), (rSubTwo - c), (-2 * RsubOne*sin(PI/numSides) + (1/2*aSubTwo)), rSubTwo, -1/2*aSubTwo, rSubTwo);
  fill(interE);
  triangle(1/2*aSubTwo, rSubTwo, 2*RsubOne*sin(PI/numSides) - 1/2*aSubTwo, rSubTwo, xOrigin, rSubThree);
  triangle(2*RsubOne*sin(PI/numSides) - 1/2*aSubTwo, rSubTwo, -2 * RsubOne*sin(PI/numSides) + 1/2*aSubTwo, rSubTwo, xOrigin, rSubThree);
  triangle(-2 * RsubOne*sin(PI/numSides) + 1/2*aSubTwo, rSubTwo, xOrigin, rSubThree, -1/2*aSubTwo, rSubTwo);
  fill(interF);
  triangle(1/2*aSubTwo, rSubTwo, xOrigin, rSubThree, RsubOne*sin(PI/numSides), rSubFour);
  triangle(-1/2*aSubTwo, rSubTwo, xOrigin, rSubThree, -1*RsubOne*sin(PI/numSides), rSubFour);
  fill(interG);
  triangle((1/2*aSubTwo), rSubTwo, aSubOne, rSubThree, RsubOne*sin(PI/numSides), rSubFour);
  triangle(-1/2*aSubTwo, rSubTwo, -1*aSubOne, rSubThree, -1*RsubOne*sin(PI/numSides), rSubFour);
  fill(random(255));
  triangle(aSubOne, rSubThree, RsubOne*sin(PI/numSides), rSubFour, 1/2*aSubFour, rSubFour);
  triangle(-1*aSubOne, rSubThree, -1/2*aSubFour, rSubFour, -1*RsubOne*sin(PI/numSides), rSubFour);
  fill(random(255), random(255), random(255));
  triangle(RsubOne*sin(PI/numSides), rSubFour, 1/2*(rSubOne - c), rSubFour, xOrigin, rSubThree);
  triangle(-1/2*(rSubOne - c), rSubFour, -1*RsubOne*sin(PI/numSides), rSubFour, xOrigin, rSubThree);
  fill(to);
  triangle(1/2*(rSubOne - c), rSubFour, -1/2*(rSubOne - c), rSubFour, xOrigin, rSubThree);
  popMatrix();

  counter = counter +1;
if(mousePressed()){
fRate = 5;

}

}//end draw

void mouseClicked() {
  frameRate(0);
 // redraw();
}
