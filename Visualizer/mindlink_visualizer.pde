import processing.serial.*;

Serial myPort;
String currentPort;
static String val;
int[] values = new int[32]; // Array to store values for all 32 circles
boolean serialConnected = false;

void setup() {
  size(1300, 1300);
  noStroke();

  initSerial();

  // Initialize all values to 0
  for (int i = 0; i < values.length; i++) {
    values[i] = 0;
  }
}

void initSerial() {
  String portName = "/dev/ttyACM0"; // Update with your port
  do {
    try {
      myPort = new Serial(this, portName, 9600);
      currentPort=portName;
      serialConnected = true;
      break;
    }
    catch(Exception e) {
      println("Could not connect to serial port, trying again...");
      println(e);
      serialConnected = false;
    }
  } while (true);
}

void draw() {
  background(0);

  // Draw grid of circles
  int cols =6;
  int rows = 6;
  float circleSize = width/(cols*2);
  
  strokeWeight(5);
  noFill();
  stroke(150);
  circle(width/2, height/2, width-5);
  //noStroke();
  
  for (int i = 0; i < 4; i++) {
    int col = (i+1) % cols;
    int row = i / rows;
    float x = map(col, 0, cols-1, circleSize, width-circleSize);
    float y = map(row, 0, rows-1, circleSize, height-circleSize);

    fill(values[i]);
    ellipse(x, y, circleSize, circleSize);
  }

  for (int i = 4; i < values.length-4; i++) {
    int col = (i+2) % cols;
    int row = (i+2) / cols;
    float x = map(col, 0, cols-1, circleSize, width-circleSize);
    float y = map(row, 0, rows-1, circleSize, height-circleSize);

    fill(values[i]);
    ellipse(x, y, circleSize, circleSize);
  }
  
  for (int i =values.length-4; i < values.length; i++) {
    int col = (i+3) % cols;
    int row = (i+2) / cols;
    float x = map(col, 0, cols-1, circleSize, width-circleSize);
    float y = map(row, 0, rows-1, circleSize, height-circleSize);

    fill(values[i]);
    ellipse(x, y, circleSize, circleSize);
  }

  if (serialPortCheck()==true && serialConnected) {
    try {
      handleSerial();
    }
    catch(Exception e) {
      println("Error getting data from serial port");
      println(e);
      serialConnected = false;
    }
  } else{
    myPort.stop();
    delay(3000);
    initSerial();
  }
}


boolean serialPortCheck() {
  boolean connected = false;
  String[] str = Serial.list(); // Get the current list of available ports
  for (int i=0; i<str.length; i++) {
    //println("com:"+currentPort+"    str[i]:"+str[i]);
    if (currentPort.equals(str[i])==true) { //check if currentPort is still in the list of comPorts
      connected=true;   // com port found so still connected
      break;
    }
  }
  if (connected == false){
    serialConnected = false;
    myPort.stop();
  }
  return connected;
}

void handleSerial() {
  //try {
  val = myPort.readStringUntil('\n');
  if (val != null) {
    val = val.trim();
    println(val);
    for (int i = 0; i < 32; i++) {
      //String[] parts = split(val, ':');
      //if (parts.length == 2) {
      //  int index = Integer.valueOf(parts[0]);
      //  int value = Integer.valueOf(parts[1]);

      //if (index >= 0 && index < values.length) {
      int v = val.charAt(i) == '1' ? 1 : 0;
      values[i] = v*255;
      //  }
    }
  }
  //else
  //throw new Exception("null value");
  //}
  //catch(Exception e) {
  //  println("Error parsing data: " + val);
  //  println(e);
  //  serialConnected = false;
  //}
}
