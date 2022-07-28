import 'dart:io';
import 'dart:math';
import 'package:emojis/emojis.dart';

Random random = Random();

// SpaceShip Superclass
abstract class SpaceShip {
  double health = 100;
  double firePower = 10;

  void hit();
  void isDestroyed();
}

// Armored SpaceShip Class
class ArmoredSpaceShip extends SpaceShip {
  double maxArmorPower = 0.9;
  late double randomArmorPower = random.nextDouble() * (1 - maxArmorPower);

  @override
  void hit() {
    double damage = firePower - randomArmorPower;
    health = health - damage;
  }

  @override
  void isDestroyed() {
    print(
        "\x1B[31mSpaceship 1 defeated! Armored Spaceship has no chance against HighSpeed SpaceShip.\x1B[0m");
  }
}

// HighSpeed SpaceShip Class
class HighSpeedSpaceShip extends SpaceShip {
  @override
  void hit() {
    bool dodging =
        random.nextBool(); // need to put inside so that it will run everytime

    if (dodging == false) {
      health = health - firePower;
    } else {
      health = health + 0;
    }
  }

  @override
  void isDestroyed() {
    print(
        "\x1B[31mSpaceship 2 is defeated! High Speed Spaceship is fast but has no chance against Armored SpaceShip.\x1B[0m");
  }
}

class BattleField {
  void StartBattle(SpaceShip sp1, SpaceShip sp2) {
    do {
      sp1.hit();
        print("\x1B[36mSpaceship 1 is getting hit.\x1B[0m");
        print("\x1B[36mSpaceship 1 health: ${sp1.health} HP.\x1B[0m\n"); // print out hp status
        sleep(Duration(seconds: 1));
      sp2.hit();
        print("\x1B[33mSpaceship 2 is getting hit.\x1B[0m");
        print("\x1B[33mSpaceship 2 health: ${sp2.health} HP.\x1B[0m\n"); // print out hp status
        sleep(Duration(seconds: 1));
    } while (sp1.health > 0 && sp2.health > 0);

      // if either spaceship die, it will print out the recall destroyed message
      if (sp1.health <= 0) {
        ArmoredSpaceShip().isDestroyed();
      } else if (sp2.health <= 0) {
        HighSpeedSpaceShip().isDestroyed();
      }
  }
}

void main(List<String> args) {
  SpaceShip sp1 = ArmoredSpaceShip();
  SpaceShip sp2 = HighSpeedSpaceShip();
  BattleField().StartBattle(sp1, sp2);
}
