import controlP5.*;

color bcolor = color(255, 255, 255);

int divisiones = 100;
int tamanioGrilla = 900;
MotorGrafico grafico;
int ultimoTiempo = 0;
boolean first = true;
int estado = 0;
boolean pausa = false;
boolean Start = false;
boolean retornar = false;
boolean D = false;

void setup()
{
  size(1224, 768, P3D);
  background(bcolor);

  grafico = new MotorGrafico(divisiones, tamanioGrilla, width, height, new Cp5Control(new ControlP5(this)), bcolor);
  grafico.inicio();
}

void draw()
{
  switch(estado) {
  case 0:
    estado = 1;
    delay(5);
    break;
  case 2:
    if (!pausa) {
      if (millis() - ultimoTiempo > grafico.cp5.valorIntervalo()) {
        grafico.update2D();
        ultimoTiempo = millis();
      }
    }
    break;
  case 3:
    if (!pausa) {
      if (millis() - ultimoTiempo > grafico.cp5.valorIntervalo()) {
        grafico.update3D();
        ultimoTiempo = millis();
      }
    }
    break;
  }
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName().equals("reiniciar")) {
    if (!first) {
      if (estado == 2) {
        grafico.logico.inicializar2D();
        grafico.update2D();
      } else {
        grafico.logico.inicializar3D();
        grafico.update3D();
      }
    } else
      first = false;
  }
  if (theEvent.getController().getName().equals("iniciar")) {
    if (Start) {
      D = grafico.cp5.getDValue();
      if (D) {
        grafico.borrarInicio2D();
        estado = 2;
      } else {
        grafico.borrarInicio3D();
        grafico.inicializar3D();
        estado = 3;
      }
    } else {
      Start = true;
    }
  }
  if (theEvent.getController().getName().equals("volver")) {
    if (retornar) {
      grafico.borrar2D();
      grafico.borrar3D();
      background(bcolor);
      estado = 0;
    } else {
      retornar = true;
    }
  }
}

void keyPressed() {
  if (estado == 3) {
    if (keyCode == UP){
      grafico.setDistance(50);
      grafico.update3Draw();
    }
    if (keyCode == DOWN){
      grafico.setDistance(-50);
      grafico.update3Draw();
    }
  }
}

void mouseDragged() {
  if (estado == 3) {
    grafico.setRotx((mouseX - pmouseX) * 0.01);
    grafico.setRoty((mouseY - pmouseY) * 0.01);
    grafico.update3Draw();
  }
}