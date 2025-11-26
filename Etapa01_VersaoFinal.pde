import processing.sound.*; 

// --- ARQUIVOS DE SOM ---

SoundFile somBip;
SoundFile GTA;
SoundFile OMG;
SoundFile[] sonsDigitos = new SoundFile[10]; 

// --- VARIÁVEIS GLOBAIS ---

boolean maquinaLigada = false,
        modoDigitoAtivo = false,
        modoTextoAtivo = false;

String textoNoPapel = "";
int charCount = 0; // Contador para quebra de linha
boolean expressaoAlegre = false; 

int digitoPressionado = -1; // -1 = nenhum
char letraPressionada = 0; // 0 = nenhuma

char[] teclasLetras = {'A', 'B', 'C', 'E', 'F', 'G', 'H', 'I', 'J', 'K','L', 'M', 'N', 'P', 'Q', 'R', 'S', 'U', 'V', 'W', 'X', 'Y', 'Z'};

//Animação Abrir/Fechar Olhos
int outH=10, outSpeed = 10,
    inH = 0, inSpeed = 6,
    detH = 0, detSpeed= 1; 
boolean animaAbrirOlho = true,
        animaFecharOlho = false,
        animaOlhosFelizes = true;

void setup() {
  size(800, 800);
  noStroke();
  textAlign(CENTER, CENTER);
  textLeading(14);
  
  //CARREGA OS ARQUIVOS DE SOM
  try {
    somBip = new SoundFile(this, "keyboard-click.mp3");
    for (int i = 0; i < 10; i++) {
       sonsDigitos[i] = new SoundFile(this, str(i) + ".mp3");
    }
    GTA = new SoundFile(this, "GTA.mp3");
    OMG = new SoundFile(this, "OMG.mp3");
  } catch (Exception e) {
    println("Aviso: Verifique os arquivos de som na pasta data.");
  }
}

void draw(){
  background(245, 224, 200);  
  
  desenharCorpoMaquina();
  desenharSombra();
  desenharPapel();
  desenharTextoNoPapel();  

  if (maquinaLigada) {
    desenharEstadoLigado();
    if(modoTextoAtivo || modoDigitoAtivo){
      if (expressaoAlegre) { 
        if(animaOlhosFelizes){ //Aumenta os olhos para felizes
          outH += outSpeed/8;
          inH += inSpeed/4;
          detH += detSpeed/8;
          if(outH == 110){ //max 110 66 9
            animaOlhosFelizes = false;
            animaFecharOlho = true;
          }
        }
      }
    } else{
      if(animaAbrirOlho){ //Abre os olhos padrões
        outH += outSpeed;
        inH += inSpeed;
        detH += detSpeed;
        if(outH == 100){ //max 100 54 9
          animaAbrirOlho = false;
          animaFecharOlho = true;
        }
      }
      if(!animaOlhosFelizes){
        outH -= outSpeed/8;
        inH -= inSpeed/4;
        detH -= detSpeed/8;
        if(outH == 100){ //base 100 54 9
          animaOlhosFelizes = true;
          animaFecharOlho = true;
        }
      }
    }
    
  } else {
    desenharEstadoA_Desligada();
    if(!animaOlhosFelizes && animaFecharOlho){
      if(outH > 100){ //base 100 54 9
        outH -= outSpeed/4;
        inH -= inSpeed/2;
        detH -= detSpeed/4;
      }else{
        outH -= outSpeed;
        inH -= inSpeed;
        detH -= detSpeed;
        if(outH == 10){ //base 10 0 0
          animaAbrirOlho = true;
          animaFecharOlho = false;
          animaOlhosFelizes = true;
        }
      }
    } else if(animaFecharOlho){ 
      outH -= outSpeed;
      inH -= inSpeed;
      detH -= detSpeed;
      if(outH == 10){ //base 10 0 0
        animaAbrirOlho = true;
        animaFecharOlho = false;
      }
    }
  }
}

void resetModeVisuals() {
  expressaoAlegre = false; 
  digitoPressionado = -1; 
  letraPressionada = 0;
}

void tocarSomDigito(int i) {
  if (sonsDigitos[i] != null) {
    sonsDigitos[i].play();
  } else if (somBip != null) {
    somBip.play();
  }
}

void tocarBip() {
  if (somBip != null) somBip.play();
}

void processarDigito(int numero) {
  expressaoAlegre = true; 
  digitoPressionado = numero; 
  tocarSomDigito(numero);
  
  textoNoPapel += str(numero);
  charCount++;
  verificarQuebraLinha();
}

void processarLetra(char letra) {
  expressaoAlegre = true; 
  letraPressionada = letra; 
  tocarBip();
  
  textoNoPapel += Character.toUpperCase(letra);
  charCount++;
  verificarQuebraLinha();
}

void verificarQuebraLinha() {
  if (charCount >= 7) { 
    OMG.play();
    textoNoPapel += "\n";
    charCount = 0;
  }
}

