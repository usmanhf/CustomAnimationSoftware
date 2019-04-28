import codeanticode.tablet.*;

int layer = 1;
boolean l1 = false;
boolean l2 = false;
boolean l3 = false;
boolean l4 = false;
boolean l5 = false;
int sx = 1928;
int sy = 6;
int totalFrames = 86;

int rectd1x, rectd2x, rectd3x, rectd4x, rectd5x, rectd1y, rectd2y, rectd3y, rectd4y, rectd5y;
int rects1x, rects2x, rects3x, rects4x, rects5x, rects1y, rects2y, rects3y, rects4y, rects5y;
int rectSize = 20;
color drawLayerColor, showLayerColor;
color selectedDrawLayerColor, selectedShowLayerColor;



String videoPrefix = "cube-12fps-";
PImage videoFrame;
String drawingPrefix = "tomato-";
PImage drawing;

int currentFrame = 0;
boolean showVideo = true;

PGraphics d;  // Drawing layer

PGraphics layer1;
PGraphics layer2;
PGraphics layer3;
PGraphics layer4;
PGraphics layer5;
PImage selector;
color scolor;
PGraphics tempD;
int penWidth = 30;


Tablet tablet;

void setup() {
  //background(51, 51, 51);
  size(2000, 1080);
  d = createGraphics(width-80, height);
  tempD = createGraphics(width-80, height);
  layer1 = createGraphics(width-80, height);
  layer2 = createGraphics(width-80, height);
  layer3 = createGraphics(width-80, height);
  layer4 = createGraphics(width-80, height);
  layer5 = createGraphics(width-80, height);
  selector = loadImage("colors.png");
  scolor = color(0,0,0);
  loadDrawing();
  tablet = new Tablet(this);
  drawLayerColor = color(255);
  showLayerColor = color(255);
  selectedDrawLayerColor = color(255, 251, 165);
  selectedShowLayerColor = color(255, 165, 255);
  rectd1x = 1930;
  rectd2x = 1930;
  rects1x = 1970;
  rects2x = 1970;
  
  rectd1y = 280;
  rectd2y = 320;
  rects1y = 280;
  rects2y = 320;
  frameRate(12);
  tempD.stroke(scolor);
  loadFrame();
}

void draw() {
  image(videoFrame, 0, 0, width-80, height);
  stroke(0);
  fill(255);
  //background(255);
  fill(layer==1 ? selectedDrawLayerColor : color(255)); 
  rect(rectd1x, rectd1y, rectSize, rectSize);
  fill(layer==2 ? selectedDrawLayerColor : color(255));
  rect(rectd2x, rectd2y, rectSize, rectSize);
  
  
  fill(l1 ? selectedShowLayerColor : color(255));
  rect(rects1x, rects1y, rectSize, rectSize);
  fill(l2 ? selectedShowLayerColor : color(255));
  rect(rects2x, rects2y, rectSize, rectSize);
  
  fill(0);
  textSize(16);
  text("1", rectd1x + 6, rectd1y + 16);
  text("2", rectd2x + 6, rectd2y + 16);
  
  text("1", rects1x + 6, rects1y + 16);
  text("2", rects2x + 6, rects2y + 16);
  
  textSize(8);
  text("Frame", sx+40, sy+40);
  
  textSize(16);
  text(currentFrame, sx+40, sy+60);
  
  
  
  
  if(layer == 1) {
    image(layer1, 0, 0, width-80, height);
    //saveAnimationFrame();
    
  }
  if(layer == 2) {
    image(layer2, 0, 0, width-80, height);
    //saveAnimationFrame();
  }
  String file1 = drawingPrefix + nf(currentFrame, 4) + "-1.png";
  String file2 = drawingPrefix + nf(currentFrame, 4) + "-2.png";
  PImage drawing1 = loadImage(file1);
  PImage drawing2 = loadImage(file2);
  int alpha1 = l1 ? 255 : 0;
  int alpha2 = l2 ? 255 : 0;
  try{
    tint(255, 255, 255, alpha1);
  image(drawing1, 0, 0, width-80, height);
  }
  catch (Exception e) {
    loadDrawing();
  }
  try{
  tint(255, 255, 255, alpha2);
  image(drawing2, 0, 0, width-80, height);
  }
  catch (Exception e) {
    loadDrawing();
  }
  tint(255, 255, 255, 255);
  tempD.beginDraw();
  tempD.stroke(scolor);
  tempD.strokeWeight(penWidth*tablet.getPressure());
  if (mousePressed) {
    tempD.line(mouseX, mouseY, pmouseX, pmouseY);
  }
  tempD.endDraw();
  image(selector, sx, sy);
  image(tempD, 0, 0);
}

