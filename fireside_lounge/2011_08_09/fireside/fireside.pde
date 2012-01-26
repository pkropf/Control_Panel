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


#include <avr/pgmspace.h>

const int quantum = 62;

unsigned long last_tick = 0;
int current_step = 0;
int steps = 0;

char csl1[256];
char csl2[256];
char csl3[256];
char csl4[256];
char csr4[256];
char csr3[256];
char csr2[256];
char csr1[256];


const int sl1    = 22;  // stage left, poofer 1 (sl1)
const int sl2    = 24;  // stage left, poofer 2 (sl2)
const int sl3    = 25;  // stage left, poofer 3 (sl3)
const int sl4    = 26;  // stage left, poofer 4 (sl4)
const int sr4    = 27;  // stage right, poofer 4 (sr4)
const int sr3    = 28;  // stage right, poofer 3 (sr3)
const int sr2    = 29;  // stage right, poofer 2 (sr2)
const int sr1    = 23;  // stage right, poofer 1 (sr1)


// seed pattern that does nothing
//const int steps0 = 99;
//                                         1         2         3         4         5         6         7         8         9         
//                                123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                                1       2       3       4       5       6       7       8       9       0       1       2       3
//                                123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123
//PROGMEM prog_char p0sl1[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sl2[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sl3[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sl4[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sr4[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sr3[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sr2[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//PROGMEM prog_char p0sr1[]    = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//
//PROGMEM char *p0[] = {
//  p0sl1,
//  p0sl2,
//  p0sl3,
//  p0sl4,
//  p0sr4,
//  p0sr3,
//  p0sr2,
//  p0sr1,
//};


const int steps1 = 5;
//                              12345
PROGMEM prog_char p1sl1[]    = "11110"; 
PROGMEM prog_char p1sl2[]    = "11110"; 
PROGMEM prog_char p1sl3[]    = "11110"; 
PROGMEM prog_char p1sl4[]    = "11110"; 
PROGMEM prog_char p1sr4[]    = "11110"; 
PROGMEM prog_char p1sr3[]    = "11110"; 
PROGMEM prog_char p1sr2[]    = "11110"; 
PROGMEM prog_char p1sr1[]    = "11110"; 

PROGMEM char *p1[] = {
  p1sl1,
  p1sl2,
  p1sl3,
  p1sl4,
  p1sr4,
  p1sr3,
  p1sr2,
  p1sr1,
};


const int steps2 = 17;
//                                       1         2         3
//                              123456789012345678901234567890123
PROGMEM prog_char p2sl1[]    = "11000000000000000"; 
PROGMEM prog_char p2sl2[]    = "00110000000000000"; 
PROGMEM prog_char p2sl3[]    = "00001100000000000"; 
PROGMEM prog_char p2sl4[]    = "00000011000000000"; 
PROGMEM prog_char p2sr4[]    = "00000000110000000"; 
PROGMEM prog_char p2sr3[]    = "00000000001100000"; 
PROGMEM prog_char p2sr2[]    = "00000000000011000"; 
PROGMEM prog_char p2sr1[]    = "00000000000000110"; 

PROGMEM char *p2[] = {
  p2sl1,
  p2sl2,
  p2sl3,
  p2sl4,
  p2sr4,
  p2sr3,
  p2sr2,
  p2sr1,
};


const int steps3 = 74;
//                                       1         2         3         4         5         6         7         8         9         10        11
//                              123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
PROGMEM prog_char p3sl1[]    = "10000000000000000000000000000000000010000010000010000010000010000010000110";
PROGMEM prog_char p3sl2[]    = "10000000000000000000000000000000000010000010000010000010000010000010000110";
PROGMEM prog_char p3sl3[]    = "00000010000000000000000000010000000000000000000000000000000010000010000110";
PROGMEM prog_char p3sl4[]    = "00000010000000000000010000010000000000000000000000000000000010000010000110";
PROGMEM prog_char p3sr4[]    = "00000000000000010000010000010000000000000000000000000000000010000010000110";
PROGMEM prog_char p3sr3[]    = "00000000000000010000000000010000000000000000000010000010000010000010000110";
PROGMEM prog_char p3sr2[]    = "00000000010000000000000000000000000010000010000010000010000010000010000110";
PROGMEM prog_char p3sr1[]    = "00000000010000000000000000000000000010000010000010000010000010000010000110";

