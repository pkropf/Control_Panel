// Copyright (c) 2011 Peter Kropf. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


const int solenoid_count = 8;
const int quantum = 62;


unsigned long last_tick = 0;   // last time a step was performed
volatile int current_step = 0; // the current step to be performed
volatile int steps = 0;        // number of steps in the current pattern
volatile int pattern = 0;      // which pattern to run
volatile int running_serial = 0;
volatile int running_button = 0;


char *pshelln = 0;
char *pshellf = 0;
char *psl1    = 0;
char *psl2    = 0;
char *psl3    = 0;
char *psl4    = 0;
char *prenl   = 0;
char *prenr   = 0;
char *psr4    = 0;
char *psr3    = 0;
char *psr2    = 0;
char *psr1    = 0;
char *pmezf   = 0;
char *pmezn   = 0;


const int sl1    = 22;  // stage left, poofer 1 (sl1)
const int sl2    = 24;  // stage left, poofer 2 (sl2)
const int sl3    = 25;  // stage left, poofer 3 (sl3)
const int sl4    = 26;  // stage left, poofer 4 (sl4)
const int sr4    = 27;  // stage right, poofer 4 (sr4)
const int sr3    = 28;  // stage right, poofer 3 (sr3)
const int sr2    = 29;  // stage right, poofer 2 (sr2)
const int sr1    = 23;  // stage right, poofer 1 (sr1)
const int shelln = 30;  // shell near poofer (shelln)
const int shellf = 32;  // shell far poofer (shellf)
const int renl   = 33;  // rental wall left poofer (renl)
const int renr   = 34;  // rental wall right poofer (renr)
const int mezf   = 35;  // mez far poofer (mezf)
const int mezn   = 31;  // mez near poofer (mezn)


const int p1pin = 2;
const int p2pin = 3;
const int p3pin = 21;
const int p4pin = 20;
const int p5pin = 19;
const int p6pin = 18;



