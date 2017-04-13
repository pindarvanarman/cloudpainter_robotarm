float xWidth = 150;
float yHeight = 100;

float minRobotX = -100.0;
float maxRobotX = 100.0;
float minRobotY = 160.0;
float maxRobotY = 260.0;
float minRobotZ = 100.0;
float maxRobotZ = 280.0;

PVector threeBrushVec56 = new PVector(0, 0.15, -1);//  (0, 0.15, -1) Working 45 degrees On


float elasticMinX = -60;
float elasticMaxX = 60;
//90 to 50 ratio on rise over run
float elasticMinY = 160.0;//125
float elasticMaxY = 300.0;//225.0;
float elasticMinZ = 70.0;//90.0;
float elasticMaxZ = 200.0;//225.0;



void scaleRobotXCanvas(float scale) {
   float adjustedRobotWidth = xWidth*scale;
   minRobotX = -(adjustedRobotWidth/2);
   maxRobotX = (adjustedRobotWidth/2);
}

void scaleRobotYCanvas(float scale) {
   float adjustedRobotHeight = yHeight*scale;
   minRobotX = ((minRobotY+maxRobotY)/2)-(adjustedRobotHeight/2);
   maxRobotX = ((minRobotY+maxRobotY)/2)+(adjustedRobotHeight/2);
}

void setMinX(float minX) {
  minRobotX = minX;
}
void setMaxX(float maxX) {
  maxRobotX = maxX;
}
void setMinY(float minY) {
  minRobotY = minY;
}
void setMaxY(float maxY) {
  maxRobotY = maxY;
}

float getRobotWidth() {
  return (Math.abs(minRobotX)+Math.abs(maxRobotX));
}

float getRobotHeight() {
  return (Math.abs(minRobotY)+Math.abs(maxRobotY));
}

float convertCmToMm(float cm) {
  float mm = cm*10;
  return mm;
}

//input is number between 0 and 1
float getRobotX(float xPercentage) {
  float xRange = maxRobotX-minRobotX;
  return maxRobotX-(xRange*xPercentage);
}

//input is number between 0 and 1
float getRobotY(float yPercentage) {
  float yRange = maxRobotY-minRobotY;
  return minRobotY+(yRange*yPercentage);
}

//input is y - returns z needed for that y to touch canvas
float getRobotZforRobotY(float yPercentage) {
  float zRange = maxRobotZ-minRobotZ;
  return minRobotZ+(zRange*yPercentage);
}




//input is number between 0 and 1
float getElasticRobotX(float xPercentage, float yPercentage) {
  float xElasticRange = elasticMaxX-elasticMinX;
  float distFromCenter = Math.abs((0.5-xPercentage));
  float adjustment = yPercentage*30*distFromCenter;
  if(xPercentage>=0.5) {
    adjustment = -adjustment;
  }
  
  return elasticMaxX-(xElasticRange*xPercentage)+adjustment;
}

//input is number between 0 and 1
float getElasticRobotY(float yPercentage) {
  float yElasticRange = elasticMaxY-elasticMinY;
  return elasticMinY+(yElasticRange*yPercentage);
}

//input is y - returns z needed for that y to touch canvas
float getElasticRobotZforRobotY(float yPercentage) {
  float zElasticRange = elasticMaxZ-elasticMinZ;
  return elasticMinZ+(zElasticRange*yPercentage);
}


//Higher Y IS FROM Bottom / MORE X NEEDs TO BOW OUTWARDS
float getElasticArcXAdjustment(float xAdjustment, float x, float y) {
  //-100   100
  float sign = 1;
  if (x<0) {
    sign = -1;
  }
  
  float maxY = elasticMaxY-elasticMinY;
  float normalizedY = y-elasticMinY;
  float distFromBottomYPercentage = normalizedY/maxY;
  //you want z a little lower
  return sign*(xAdjustment*distFromBottomYPercentage); //18 for z and 10 for y
}
 //<>// //<>//
//FURTHER OUT X IS FROM CENTER / MORE Y AND Z NEED TO BE CLOSER TO CANVAS
float getElasticArcYZAdjustment(float yAdjustment, float x, float adjustment) {
  //-100   100
  float range = abs(elasticMinX)+abs(elasticMaxX);
  float midPoint = range/2; //100
  float distFromCenterXPercentage = abs(x/midPoint);
  //you want z a little lower
  return ((0*yAdjustment)*distFromCenterXPercentage)+(distFromCenterXPercentage*(0*adjustment)); //18 for z and 10 for y
}