PROGMEM char *p3[] = {
  p3sl1,
  p3sl2,
  p3sl3,
  p3sl4,
  p3sr4,
  p3sr3,
  p3sr2,
  p3sr1,
};


// sequence stage left to stage right to mez to rental to shell
const int steps4 = 97;
//                                       1         2         3         4         5         6         7         8         9         10        12        13        14        15
//                              123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                              1       2       3       4       5       6       7       8       9       10      11      12      13      14      15      16      17      18
//                              123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678
PROGMEM prog_char p4sl1[]    = "11000000000000000000000000000011001111000000000000000000000001111111111111110";
PROGMEM prog_char p4sl2[]    = "00000110000000000000000000011000001111000000000000000000000001111111111111110";
PROGMEM prog_char p4sl3[]    = "00000000000110000000000011000000001111000000000000000000000001111111111111110";
PROGMEM prog_char p4sl4[]    = "00000000000000000110011000000000001111000000000000000000000001111111111111110";
PROGMEM prog_char p4sr4[]    = "00000000000000000000000000000000000000000000111100000000000001111111111111110";
PROGMEM prog_char p4sr3[]    = "00000000000000000000000000000000000000000000111100000000000001111111111111110";
PROGMEM prog_char p4sr2[]    = "00000000000000000000000000000000000000000000111100000000000001111111111111110";
PROGMEM prog_char p4sr1[]    = "00000000000000000000000000000000000000000000111100000000000001111111111111110";


PROGMEM char *p4[] = {
  p4sl1,
  p4sl2,
  p4sl3,
  p4sl4,
  p4sr4,
  p4sr3,
  p4sr2,
  p4sr1,
};


// sequence shell to rental to mez to stage right to stage left
const int steps5 = 17;
//                                       1         2         3
//                              12345678901234567890123456789012
PROGMEM prog_char p5sl1[]    = "00000000000000110";
PROGMEM prog_char p5sl2[]    = "00000000000011000";
PROGMEM prog_char p5sl3[]    = "00000000001100000";
PROGMEM prog_char p5sl4[]    = "00000000110000000";
PROGMEM prog_char p5sr4[]    = "00000011000000000";
PROGMEM prog_char p5sr3[]    = "00001100000000000";
PROGMEM prog_char p5sr2[]    = "00110000000000000";
PROGMEM prog_char p5sr1[]    = "11000000000000000";

PROGMEM char *p5[] = {
  p5sl1,
  p5sl2,
  p5sl3,
  p5sl4,
  p5sr4,
  p5sr3,
  p5sr2,
  p5sr1,
};


const int steps6 = 17;
//                                       1         2         3
//                              12345678901234567890123456789012
PROGMEM prog_char p6sl1[]    = "11000000000000000"; 
PROGMEM prog_char p6sl2[]    = "00110000000000000"; 
PROGMEM prog_char p6sl3[]    = "00001100000000000"; 
PROGMEM prog_char p6sl4[]    = "00000011000000000"; 
PROGMEM prog_char p6sr4[]    = "00000000110000000"; 
PROGMEM prog_char p6sr3[]    = "00000000001100000"; 
PROGMEM prog_char p6sr2[]    = "00000000000011000"; 
PROGMEM prog_char p6sr1[]    = "00000000000000110"; 

PROGMEM char *p6[] = {
  p6sl1,
  p6sl2,
  p6sl3,
  p6sl4,
  p6sr4,
  p6sr3,
  p6sr2,
  p6sr1,
};


