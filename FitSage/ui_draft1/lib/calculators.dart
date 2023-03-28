// ignore_for_file: non_constant_identifier_names

import 'dart:math';

class Calculators {
  // BMI CALCULATOR
  double calcBMI(double weight, double height) {
    return ((703 * (weight / pow(height, 2))));
  }

  // BODY-FAT PERCENTAGE
  double calcBFP(String gender, int age, double BMI) {
    if (gender.toLowerCase() == ("male")) {
      return (((1.20 * BMI) + (0.23 * age) - 16.2));
    } else if (gender.toLowerCase() == ("female")) {
      return (((1.20 * BMI) + (0.23 * age) - 5.4));
    } else {
      return 0;
    }
  }
}
