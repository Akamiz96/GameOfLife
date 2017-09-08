class MotorGrafico {

  int tamanioCelda;
  int espacioWidth;
  int espacioHeight;
  int divisiones;
  int tamanioGrilla;
  int Width;
  int Height;
  MotorLogico logico; 
  Cp5Control cp5;
  color bcolor;
  float rotx = 0;
  float roty = 0;
  float distance = 800; 

  MotorGrafico(int div, int tamGrilla, int W, int H, Cp5Control cp, color b) {

    bcolor = b;
    cp5 = cp;
    divisiones = div;
    tamanioGrilla = tamGrilla;
    Width = W;
    Height = H;
    tamanioCelda= tamanioGrilla/divisiones;
    espacioWidth = (Width-tamanioGrilla)-40;
    espacioHeight = (Height-tamanioGrilla)-40;
    logico = new MotorLogico(divisiones, 2);
    logico.inicializar2D();
  }

  void inicio() {
    cp5.inicio();
  }

  void borrarInicio2D() {
    cp5.borrarInicio();
    cp5.iniciar2D();
    this.setDivisiones(cp5.valorDivisiones());
    this.setTamGrilla(cp5.valorTamano());
    logico.tablero2D();
    logico.inicializar2D();
    this.paint2D();
  }

  void borrarInicio3D() {
    cp5.borrarInicio();
    cp5.iniciar3D();
    this.setDivisiones(cp5.valorDivisiones());
    this.setTamGrilla(cp5.valorTamano());
    logico.tablero3D();
    logico.inicializar3D();
    this.update3D();
  }

  void borrar2D() {
    cp5.mostrarInicio();
    cp5.borrar2D();
  }

  void borrar3D() {
    cp5.mostrarInicio();
    cp5.borrar3D();
  }

  void inicializar2D() {
    noFill();
    translate(espacioWidth, espacioHeight);
    for (int i = 0; i < divisiones; i++) {
      for (int j = 0; j < divisiones; j++) {
        rect(0, 0, tamanioCelda, tamanioCelda);
        translate(tamanioCelda, 0);
      }
      translate(-(tamanioCelda*divisiones), tamanioCelda);
    }
    translate(-espacioWidth, -(tamanioCelda*divisiones)-espacioHeight);
  }

  void update2D() {
    logico.update2D();
    this.paint2D();
  }

  void paint2D() {
    translate(espacioWidth, espacioHeight);
    noStroke();
    for (int i = 0; i < divisiones; i++) {
      for (int j = 0; j < divisiones; j++) {
        if (logico.tablero.get(0)[i][j]== true) {
          fill(0, 0, 0);
        } else {
          fill(255, 255, 255);
        }
        rect(0, 0, tamanioCelda, tamanioCelda);
        translate(tamanioCelda, 0);
      }
      translate(-(tamanioCelda*divisiones), tamanioCelda);
    }
    stroke(255);
    line(0, 0, tamanioCelda*divisiones, 0);
    line(tamanioCelda*divisiones, 0, tamanioCelda*divisiones, -tamanioCelda*divisiones);
    translate(-espacioWidth, -(tamanioCelda*divisiones)-espacioHeight);
  }

  void update3D() {
    int min = (int)cp5.cp5.getController("vecinos_min").getValue();
    int max = (int)cp5.cp5.getController("vecinos_max").getValue();
    if (min > max) {
      cp5.mostrarError();
      logico.update3D(4, 6);
      this.update3Draw();
      cp5.cp5.getController("pausa").setValue(1);
    } else {
      cp5.ocultarError();
      logico.update3D(min, max);
      this.update3Draw();
      cp5.cp5.getController("pausa").setValue(0);
    }
  }
  void update3Draw() {
    background(0);
    pushMatrix();
    translate((width+(espacioWidth/2))/2, (height+(espacioHeight/2))/2, -distance);
    stroke(0);
    strokeWeight(2);
    rotateY(rotx);
    rotateX(roty);
    for (int k = 1; k < logico.tamanio+1; k += 1) {
      pushMatrix();
      for (int j = 1; j < logico.tamanio+1; j += 1) {
        pushMatrix();
        for (int i = 1; i < logico.tamanio+1; i += 1) {
          pushMatrix();
          translate((k-(logico.tamanio/2))*tamanioCelda, (j-(logico.tamanio/2))*tamanioCelda, (i-(logico.tamanio/2))*tamanioCelda);
          if (logico.data[k][j][i] == true) {
            //fill(221,237,14);
            fill(map(k, 0, logico.tamanio-2, 0, 255), map(j, 0, logico.tamanio-2, 0, 255), map(i, 0, logico.tamanio-2, 0, 255));//,100);
            box(tamanioCelda);
          }

          popMatrix();
        }
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }

  void inicializar3D() {
    background(bcolor);
    logico.inicializar3D();
  }
  void setDivisiones(float div) {
    divisiones = (int)div;
    logico.setTamanio(divisiones);
  }

  void setTamGrilla(float TGrilla) {
    tamanioGrilla =(int)TGrilla;
    tamanioCelda = (int)(TGrilla/divisiones);
    espacioWidth = (Width-(tamanioCelda*divisiones))-40;
    espacioHeight = (Height-(tamanioCelda*divisiones))-40;
  }

  void setRotx(float value) {
    rotx += value;
  }

  void setRoty(float value) {
    roty += value;
  }

  void setDistance(float value) {
    distance += value;
  }
}