const int steps7 = 9;
//                                       1         2         3         4         5
//                              12345678901234567890123456789012345678901234567890
//                              11111111122222222333333334444444455555555666666667
PROGMEM prog_char p7sl1[]    = "101010100";
PROGMEM prog_char p7sl2[]    = "001010100";
PROGMEM prog_char p7sl3[]    = "000010100";
PROGMEM prog_char p7sl4[]    = "000000100";
PROGMEM prog_char p7sr4[]    = "000000100";
PROGMEM prog_char p7sr3[]    = "000010100";
PROGMEM prog_char p7sr2[]    = "001010100";
PROGMEM prog_char p7sr1[]    = "101010100";

PROGMEM char *p7[] = {
  p7sl1,
  p7sl2,
  p7sl3,
  p7sl4,
  p7sr4,
  p7sr3,
  p7sr2,
  p7sr1,
};


const int steps8 = 70;
//                                       1         2         3         4         5         6         7         8         9
//                              1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
//                              1       2       3       4       5       6       7       8       9       0       1       2
//                              1234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456
PROGMEM prog_char p8sl1[]    = "0000000000100010000000000010000000000000100000000000000000100000001000";
PROGMEM prog_char p8sl2[]    = "0000000000100000100000001000000000000000001000000000000000100000001000";
PROGMEM prog_char p8sl3[]    = "0000001000000000001000100000000000000000000010000000000000100000001000";
PROGMEM prog_char p8sl4[]    = "0010000000000000000010000000000000000000000000100000000000100000001000";
PROGMEM prog_char p8sr4[]    = "0010000000000000000010000000000000000000000000100000000000100000001000";
PROGMEM prog_char p8sr3[]    = "0000001000000000001000100000000000000000000010000000000000100000001000";
PROGMEM prog_char p8sr2[]    = "0000000000100000100000001000000000000000001000000000000000100000001000";
PROGMEM prog_char p8sr1[]    = "0000000000100010000000000010000000000000100000000000000000100000001000";

PROGMEM char *p8[] = {
  p8sl1,
  p8sl2,
  p8sl3,
  p8sl4,
  p8sr4,
  p8sr3,
  p8sr2,
  p8sr1,
};


const int steps9 = 88;
//                                       1         2         3         4         5         6         7         8
//                              1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
//                              1       2       3       4       5       6       7       8       9       0       1       
//                              1234567812345678123456781234567812345678123456781234567812345678123456781234567812345678
PROGMEM prog_char p9sl1[]    = "1000100010001000000000000000100000000000000000100000000000000000001000000000000000001000";
PROGMEM prog_char p9sl2[]    = "0000100010001000000000000000100010000000000010001000000000000000000010000000000010001000";
PROGMEM prog_char p9sl3[]    = "0000000010001000000000000000000010001000001000000010000000000000000000100000100010001000";
PROGMEM prog_char p9sl4[]    = "0000000000001000000000000000000000001000100000000000100000000000000000001000100010001000";
PROGMEM prog_char p9sr4[]    = "0000000000001000000000000000000000001000100000000000100000000000000000001000100010001000";
PROGMEM prog_char p9sr3[]    = "0000000010001000000000000000000010001000001000000010000000000000000000100000100010001000";
PROGMEM prog_char p9sr2[]    = "0000100010001000000000000000100010000000000010001000000000000000000010000000000010001000";
PROGMEM prog_char p9sr1[]    = "1000100010001000000000000000100000000000000000100000000000000000001000000000000000001000";

PROGMEM char *p9[] = {
  p9sl1,
  p9sl2,
  p9sl3,
  p9sl4,
  p9sr4,
  p9sr3,
  p9sr2,
  p9sr1,
};


const int stepsa = 23;
//                                       1         2
//                              12345a78901234567890123
PROGMEM prog_char pasl1[]    = "11000011000000000000010"; 
PROGMEM prog_char pasl2[]    = "11000011000000000000010"; 
PROGMEM prog_char pasl3[]    = "11000011000000000000010"; 
PROGMEM prog_char pasl4[]    = "11000011000000000000010"; 
PROGMEM prog_char pasr4[]    = "11000011000000000000010"; 
PROGMEM prog_char pasr3[]    = "11000011000000000000010"; 
PROGMEM prog_char pasr2[]    = "11000011000000000000010"; 
PROGMEM prog_char pasr1[]    = "11000011000000000000010"; 

