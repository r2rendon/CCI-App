#include <Servo.h>

// Pines de los LEDs
const int ledDormitorio1 = 6;
const int ledDormitorio2 = 7;
const int ledBano = 8;
const int ledCocina = 9;

// Pines del sensor ultrasónico
const int trigPin = 10;
const int echoPin = 11;

// PIR para el servomotor
const int pirPin = 2;

// Servomotor
const int servoPin = 12;
Servo miServo;

void setup() {
  pinMode(ledDormitorio1, OUTPUT);
  pinMode(ledDormitorio2, OUTPUT);
  pinMode(ledBano, OUTPUT);
  pinMode(ledCocina, OUTPUT);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  pinMode(pirPin, INPUT);

  miServo.attach(servoPin);
  miServo.write(0); // Posición inicial (puerta cerrada)

  Serial.begin(9600);
}

void loop() {
  // Medir distancia con el sensor ultrasónico
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duracion = pulseIn(echoPin, HIGH);
  int distancia = duracion * 0.034 / 2; // cm

  Serial.print("Distancia: ");
  Serial.println(distancia);

  // Encender LEDs según la distancia (ajustado desde 260 cm)
  if (distancia > 200 && distancia <= 260) {
    // 201–260 cm: solo LED 1
    digitalWrite(ledDormitorio1, HIGH);
    digitalWrite(ledDormitorio2, LOW);`
    digitalWrite(ledBano, LOW);
    digitalWrite(ledCocina, LOW);
  } else if (distancia > 140 && distancia <= 200) {
    // 141–200 cm: LED 1 y 2
    digitalWrite(ledDormitorio1, HIGH);
    digitalWrite(ledDormitorio2, HIGH);
    digitalWrite(ledBano, LOW);
    digitalWrite(ledCocina, LOW);
  } else if (distancia > 80 && distancia <= 140) {
    // 81–140 cm: LED 1, 2 y 3
    digitalWrite(ledDormitorio1, HIGH);
    digitalWrite(ledDormitorio2, HIGH);
    digitalWrite(ledBano, HIGH);
    digitalWrite(ledCocina, LOW);
  } else if (distancia <= 80) {
    // 0–80 cm: todos encendidos
    digitalWrite(ledDormitorio1, HIGH);
    digitalWrite(ledDormitorio2, HIGH);
    digitalWrite(ledBano, HIGH);
    digitalWrite(ledCocina, HIGH);
  } else {
    // Más de 260 cm: todos apagados
    digitalWrite(ledDormitorio1, LOW);
    digitalWrite(ledDormitorio2, LOW);
    digitalWrite(ledBano, LOW);
    digitalWrite(ledCocina, LOW);
  }

  // --- Control de servomotor con PIR ---
  int estadoPIR = digitalRead(pirPin);
  if (estadoPIR == HIGH) {
    miServo.write(90); // Abrir puerta
  } else {
    miServo.write(0); // Cerrar puerta
  }

  delay(200);
} 