void mousePressed() {
  if (mouseY > 704 && mouseY < 744) {
    
    if (mouseX > 246 && mouseX < 294) {
      tocarBip();
      maquinaLigada = !maquinaLigada;
      if (!maquinaLigada) {
        modoDigitoAtivo = false;
        modoTextoAtivo = false;
        textoNoPapel = "";
        charCount = 0;
        resetModeVisuals();
      }
      return;
    }
    
    if (maquinaLigada) {
      if (mouseX > 376 && mouseX < 424) {
        if (!modoTextoAtivo) { 
          tocarBip();
          modoDigitoAtivo = !modoDigitoAtivo;
          resetModeVisuals(); 
        }
      }
      if (mouseX > 506 && mouseX < 554) {
        if (!modoDigitoAtivo) { 
          tocarBip();
          modoTextoAtivo = !modoTextoAtivo;
          resetModeVisuals(); 
        }
      }
    }
  }

  if (maquinaLigada && modoDigitoAtivo) {
    float y_pos = 500;
    float key_size = 35;
    float spacing = 5;
    float total_width = (key_size + spacing) * 10 - spacing;
    float start_x = width/2 - total_width/2 + key_size/2;
    
    for (int i = 0; i < 10; i++) {
      float x_pos = start_x + i * (key_size + spacing);
      if (dist(mouseX, mouseY, x_pos, y_pos) < key_size/2) {
        processarDigito(i);
        return; 
      }
    }
  }

  if (maquinaLigada && modoTextoAtivo) {
    float y_base = 540;  
    float key_size = 35;
    float spacing = 5;
    float total_width = (key_size + spacing) * 10 - spacing;
    float start_x = width/2 - total_width/2 + key_size/2;
    
    for (int i = 0; i < teclasLetras.length; i++) {
      float x_pos, y_pos;
      
      if(i > 19) {
        y_pos = y_base + 80; 
        x_pos = start_x + (i-20) * (key_size + spacing);
      } else if(i > 9) {
        y_pos = y_base + 40; 
        x_pos = start_x + (i-10) * (key_size + spacing);
      } else {
        y_pos = y_base;      
        x_pos = start_x + i * (key_size + spacing);
      }
      
      if (dist(mouseX, mouseY, x_pos, y_pos) < key_size/2) {
        processarLetra(teclasLetras[i]);
        return;
      }
    }
  }
}

void keyPressed() {
  if (key == 'o' || key == 'O') {
    tocarBip();
    maquinaLigada = !maquinaLigada;
    if (!maquinaLigada) {
      modoDigitoAtivo = false;
      modoTextoAtivo = false;
      textoNoPapel = "";
      charCount = 0;
      resetModeVisuals();
    }
    return;
  }

  if (!maquinaLigada) return;

  if (key == 'd' || key == 'D') {
    if (!modoTextoAtivo) {
      tocarBip();
      modoDigitoAtivo = !modoDigitoAtivo;
      resetModeVisuals(); 
    }
    return;
  }
  
  if (key == 't' || key == 'T') {
    if (!modoDigitoAtivo) {
      tocarBip();
      modoTextoAtivo = !modoTextoAtivo;
      resetModeVisuals(); 
    }
    return;
  }
  
  if (modoDigitoAtivo && (key >= '0' && key <= '9')) { 
    processarDigito(int(str(key)));
  }
  
  if (modoTextoAtivo && ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z'))) {
    processarLetra(key);
  }
}

void desenharCorpoMaquina() {
  rectMode(CENTER);
  fill(60, 60, 90);
  rect(width/2, 665, 521, 191, 30);
  fill(90, 90, 130);
  rect(width/2, 553, 440, 264, 25);
  fill(110, 110, 160);
  rect(width/2, 384, 360, 187, 20);
  fill(50, 50, 80);
  rect(width/2, 334, 380, 35, 10);
  fill(50, 50, 80);
  rect(width/2 - 180, 335, 25, 70, 5);
  rect(width/2 + 180, 335, 25, 70, 5);
}

void desenharPapel() {
  fill(250);
  rect(width/2, 165, 340, 309, 5);
}

void desenharTextoNoPapel() {
  fill(0);
  textSize(48); 
  textLeading(52); 
  textAlign(LEFT, TOP);
  text(textoNoPapel, 235, 20); 
  textAlign(CENTER, CENTER); 
  textSize(12);
  textLeading(14); 
}

void desenharSombra() {
  fill(0, 0, 0, 40);
  rect(width/2, 725, 499, 55, 25);
}

void desenharBocaFechada() {
  fill(70, 70, 110);
  arc(width/2, 470, 80, 13, PI, TWO_PI);
}

void desenharBocaAlegre() {
  fill(70, 70, 110);
  arc(width/2, 445, 80, 50, 0, PI);
  fill(182, 23, 45);
  arc(width/2, 450, 37, 19, 0, PI);
  fill(255, 274, 255);
  arc(width/2, 445, 79, 10, 0, PI);
}

