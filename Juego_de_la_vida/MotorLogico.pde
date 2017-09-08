class MotorLogico {

  ArrayList<boolean [][]> tablero;
  int opcion;
  int tamanio;
  boolean [][][] data;
  boolean [][][] sigData;

  MotorLogico(int tam, int opc) {
    opcion = opc;
    tamanio = tam;
    tablero = new ArrayList<boolean [][]>();
    if (opcion == 3) {
      this.tablero3D();
    }
    if (opcion == 2) {
      this.tablero2D();
    }
  }

  void tablero2D() {
    tablero.clear();
    boolean [][] tableroN = new boolean[tamanio][tamanio];
    for (int j = 0; j < tamanio; j++)
      for (int k = 0; k < tamanio; k++)
        tableroN[j][k] = false;
    tablero.add(tableroN);
  }

  void tablero3D() {
    data = new boolean[tamanio+2][tamanio+2][tamanio+2];
    sigData = new boolean[tamanio+2][tamanio+2][tamanio+2];
    for (int k = 0; k < tamanio+2; k++) {
      for (int j = 0; j < tamanio+2; j++) {
        for (int i = 0; i < tamanio+2; i++) {
          data[k][j][i] = false;
        }
      }
    }
  }

  void update2D() {
    int vecinosVivos;
    boolean [][] tableroN = new boolean[tamanio][tamanio];
    for (int i = 0; i < tamanio; i++)
      for (int j = 0; j < tamanio; j++)
        tableroN[i][j] = tablero.get(0)[i][j];

    for (int i = 0; i < tamanio; i++) {
      for (int j = 0; j < tamanio; j++) {
        vecinosVivos = 0;
        for (int vecX = i-1; vecX <= (i+1); vecX++) {
          for (int vecY = j-1; vecY <= (j+1); vecY++) {
            /*if (vecX < 0) {
             vecX = tamanio-1;
             }
             if (vecY < 0) {
             vecY = tamanio-1;
             }*/
            //vecX = vecX%tamanio;
            //vecY = vecY%tamanio;
            if (vecX >= 0 && vecX < tamanio && vecY >= 0 && vecY < tamanio) {
              if (!(vecX == i && vecY == j)) {
                if (tableroN[vecX][vecY] == true) {
                  vecinosVivos++;
                }
              }
            }
          }
        }
        if (tableroN[i][j] == true) {
          if (vecinosVivos < 2 || vecinosVivos > 3) {
            tablero.get(0)[i][j] = false;
          }
        } else {
          if (vecinosVivos == 3)
            tablero.get(0)[i][j] = true;
        }
      }
    }
  }

  void update3D(int min, int max) {
    for (int k = 1; k < tamanio+1; k++) {
      for (int j = 1; j < tamanio+1; j++) {
        for (int i = 1; i < tamanio+1; i++) {
          updateCube(k, j, i, min, max);
        }
      }
    }
    for (int k = 1; k < tamanio+1; k++) {
      for (int j = 1; j < tamanio+1; j++) {
        for (int i = 1; i < tamanio+1; i++) {
          data[k][j][i] = sigData[k][j][i];
        }
      }
    }
  }

  void inicializar2D() {
    for (int i = 0; i < tamanio; i++) {
      for (int j = 0; j < tamanio; j++) {
        if (random(0, 100) > 50) {
          tablero.get(0)[i][j] = true;
        }
      }
    }
  }

  void inicializar3D() {
    for (int k = 1; k < tamanio+1; k++) {
      for (int i = 1; i < tamanio+1; i++) {
        for (int j = 1; j < tamanio+1; j++) {
          if (random(0, 100) > 50) {
            data[k][i][j] = true;
          }
        }
      }
    }
  }

  void setTamanio(float tam) {
    tamanio = (int)tam;
  }

  void setOpcion(int opc) {
    opcion = opc;
  }

  int isLive(int k, int j, int i) {
    if (data[k][j][i] == true) {
      return 1;
    } else {
      return 0;
    }
  }

  void updateCube(int k, int j, int i, int min, int max) {
    int result = 0;
    result += isLive(k, j, i  );
    result += isLive(k, j, i-1);
    result += isLive(k, j, i+1);
    result += isLive(k, j-1, i  );
    result += isLive(k, j-1, i-1);
    result += isLive(k, j-1, i+1);
    result += isLive(k, j+1, i  );
    result += isLive(k, j+1, i-1);
    result += isLive(k, j+1, i+1);
    result += isLive(k-1, j, i  );
    result += isLive(k-1, j, i-1);
    result += isLive(k-1, j, i+1);
    result += isLive(k-1, j-1, i  );
    result += isLive(k-1, j-1, i-1);
    result += isLive(k-1, j-1, i+1);
    result += isLive(k-1, j+1, i  );
    result += isLive(k-1, j+1, i-1);
    result += isLive(k-1, j+1, i+1);
    result += isLive(k+1, j, i  );
    result += isLive(k+1, j, i-1);
    result += isLive(k+1, j, i+1);
    result += isLive(k+1, j-1, i  );
    result += isLive(k+1, j-1, i-1);
    result += isLive(k+1, j-1, i+1);
    result += isLive(k+1, j+1, i  );
    result += isLive(k+1, j+1, i-1);
    result += isLive(k+1, j+1, i+1);
    if (data[k][j][i] == true) {
      if (result > max || result < min) {
        sigData[k][j][i] = false;
      } else {
        sigData[k][j][i] = true;
      }
    } else {
      if (result <= max && result >= min) {
        sigData[k][j][i] = true;
      } else {
        sigData[k][j][i] = false;
      }
    }
  }
}