import processing.serial.*; //<>// //<>// //<>//

Serial myPort;  

int BAUD_RATE = 115200;
int SERVO_NUM = 7;
double[] posD = new double[SERVO_NUM];
int[] force = new int[SERVO_NUM];
boolean isAllConverge = true;

int dotsPainted = 0;

int startOnStrokeNumber = 0;
String index = "strokes_000000578_colortest_005";

boolean testIndex = false;

boolean wakeRobot = true;
boolean testRobot = true;
boolean moveRobot = false;
boolean recordMeasurements = false;
boolean playMeasurements = false;

//boolean elasticonTest = true;


void setup() 
{

  if (testIndex) {
    testIndex();
  }

  //initializeAccessPoints();

  //JSONObject brushstroke = getNextBrushstroke(index, startOnStrokeNumber);
  if (wakeRobot) {
    // Open Serial Port: Your should change PORT_ID accoading to
    // your own situation. 
    // Please refer to: https://www.processing.org/reference/libraries/serial/Serial.html
    int PORT_ID =  0;
    myPort = new Serial(this, Serial.list()[PORT_ID], BAUD_RATE); 
    System.out.println("wakingup");
    // Delay 2 seconds to wait 7Bot waking up
    ////////////////////////////////////////////////////////////////////////
    // 1- change for`````````````````ce status
    //System.out.println("forcestatus:2");
    //setForceStatus(2);  // change forece status to forceless 
    //delay(2000);
    ////////////////////////////////////////////////////////////////////////
    // 2- speed & pose setting 
    System.out.println("forcestatus:1");
    setForceStatus(1);
    delay(1000);   // reboot 7Bot if previous status is not normal servo
    // To make motion much more stable, highly recommend you use fluency all the time.
    boolean[] fluentEnables = {true, true, true, true, true, true, true};
    int[] speeds_1 = {50, 50, 50, 200, 200, 200, 200};  
    setSpeed(fluentEnables, speeds_1); // set speed
    ////////////////////////////////////////////////////////////////////////delay(1000);
    System.out.println("awake");
  }

  if (testRobot) {
    System.out.println("go to start pose");
    goToStartPose();   

    //mixSingleWell();

    //paintPercentageImitator("hunter_0601_lightcolors",10,10);
    //paintPercentageImitator("corinne_0800_background",20,20);

    //paintPercentage("strokes_000000599_hank_background2", 4, 2, 163); //296    684
    //paintPercentage("strokes_000000602_hank_lines3", 2, 1, 1000); //296    684
    
    //paintPercentage("hunter_0601_lightcolors",1);
    //paintPercentage("strokes_000000589_corinne_0800", 1, 400); //296    684
    //paintPercentage("strokes_000000590_corinne_0801", 1, 400); //296    684
    //paintPercentage("corinne_0800_background", 1); //296
    //paintPercentage("strokes_000000587_bonnie_0701", 1);
    //paintPercentage("strokes_000000588_bonnie_0702", 204);

/*
     for (int i=0; i<10; i++) {
       mixPaint(6, 1, 8, 5, 7);
       delay(500);
     }
     for (int i=0; i<20; i++) {
       mixPaint(10, 1, 11, 5, 8);
       delay(500);
     }
*/

    
    goToStartPose();
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 0, false, true, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 0, true, false, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 0, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, false, true, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, true, false, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 180, false, true, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 180, true, false, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 180, false, false, true); 

    goToStartPose();
     smoothStrokeElastic(0.25, 0.25, 0.25, 0.25, threeBrushVec56, 0, false, true, false);
     smoothStrokeElastic(0.25, 0.25, 0.75, 0.75, threeBrushVec56, 0, true, false, false);
     smoothStrokeElastic(0.75, 0.75, 0.75, 0.75, threeBrushVec56, 0, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.25, 0.25, 0.25, 0.25, threeBrushVec56, 90, false, true, false);
     smoothStrokeElastic(0.25, 0.25, 0.75, 0.75, threeBrushVec56, 90, true, false, false);
     smoothStrokeElastic(0.75, 0.75, 0.75, 0.75, threeBrushVec56, 90, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.25, 0.25, 0.25, 0.25, threeBrushVec56, 180, false, true, false);
     smoothStrokeElastic(0.25, 0.25, 0.75, 0.75, threeBrushVec56, 180, true, false, false);
     smoothStrokeElastic(0.75, 0.75, 0.75, 0.75, threeBrushVec56, 180, false, false, true); 
     
     goToStartPose();
     smoothStrokeElastic(0.1, 0.1, 0.1, 0.1, threeBrushVec56, 0, false, true, false);
     smoothStrokeElastic(0.1, 0.1, 0.9, 0.9, threeBrushVec56, 0, true, false, false);
     smoothStrokeElastic(0.9, 0.9, 0.9, 0.9, threeBrushVec56, 0, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.1, 0.1, 0.1, 0.1, threeBrushVec56, 90, false, true, false);
     smoothStrokeElastic(0.1, 0.1, 0.9, 0.9, threeBrushVec56, 90, true, false, false);
     smoothStrokeElastic(0.9, 0.9, 0.9, 0.9, threeBrushVec56, 90, false, false, true); 
     goToStartPose();
     smoothStrokeElastic(0.1, 0.1, 0.1, 0.1, threeBrushVec56, 180, false, true, false);
     smoothStrokeElastic(0.1, 0.1, 0.9, 0.9, threeBrushVec56, 180, true, false, false);
     smoothStrokeElastic(0.9, 0.9, 0.9, 0.9, threeBrushVec56, 180, false, false, true); 


    /*
     goOverPaints();
     delay(500);
     //dipTheBrush(1, 3);
     //delay(500);
     for (int i=0; i<10; i++) {
     mixPaint(1, 1, 2, 3, 4);
     delay(500);
     }
     for (int i=0; i<10; i++) {
     mixPaint(2, 3, 3, 5, 5);
     delay(500);
     }
     goOverPaints();
     delay(500);
     
     
     //paintPercentage("strokes_000000580_hunter_0601_ai_test",20);
     
     paintPercentageImitator("strokes_0600_hunter_portrait_000");
     
     */

    //paintPercentage("strokes_0601_hunter_portrait_000",710);
    //paintPercentage("strokes_000000580_hunter_0601_ai_test",20);

    /* goToStartPose();
     smoothStrokeElastic(0.0, 1.0, 0.0, 1.0, threeBrushVec56, 90, false, true, false);
     smoothStrokeElastic(0.0, 1.0, 0.5, 0.5, threeBrushVec56, 90, true, false, false);
     smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, false, false, true); 
     
     paintStrokeFromXYPtoXYP(0.5,0.5,0.75,0.75);
     paintStrokeFromXYPtoXYP(0.5,0.5,0.25,0.25);
     paintStrokeFromXYPtoXYP(0.75,0.75,0.25,0.25);
     */
    for (int k=0; k<0; k++) {
      goToStartPose();
      smoothStrokeElastic(0.0, 1.0, 0.0, 1.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.0, 1.0, 0.0, 1.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.0, 1.0, 0.0, 1.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(0.5, 1.0, 0.5, 1.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.5, 1.0, 0.5, 1.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.5, 1.0, 0.5, 1.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(1.0, 1.0, 1.0, 1.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(1.0, 1.0, 1.0, 1.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(1.0, 1.0, 1.0, 1.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(0.0, 0.0, 0.0, 0.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.0, 0.0, 0.0, 0.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.0, 0.0, 0.0, 0.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(0.5, 0.0, 0.5, 0.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.5, 0.0, 0.5, 0.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.5, 0.0, 0.5, 0.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(1.0, 0.0, 1.0, 0.0, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(1.0, 0.0, 1.0, 0.0, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(1.0, 0.0, 1.0, 0.0, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(0.0, 0.5, 0.0, 0.5, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.0, 0.5, 0.0, 0.5, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.0, 0.5, 0.0, 0.5, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(0.5, 0.5, 0.5, 0.5, threeBrushVec56, 90, false, false, true); 
      goToStartPose();
      smoothStrokeElastic(1.0, 0.5, 1.0, 0.5, threeBrushVec56, 90, false, true, false);
      smoothStrokeElastic(1.0, 0.5, 1.0, 0.5, threeBrushVec56, 90, true, false, false);
      smoothStrokeElastic(1.0, 0.5, 1.0, 0.5, threeBrushVec56, 90, false, false, true);
    }     //<>// //<>//

    goToStartPose();
  }

  if (moveRobot) {

    // 4- IK Geometry
    //PVector j6 = new PVector(0, 100, 200);
    //PVector vec56 = new PVector(0, 0, -1);
    //PVector vec67 = new PVector(1, 0, 0);
    //vec56 = new PVector(0, 1.2, -1);
    //vec67 = new PVector(0, 0, 0);
    //float theta3 = 90;
    //float theta4 = 90;
    //float theta5 = 90;
    //float theta6 = 60;

    System.out.println("go to start pose");
    goToStartPose();

    if (true) {
      //60 degrees 20cm x 20cm
      //200 hypotenuse - 100 cm at base - 173 cm tall
      //smoothStroke(1,  0, 100, 200,     0, 240, 300,     vec56, vec67, theta6);
      //delay(1000);
      // smoothStroke(20,   100, 260, 280,    -100, 260, 280,     vec56, vec67, theta6);
      // smoothStroke(20,  -100, 260, 280,    -100, 160, 100,     vec56, vec67, theta6);
      // smoothStroke(20,  -100, 160, 100,     100, 160, 100,     vec56, vec67, theta6);
      // smoothStroke(20,   100, 160, 100,     100, 260, 280,     vec56, vec67, theta6);

      //    smoothStroke(0.0,  0.0, 0.0, 1.0);
      //    smoothStroke(0.0, 1.0,  1.0,  1.0);
      //    smoothStroke(1.0, 1.0, 1.0,  0.0);
      //    smoothStroke(1.0, 0.0, 0.0,  0.0);

      paint(index, startOnStrokeNumber);

      //smoothStrokeFloat(20,  getRobotX(0), getRobotY(0), getRobotZforRobotY(0), getRobotX(1), getRobotY(1), getRobotZforRobotY(1), vec56, vec67, theta6);
      //smoothStrokeFloat(20,  getRobotX(1), getRobotY(1), getRobotZforRobotY(1), getRobotX(1), getRobotY(0), getRobotZforRobotY(0), vec56, vec67, theta6);
      //smoothStrokeFloat(20,  getRobotX(1), getRobotY(0), getRobotZforRobotY(0), getRobotX(0.4), getRobotY(0.4), getRobotZforRobotY(0.4), vec56, vec67, theta6);

      delay(1000);

      //getStrokes();
    }
    println("The End");
  }

  if (recordMeasurements) {
    System.out.println("go to start pose");
    goToStartPose();
    delay(1000);
    System.out.println("forcestatus:2");
    setForceStatus(2);
    delay(1000);
    recordStrokes();
  }

  if (playMeasurements) {
    System.out.println("go to start pose");
    goToStartPose();
    delay(1000);
    System.out.println("forcestatus:2");
    setForceStatus(2);
    delay(1000);
    playStrokes();
  }
}



void draw()
{
}