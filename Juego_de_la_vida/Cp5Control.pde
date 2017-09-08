class Cp5Control {
  ControlP5 cp5;
  ControlFont font2D = new ControlFont(createFont("Arial", 30));
  ControlFont fontError = new ControlFont(createFont("Arial", 25));
  
  Cp5Control(ControlP5 control) {
    cp5 = control;
  }

  void inicio() {
    cp5.begin(cp5.addBackground("B")
      .setColorValue(100));
    //Pantalla de Inicio
    cp5.addSlider("tamano")
      .setPosition(10, 20)
      .setSize(200, 40)
      .setRange(100, 700)
      .setValue(700)
      .setNumberOfTickMarks(601)
      ;
    cp5.addSlider("divisiones")
      .setPosition(10, 70)
      .setSize(200, 40)
      .setRange(10, 700)
      .setValue(100)
      ;
    cp5.addToggle("3D")
      .setPosition(10, 120)
      .setSize(80, 20)
      .setMode(Toggle.SWITCH)
      ;
    cp5.addButton("iniciar")
      .setValue(0)
      .setPosition(10, 160)
      .setSize(200, 100)
      .setColorBackground(color(0, 255, 0))
      .setColorForeground(color(0, 255, 0))
      ;
    //Para 2D
    cp5.addSlider("intervalo")
      .setPosition(10, 20)
      .setSize(243, 40)
      .setRange(40, 1000)
      .setValue(250)
      .hide()
      ;
    cp5.addButton("reiniciar")
      .setPosition(10, 150)
      .setSize(200, 19)
      .setValue(0)
      .hide()
      ;
    cp5.addToggle("pausa")
      .setPosition(10, 90)
      .setSize(80, 20)
      .setMode(Toggle.SWITCH)
      .hide()
      ;
    cp5.addButton("volver")
      .setPosition(10, 200)
      .setSize(100, 100)
      .setValue(0)
      .hide()
      .setColorBackground(color(255, 0, 0))
      .setColorForeground(color(255, 0, 0))
      ;
    cp5.addLabel("2 dimensiones")
      .setFont(font2D)
      .setPosition(40, 350)
      .hide();
    cp5.addLabel("3 dimensiones")
      .setFont(font2D)
      .setPosition(40, 350)
      .hide();
    cp5.addSlider("transicion")
      .setPosition(10, 70)
      .setSize(200, 40)
      .setRange(0, 8)
      .setValue(4)
      .hide()
      ;
    cp5.addSlider("vecinos_max")
      .setPosition(140, 200)
      .setSize(70, 40)
      .setRange(5, 26)
      .setValue(6)
      .hide()
      .setNumberOfTickMarks(22)
      ;
    cp5.addSlider("vecinos_min")
      .setPosition(140, 250)
      .setSize(70, 40)
      .setRange(1, 13)
      .setValue(4)
      .hide()
      .setNumberOfTickMarks(13)
      ;
    cp5.addLabel("error")
      .setFont(fontError)
      .setPosition(140, 310)
      .hide()
      .setColor(color(255,0,0));
      //.setColorBackground(color(255,0,0,15))
      ;
    cp5.end();
  }
  void mostrarInicio() {
    cp5.get("tamano").show();
    cp5.get("divisiones").show();
    cp5.get("3D").show();
    cp5.get("iniciar").show();
  }
  void borrarInicio() {
    cp5.get("tamano").hide();
    cp5.get("divisiones").hide();
    cp5.get("3D").hide();
    cp5.get("iniciar").hide();
  }

  void iniciar2D() {
    cp5.get("3D").setValue(0);
    cp5.get("intervalo").show();
    cp5.get("reiniciar").show();
    cp5.get("pausa").show();
    cp5.get("volver").show();
    cp5.get("2 dimensiones").show();
  }
  void borrar2D() {
    cp5.get("intervalo").hide();
    cp5.get("intervalo").setValue(250);
    cp5.get("reiniciar").hide();
    cp5.get("pausa").hide();
    cp5.get("pausa").setValue(0);
    cp5.get("volver").hide();
    cp5.get("2 dimensiones").hide();
  }

  void iniciar3D() {
    cp5.get("3D").setValue(0);
    cp5.get("intervalo").show();
    cp5.get("reiniciar").show();
    cp5.get("pausa").show();
    cp5.get("volver").show();
    cp5.get("3 dimensiones").show();
    cp5.get("vecinos_min").show();
    cp5.get("vecinos_max").show();
  }

  void borrar3D() {
    cp5.get("intervalo").hide();
    cp5.get("intervalo").setValue(250);
    cp5.get("reiniciar").hide();
    cp5.get("pausa").hide();
    cp5.get("pausa").setValue(0);
    cp5.get("volver").hide();
    cp5.get("3 dimensiones").hide();
    cp5.get("vecinos_min").hide();
    cp5.get("vecinos_max").hide();
    cp5.get("error").hide();
  }
  
  void mostrarError(){
    cp5.get("error").show();
  }
  
  void ocultarError(){
    cp5.get("error").hide();
  }
  float valorIntervalo() {
    return cp5.getController("intervalo").getValue();
  }

  float valorTamano() {
    return cp5.getController("tamano").getValue();
  }

  float valorDivisiones() {
    return cp5.getController("divisiones").getValue();
  }

  boolean getDValue() {
    if (cp5.getController("3D").getValue() == 0)
      return true;
    else
      return false;
  }

  public void controlEvent(ControlEvent theEvent) {
    println(theEvent.getController().getName());
  }
}