boolean overSelector() {
  if (mouseX > sx && mouseX < sx+selector.width &&
      mouseY > sy && mouseY < sy+selector.height) {
        return true;
      }else {
        return false;
      }
}

void mousePressed() {
  if (overSelector()) {
    scolor = selector.get(mouseX-sx, mouseY-sy);
  }
  
  if (layer == 1) {
    layer1.beginDraw();
    layer1.image(tempD.get(), 0, 0);
    layer1.endDraw();
    tempD.clear();
    
    saveAnimationFrame();
  }
  if (layer == 2) {
    layer2.beginDraw();
    layer2.image(tempD.get(), 0, 0);
    layer2.endDraw();
    saveAnimationFrame();
    tempD.clear();
    
    saveAnimationFrame();
  }
}

void keyPressed() {
  if(key == ' ') {
    saveAnimationFrame();
    currentFrame ++;
    if (layer == 1) {
      layer1.beginDraw();
      layer1.clear(); 
      layer1.endDraw();
    }
    if (layer == 2) {
      layer2.beginDraw();
      layer2.clear(); 
      layer2.endDraw();
    }
    loadDrawing();
    loadFrame();
    tempD.clear();
  }
  if(keyCode == BACKSPACE) {
    if (currentFrame > 0){
    saveAnimationFrame();
    currentFrame --; 
    if (layer == 1) {
      layer1.beginDraw();
      layer1.clear(); 
      layer1.endDraw();
    }
    if (layer == 2) {
      layer2.beginDraw();
      layer2.clear(); 
      layer2.endDraw();
    }
    loadDrawing();
    loadFrame();
    tempD.clear();
    }
  }
  
  if(key == '[' || key == '{' || key == '-' || key == '_'){
    penWidth-=10;
  }
  if(key == ']' || key == '}' || key == '=' || key == '+'){
    penWidth+=10;
  }
  
  if (key == 's' || key == 'S') {
    saveAnimationFrame(); 
  }
  if (key == ' ' ) {
    showVideo = !showVideo;
  }
    if (key == '1') {
    if (layer == 2) {
      layer2.endDraw();
    }
    saveAnimationFrame();
    layer = 1;
    loadDrawing();
    layer1.beginDraw();
  }
  if (key == '2') {
    if (layer == 1) {
      layer1.endDraw();
    }
    saveAnimationFrame();
    layer = 2;
    loadDrawing();
    layer2.beginDraw();
  }
  
  if (key == 'Q' || key == 'q') {
    l1 = l1 ? false : true;
  }
  
  if (key == 'W' || key == 'w') {
    l2 = l2 ? false : true;
}
  tint(255,255,255,255);
  if(key == 'z' || key == 'Z') {
    undo();
  }
}


void saveAnimationFrame() {
  String filename = drawingPrefix + nf(currentFrame, 4) + "-" + layer + ".png";
  if (layer == 1) {
    layer1.beginDraw();
    layer1.image(tempD.get(), 0, 0);
    layer1.endDraw();
    layer1.save(filename);
  }
  if (layer == 2) {
    layer2.beginDraw();
    layer2.image(tempD.get(), 0, 0);
    layer2.endDraw();
    layer2.save(filename); 
  }
  
  tempD.beginDraw();
  tempD.clear();
  tempD.endDraw();
}
void loadFrame() {
  String filename = videoPrefix + nf(currentFrame, 4) + ".png";
  videoFrame = loadImage(filename);
}
void loadDrawing() {
  String filename = drawingPrefix + nf(currentFrame, 4) + "-" + layer + ".png";
  try {
    drawing = loadImage(filename);
    if (layer == 1) {
      layer1.beginDraw();
      layer1.image(drawing, 0, 0, width-80, height);
      layer1.endDraw();
    }
    if (layer == 2) {
      layer2.beginDraw();
      layer2.image(drawing, 0, 0, width-80, height);
      layer2.endDraw();
    }
  }
  catch (Exception e) {
    if (layer == 1) {
      layer1.beginDraw();
      layer1.clear();
      layer1.endDraw();
      layer1.save(filename);
      drawing = loadImage(filename);
      layer1.beginDraw();
      layer1.image(drawing, 0, 0, width-80, height);
      layer1.endDraw();
    }
    if (layer == 2) {
      layer2.beginDraw();
      layer2.clear();
      layer2.endDraw();
      layer2.save(filename);
      drawing = loadImage(filename);
      layer2.beginDraw();
      layer2.image(drawing, 0, 0, width-80, height);
      layer2.endDraw();
    }
  }
  
}

void undo() {
  tempD.clear(); 
  saveAnimationFrame();
}