PROGMEM char *pa[] = {
  pasl1,
  pasl2,
  pasl3,
  pasl4,
  pasr4,
  pasr3,
  pasr2,
  pasr1,
};


const int stepsb = 137;
//                                       1         2         3         4         5         6         7         8         9         10        11        12        13      
//                              12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
PROGMEM prog_char pbsl1[]    = "10000000000000000000000000000000000010000000000000000000000000000000000010000010000010000010000000010000010000010000010000010000010000110";
PROGMEM prog_char pbsl2[]    = "10000000000000000000000000000000000010000000000000000000000000000000000010000010000010000010000000010000010000010000010000010000010000110";
PROGMEM prog_char pbsl3[]    = "00000010000000000000000000010000000000000010000000000000000000010000000000000000000000000000000000000000000000000000000000010000010000110";
PROGMEM prog_char pbsl4[]    = "00000010000000000000010000010000000000000010000000000000010000010000000000000000000000000000000000000000000000000000000000010000010000110";
PROGMEM prog_char pbsr4[]    = "00000000000000010000010000010000000000000000000000010000010000010000000000000000000000000000000000000000000000000000000000010000010000110";
PROGMEM prog_char pbsr3[]    = "00000000000000010000000000010000000000000000000000010000000000010000000000000000000010000010000000000000000000010000010000010000010000110";
PROGMEM prog_char pbsr2[]    = "00000000010000000000000000000000000000000000010000000000000000000000000010000010000010000010000000010000010000010000010000010000010000110";
PROGMEM prog_char pbsr1[]    = "00000000010000000000000000000000000000000000010000000000000000000000000010000010000010000010000000010000010000010000010000010000010000110";

PROGMEM char *pb[] = {
  pbsl1,
  pbsl2,
  pbsl3,
  pbsl4,
  pbsr4,
  pbsr3,
  pbsr2,
  pbsr1,
};


const int stepsc = 3;
//                          
//                              12345
PROGMEM prog_char pcsl1[]    = "11000"; 
PROGMEM prog_char pcsl2[]    = "11000"; 
PROGMEM prog_char pcsl3[]    = "11000"; 
PROGMEM prog_char pcsl4[]    = "11000"; 
PROGMEM prog_char pcsr4[]    = "11000"; 
PROGMEM prog_char pcsr3[]    = "11000"; 
PROGMEM prog_char pcsr2[]    = "11000"; 
PROGMEM prog_char pcsr1[]    = "11000"; 

PROGMEM char *pc[] = {
  pcsl1,
  pcsl2,
  pcsl3,
  pcsl4,
  pcsr4,
  pcsr3,
  pcsr2,
  pcsr1,
};


void setup()
{
  Serial.begin(57600);

  last_tick = millis();
  pinMode(sl1, OUTPUT);
  pinMode(sl2, OUTPUT);
  pinMode(sl3, OUTPUT);
  pinMode(sl4, OUTPUT);
  pinMode(sr4, OUTPUT);
  pinMode(sr3, OUTPUT);
  pinMode(sr2, OUTPUT);
  pinMode(sr1, OUTPUT);
}