void desenharOlhos() {
  //externo
  if(outH > 15) fill(255); 
  else fill(70, 70, 110);
  arc(width/2 -78, 428, 55, outH, PI, TWO_PI);  
  arc(width/2 +78, 428, 55, outH, PI, TWO_PI); 
  
  //interno
  fill(0); 
  arc(width/2 -78, 428, 30, inH, PI, TWO_PI);  
  arc(width/2 +78, 428, 30, inH, PI, TWO_PI);
  
  //detalhe interno
  fill(255); 
  ellipse(width/2 -78, 418, 7,detH);  
  ellipse(width/2 +78, 418, 7,detH);
}

/*
void desenharOlhosAbertos() {
  fill(255);
  arc(width/2 -78, 428, 55, 101, PI, TWO_PI);  
  arc(width/2 +78, 428, 55, 101, PI, TWO_PI);  
  fill(0);
  arc(width/2 -78, 428, 30, 52, PI, TWO_PI);  
  arc(width/2 +78, 428, 30, 52, PI, TWO_PI);  
  fill(255);
  ellipse(width/2 -78, 418, 7,10);  
  ellipse(width/2 +78, 418, 7,10);  
}

void desenharOlhosFelizes() {
  fill(255);
  arc(width/2 -78, 428, 55, 110, PI, TWO_PI);
  arc(width/2 +78, 428, 55, 110, PI, TWO_PI);
  
  fill(0);
  arc(width/2 -78, 428, 30, 65, PI, TWO_PI);
  arc(width/2 +78, 428, 30, 65, PI, TWO_PI);
  
  fill(255);
  ellipse(width/2 -78, 418, 7,10);
  ellipse(width/2 +78, 418, 7,10);
}

void desenharOlhosFechados() {
  fill(70, 70, 110);  
  arc(width/2 -78, 428, 55, 13, PI, TWO_PI);  
  arc(width/2 +78, 428, 55, 13, PI, TWO_PI);  
}
*/
void desenharEstadoA_Desligada() {
  //desenharOlhosFechados();
  desenharOlhos();
  desenharBocaFechada();
  
  fill(200, 0, 0);  
  rect(width/2 -130, 724, 48, 40, 20);  
  fill(110, 110, 160);  
  rect(width/2, 724, 48, 40, 20);  
  rect(width/2 +130, 724, 48, 40, 20);  
  
  fill(255);
  text("OFF", width/2 -130, 724);  
  text("DIG", width/2, 724);
  text("TEXT", width/2 +130, 724);
}

void desenharEstadoLigado() {
  desenharOlhos();
  //desenharBoca();
  
  //DAQUI A POUCO NAO VAI PRECISAR DESSE IF ELSE MAIS (NAO ADICIONA COISAS DENTRO DELE)
  if (expressaoAlegre) { 
    desenharBocaAlegre(); 
  } else {
    desenharBocaFechada(); 
  }

  fill(0, 200, 0); 
  rect(width/2 -130, 724, 48, 40, 20); 
  
  if (modoDigitoAtivo) fill(255, 165, 0); 
  else fill(110, 110, 160); 
  rect(width/2, 724, 48, 40, 20); 
  
  if (modoTextoAtivo) fill(0, 150, 200); 
  else fill(110, 110, 160); 
  rect(width/2 +130, 724, 48, 40, 20); 
  
  fill(255);
  text("ON", width/2 -130, 724); 
  text("DIG", width/2, 724);
  text("TEXT", width/2 +130, 724);

  if (modoDigitoAtivo) desenharTecladoDigitos();
  if (modoTextoAtivo) desenharTecladoLetras(); 
}

void desenharTecladoDigitos() {
  float y_pos = 500;  
  float key_size = 35;
  float spacing = 5;
  float total_width = (key_size + spacing) * 10 - spacing;
  float start_x = width/2 - total_width/2 + key_size/2;
  
  textSize(16);
  
  for (int i = 0; i < 10; i++) {
    float x_pos = start_x + i * (key_size + spacing);
    
    if (i == digitoPressionado) fill(255, 255, 0); 
    else fill(220, 220, 240);  
    
    ellipse(x_pos, y_pos, key_size, key_size);
    fill(0);  
    text(str(i), x_pos, y_pos);
  }
  textSize(12);  
}

void desenharTecladoLetras() {
  float y_base = 540;  
  float key_size = 35;
  float spacing = 5;
  float total_width = (key_size + spacing) * 10 - spacing;
  float start_x = width/2 - total_width/2 + key_size/2;
  
  textSize(16);
  
  for (int i = 0; i < teclasLetras.length; i++) {
    float x_pos, y_pos;
    if(i > 19) {
      y_pos = y_base + 80;
      x_pos = start_x + (i-20) * (key_size + spacing);
    } else if(i > 9) {
      y_pos = y_base + 40;
      x_pos = start_x + (i-10) * (key_size + spacing);
    } else {
      y_pos = y_base;
      x_pos = start_x + i * (key_size + spacing);
    }
    
    if (Character.toUpperCase(letraPressionada) == teclasLetras[i]) fill(255, 255, 0); 
    else fill(220, 220, 240);  
    
    ellipse(x_pos, y_pos, key_size, key_size);
    fill(0);  
    text(teclasLetras[i], x_pos, y_pos);
  }
  textSize(12);  
}