// seed pattern that does nothing
const int steps0 = 99;
//                          1         2         3         4         5         6         7         8         9         
//                 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
char p0shelln[] = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0shellf[] = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sl1[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sl2[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sl3[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sl4[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0renl[]   = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0renr[]   = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sr4[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sr3[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sr2[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0sr1[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0mezf[]   = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
char p0mezn[]   = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";


const int steps1 = 30;
//                          1         2         3
//                 123456789012345678901234567890
char p1shelln[] = "100000000000000000000000000000"; 
char p1shellf[] = "001000000000000000000000000000"; 
char p1sl1[]    = "100000000000000000000000000010"; 
char p1sl2[]    = "000010000000000000000000100000"; 
char p1sl3[]    = "000000001000000000001000000000"; 
char p1sl4[]    = "000000000000100010000000000000"; 
char p1renl[]   = "000000001000000000001000000000"; 
char p1renr[]   = "000000000000100010000000000000"; 
char p1sr4[]    = "000000000000100010000000000000"; 
char p1sr3[]    = "000000001000000000001000000000"; 
char p1sr2[]    = "000010000000000000000000100000"; 
char p1sr1[]    = "100000000000000000000000000010"; 
char p1mezf[]   = "000000001000000000001000000000"; 
char p1mezn[]   = "000000000000100010000000000000"; 


const int steps2 = 15;
//                          1     
//                 123456789012345
char p2shelln[] = "000011000000000";
char p2shellf[] = "001100000000000";
char p2sl1[]    = "000000110000000";
char p2sl2[]    = "000000001100000";
char p2sl3[]    = "000000000011000";
char p2sl4[]    = "000000000000110";
char p2renl[]   = "110000000000000";
char p2renr[]   = "110000000000000";
char p2sr4[]    = "000000000000110";
char p2sr3[]    = "000000000011000";
char p2sr2[]    = "000000001100000";
char p2sr1[]    = "000000110000000";
char p2mezf[]   = "001100000000000";
char p2mezn[]   = "000011000000000";


const int steps3 = 39;
//                          1         2         3
//                 123456789012345678901234567890123456789
char p3shelln[] = "110011000000001100110000000011001100000";
char p3shellf[] = "110011000000001100110000000011001100000";
char p3sl1[]    = "000000000000000000000000000000000000000";
char p3sl2[]    = "000000000000000000000000000000000000000";
char p3sl3[]    = "000000000000000000000000000000000000000";
char p3sl4[]    = "000000000000000000000000000000000000000";
char p3renl[]   = "000000001100000000000011000000000000110";
char p3renr[]   = "000000001100000000000011000000000000110";
char p3sr4[]    = "000000000000000000000000000000000000000";
char p3sr3[]    = "000000000000000000000000000000000000000";
char p3sr2[]    = "000000000000000000000000000000000000000";
char p3sr1[]    = "000000000000000000000000000000000000000";
char p3mezf[]   = "110011000000001100110000000011001100000";
char p3mezn[]   = "110011000000001100110000000011001100000";


// sequence stage left to stage right to mez to rental to shell
int steps4 = 31;
//                          1         2         3
//                 1234567890123456789012345678901
char p4shelln[] = "0000000000000000000000000000110"; 
char p4shellf[] = "0000000000000000000000000011000"; 
char p4sl1[]    = "1100000000000000000000000000000"; 
char p4sl2[]    = "0011000000000000000000000000000"; 
char p4sl3[]    = "0000110000000000000000000000000"; 
char p4sl4[]    = "0000001100000000000000000000000"; 
char p4renl[]   = "0000000000000000000000001100000"; 
char p4renr[]   = "0000000000000000000000110000000"; 
char p4sr4[]    = "0000000000110000000000000000000"; 
char p4sr3[]    = "0000000000001100000000000000000"; 
char p4sr2[]    = "0000000000000011000000000000000"; 
char p4sr1[]    = "0000000000000000110000000000000"; 
char p4mezf[]   = "0000000000000000000011000000000"; 
char p4mezn[]   = "0000000000000000001100000000000"; 


// sequence shell to rental to mez to stage right to stage left
int steps5 = 32;
//                          1         2         3
//                 1234567890123456789012345678901
char p5shelln[] = "01100000000000000000000000000000";
char p5shellf[] = "00011000000000000000000000000000";
char p5sl1[]    = "00000000000000000000000000000110";
char p5sl2[]    = "00000000000000000000000000011000";
char p5sl3[]    = "00000000000000000000000001100000";
char p5sl4[]    = "00000000000000000000000110000000";
char p5renl[]   = "00000110000000000000000000000000";
char p5renr[]   = "00000001100000000000000000000000";
char p5sr4[]    = "00000000000000000001100000000000";
char p5sr3[]    = "00000000000000000110000000000000";
char p5sr2[]    = "00000000000000011000000000000000";
char p5sr1[]    = "00000000000001100000000000000000";
char p5mezf[]   = "00000000011000000000000000000000";
char p5mezn[]   = "00000000000110000000000000000000";


int steps6 = 23;
//                          1         2
//                 12345678901234567890123
char p6shelln[] = "11000011000000000000010"; 
char p6shellf[] = "11000011000000000000010"; 
char p6sl1[]    = "11000011000000000000010"; 
char p6sl2[]    = "11000011000000000000010"; 
char p6sl3[]    = "11000011000000000000010"; 
char p6sl4[]    = "11000011000000000000010"; 
char p6renl[]   = "11000011000000000000010"; 
char p6renr[]   = "11000011000000000000010"; 
char p6sr4[]    = "11000011000000000000010"; 
char p6sr3[]    = "11000011000000000000010"; 
char p6sr2[]    = "11000011000000000000010"; 
char p6sr1[]    = "11000011000000000000010"; 
char p6mezf[]   = "11000011000000000000010"; 
char p6mezn[]   = "11000011000000000000010"; 


void setup()
{
  Serial.begin(57600);

  last_tick = millis();

  pinMode(sl1,    OUTPUT);
  pinMode(sl2,    OUTPUT);
  pinMode(sl3,    OUTPUT);
  pinMode(sl4,    OUTPUT);
  pinMode(sr4,    OUTPUT);
  pinMode(sr3,    OUTPUT);
  pinMode(sr2,    OUTPUT);
  pinMode(sr1,    OUTPUT);
  pinMode(shelln, OUTPUT);
  pinMode(shellf, OUTPUT);
  pinMode(renl,   OUTPUT);
  pinMode(renr,   OUTPUT);
  pinMode(mezf,   OUTPUT);
  pinMode(mezn,   OUTPUT);

  pinMode(p1pin, INPUT);
  pinMode(p2pin, INPUT);
  pinMode(p3pin, INPUT);
  pinMode(p4pin, INPUT);
  pinMode(p5pin, INPUT);
  pinMode(p6pin, INPUT);
}


void show_pattern()
{
  int i;

  Serial.println(steps);
  Serial.println(pshelln);
  Serial.println(pshellf);
  Serial.println(psl1);
  Serial.println(psl2);
  Serial.println(psl3);
  Serial.println(psl4);
  Serial.println(prenl);
  Serial.println(prenr);
  Serial.println(psr4);
  Serial.println(psr3);
  Serial.println(psr2);
  Serial.println(psr1);
  Serial.println(pmezf);
  Serial.println(pmezn);
  Serial.println("");
}


void trip(char note, int solenoid)
{
  if (note == '0') {
    digitalWrite(solenoid, LOW);
  }

  else {

    if (note == '1') {
      digitalWrite(solenoid, HIGH);
    }

  }
}

void trip_off()
{
  trip(shelln, 0);
  trip(shellf, 0);
  trip(sl1,    0);
  trip(sl2,    0);
  trip(sl3,    0);
  trip(sl4,    0);
  trip(renl,   0);
  trip(renr,   0);
  trip(sr4,    0);
  trip(sr3,    0);
  trip(sr2,    0);
  trip(sr1,    0);
  trip(mezf,   0);
  trip(mezn,   0);
}


void run_pattern()
{
  int i;
  unsigned long now = millis();

  if (running_serial || running_button) {

    if(now - last_tick > quantum) {    // has quantum time passed?
      if (current_step < steps) {     // are there more steps in the pattern?
        trip(pshelln[current_step], shelln);
        trip(pshellf[current_step], shellf);
        trip(psl1[current_step],    sl1);
        trip(psl2[current_step],    sl2);
        trip(psl3[current_step],    sl3);
        trip(psl4[current_step],    sl4);
        trip(prenl[current_step],   renl);
        trip(prenr[current_step],   renr);
        trip(psr4[current_step],    sr4);
        trip(psr3[current_step],    sr3);
        trip(psr2[current_step],    sr2);
        trip(psr1[current_step],    sr1);
        trip(pmezf[current_step],   mezf);
        trip(pmezn[current_step],   mezn);
        
        ++current_step;    // move to the next step for the next quantum
      }

      else { // current_step < steps
        Serial.print("pattern done ");
        Serial.print(current_step);
        Serial.print(" - ");
        Serial.println(steps);
        trip_off();
        running_serial = 0;
        running_button = 0;
      }
      
      last_tick = now;   // remember when the last quantum happened
    } // now - last_tick > quantum
  } // running_serial || running_button
}


void setup_pattern()
{
  switch (pattern) {

  case 1:
    pshelln = p1shelln;
    pshellf = p1shellf;
    psl1 = p1sl1;
    psl2 = p1sl2;
    psl3 = p1sl3;
    psl4 = p1sl4;
    prenl = p1renl;
    prenr = p1renr;
    psr4 = p1sr4;
    psr3 = p1sr3;
    psr2 = p1sr2;
    psr1 = p1sr1;
    pmezf = p1mezf;
    pmezn = p1mezn;
    steps = steps1;
    break;

  case 2:
    pshelln = p2shelln;
    pshellf = p2shellf;
    psl1 = p2sl1;
    psl2 = p2sl2;
    psl3 = p2sl3;
    psl4 = p2sl4;
    prenl = p2renl;
    prenr = p2renr;
    psr4 = p2sr4;
    psr3 = p2sr3;
    psr2 = p2sr2;
    psr1 = p2sr1;
    pmezf = p2mezf;
    pmezn = p2mezn;
    steps = steps2;
    break;

  case 3:
    pshelln = p3shelln;
    pshellf = p3shellf;
    psl1 = p3sl1;
    psl2 = p3sl2;
    psl3 = p3sl3;
    psl4 = p3sl4;
    prenl = p3renl;
    prenr = p3renr;
    psr4 = p3sr4;
    psr3 = p3sr3;
    psr2 = p3sr2;
    psr1 = p3sr1;
    pmezf = p3mezf;
    pmezn = p3mezn;
    steps = steps3;
    break;

  case 4:
    pshelln = p4shelln;
    pshellf = p4shellf;
    psl1 = p4sl1;
    psl2 = p4sl2;
    psl3 = p4sl3;
    psl4 = p4sl4;
    prenl = p4renl;
    prenr = p4renr;
    psr4 = p4sr4;
    psr3 = p4sr3;
    psr2 = p4sr2;
    psr1 = p4sr1;
    pmezf = p4mezf;
    pmezn = p4mezn;
    steps = steps4;
    break;

  case 5:
    pshelln = p5shelln;
    pshellf = p5shellf;
    psl1 = p5sl1;
    psl2 = p5sl2;
    psl3 = p5sl3;
    psl4 = p5sl4;
    prenl = p5renl;
    prenr = p5renr;
    psr4 = p5sr4;
    psr3 = p5sr3;
    psr2 = p5sr2;
    psr1 = p5sr1;
    pmezf = p5mezf;
    pmezn = p5mezn;
    steps = steps5;
    break;

  case 6:
    pshelln = p6shelln;
    pshellf = p6shellf;
    psl1 = p6sl1;
    psl2 = p6sl2;
    psl3 = p6sl3;
    psl4 = p6sl4;
    prenl = p6renl;
    prenr = p6renr;
    psr4 = p6sr4;
    psr3 = p6sr3;
    psr2 = p6sr2;
    psr1 = p6sr1;
    pmezf = p6mezf;
    pmezn = p6mezn;
    steps = steps6;
    break;
  }

  show_pattern();
}


void check_serial()
{
  int cmd = 0;

  if (Serial.available()) {
    cmd = Serial.read();
    switch (cmd) {

    case '0':
      Serial.println("paused");
      steps = 0;
      pattern = 0;
      running_serial = 0;
      break;

    case '1':
      Serial.println("running pattern 1");
      pattern = 1;
      break;

    case '2':
      Serial.println("running pattern 2");
      pattern = 2;
      break;

    case '3':
      Serial.println("running pattern 3");
      pattern = 3;
      break;

    case '4':
      Serial.println("running pattern 4");
      pattern = 4;
      break;

    case '5':
      Serial.println("running pattern 5");
      pattern = 5;
      break;

    case '6':
      Serial.println("running pattern 6");
      pattern = 6;
      break;
    }

    if (pattern > 0) {
      setup_pattern();
      running_serial = 1;
    }

  }
}


int check_buttons()
{
  if (digitalRead(p1pin)) {
    if (running_button != 1) {
      Serial.println("button 1");
      pattern = 1;
      running_button = 1;
      setup_pattern();
    }
  }

  if (digitalRead(p2pin)) {
    if (running_button != 2) {
      Serial.println("button 2");
      pattern = 2;
      running_button = 2;
      setup_pattern();
    }
  }

  if (digitalRead(p3pin)) {
    if (running_button != 3) {
      Serial.println("button 3");
      pattern = 3;
      running_button = 3;
      setup_pattern();
    }
  }

  if (digitalRead(p4pin)) {
    if (running_button != 4) {
      Serial.println("button 4");
      pattern = 4;
      running_button = 4;
      setup_pattern();
    }
  }

  if (digitalRead(p5pin)) {
    if (running_button != 5) {
      Serial.println("button 5");
      pattern = 5;
      running_button = 5;
      setup_pattern();
    }
  }

  if (digitalRead(p6pin)) {
    if (running_button != 6) {
      Serial.println("button 6");
      pattern = 6;
      running_button = 6;
      setup_pattern();
    }
  }

  if (running_button) {
    Serial.println("button up");
    pattern = 0;
    running_button = 0;
    current_step = 0;
    trip_off();
  }
}


void loop()
{
  check_serial();
  check_buttons();
  run_pattern();
}