void show_pattern()
{
  int i;

  Serial.println(steps);
  Serial.println(csl1);
  Serial.println(csl2);
  Serial.println(csl3);
  Serial.println(csl4);
  Serial.println(csr4);
  Serial.println(csr3);
  Serial.println(csr2);
  Serial.println(csr1);
  Serial.println("done");
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


void run_pattern()
{
  int i;
  unsigned long now = millis();

  if(now - last_tick > quantum) {    // has quantum time passed?
    if (current_step < steps) {     // are there more steps in the pattern?

      trip(csl1[current_step],    sl1);
      trip(csl2[current_step],    sl2);
      trip(csl3[current_step],    sl3);
      trip(csl4[current_step],    sl4);
      trip(csr4[current_step],    sr4);
      trip(csr3[current_step],    sr3);
      trip(csr2[current_step],    sr2);
      trip(csr1[current_step],    sr1);

      ++current_step;    // move to the next step for the next quantum
    }
    last_tick = now;   // remember when the last quantum happened
  }
}


void loop()
{
  int cmd = 0;

  if (Serial.available()) {
    cmd = Serial.read();
    switch (cmd) {

    case '0':
      Serial.println("paused");
      steps = 0;
      current_step = 0;
      break;

    case '1':
      Serial.println("running pattern 1");

      //strcpy_P(buffer, (char*)pgm_read_word(&(string_table[i]))); // Necessary casts and dereferencing, just copy. 

      strcpy_P(csl1,    (char *)pgm_read_word(&(p1[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p1[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p1[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p1[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p1[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p1[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p1[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p1[7])));
      steps = steps1;
      current_step = 0;
      show_pattern();
      break;

    case '2':
      Serial.println("running pattern 2");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p2[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p2[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p2[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p2[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p2[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p2[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p2[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p2[7])));
      steps = steps2;
      current_step = 0;
      show_pattern();
      break;

    case '3':
      Serial.println("running pattern 3");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p3[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p3[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p3[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p3[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p3[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p3[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p3[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p3[7])));
      steps = steps3;
      current_step = 0;
      show_pattern();
      break;

    case '4':
      Serial.println("running pattern 4");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p4[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p4[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p4[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p4[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p4[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p4[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p4[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p4[7])));
      steps = steps4;
      current_step = 0;
      show_pattern();
      break;

    case '5':
      Serial.println("running pattern 5");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p5[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p5[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p5[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p5[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p5[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p5[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p5[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p5[7])));
      steps = steps5;
      current_step = 0;
      show_pattern();
      break;

    case '6':
      Serial.println("running pattern 6");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p6[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p6[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p6[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p6[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p6[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p6[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p6[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p6[7])));
      steps = steps6;
      current_step = 0;
      show_pattern();
      break;

    case '7':
      Serial.println("running pattern 7");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p7[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p7[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p7[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p7[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p7[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p7[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p7[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p7[7])));
      steps = steps7;
      current_step = 0;
      show_pattern();
      break;

    case '8':
      Serial.println("running pattern 8");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p8[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p8[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p8[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p8[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p8[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p8[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p8[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p8[7])));
      steps = steps8;
      current_step = 0;
      show_pattern();
      break;

    case '9':
      Serial.println("running pattern 9");
      strcpy_P(csl1,    (char *)pgm_read_word(&(p9[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(p9[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(p9[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(p9[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(p9[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(p9[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(p9[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(p9[7])));
      steps = steps9;
      current_step = 0;
      show_pattern();
      break;

    case 'a':
      Serial.println("running pattern a");
      strcpy_P(csl1,    (char *)pgm_read_word(&(pa[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(pa[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(pa[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(pa[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(pa[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(pa[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(pa[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(pa[7])));
      steps = stepsa;
      current_step = 0;
      show_pattern();
      break;

    case 'b':
      Serial.println("running pattern b");
      strcpy_P(csl1,    (char *)pgm_read_word(&(pb[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(pb[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(pb[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(pb[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(pb[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(pb[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(pb[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(pb[7])));
      steps = stepsb;
      current_step = 0;
      show_pattern();
      break;

    case 'c':
      Serial.println("running pattern c");
      strcpy_P(csl1,    (char *)pgm_read_word(&(pc[0])));
      strcpy_P(csl2,    (char *)pgm_read_word(&(pc[1])));
      strcpy_P(csl3,    (char *)pgm_read_word(&(pc[2])));
      strcpy_P(csl4,    (char *)pgm_read_word(&(pc[3])));
      strcpy_P(csr4,    (char *)pgm_read_word(&(pc[4])));
      strcpy_P(csr3,    (char *)pgm_read_word(&(pc[5])));
      strcpy_P(csr2,    (char *)pgm_read_word(&(pc[6])));
      strcpy_P(csr1,    (char *)pgm_read_word(&(pc[7])));
      steps = stepsc;
      current_step = 0;
      show_pattern();
      break;

    }

  }

  run_pattern();
}
