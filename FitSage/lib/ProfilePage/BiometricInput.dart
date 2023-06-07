import "dart:core";

class BiometricInput {
  // Attributes
  double height;
  double weight;
  int age;
  String gender;
  String goal;

  // CONSTRUCTORS
  BiometricInput({
    // this is to create BiometricInput objects and use the functions without needing parameters
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    this.goal = '',
  });

  // GETTERS
  double getWeight() {
    return weight;
  }

  double getHeight() {
    return height;
  }

  int getAge() {
    return age;
  }

  String getGender() {
    return gender;
  }

  String getGoal() {
    return goal;
  }

  //BMI and BFP Compositions
  String bmiType(double BMI) {
    if (BMI < 18.5) {
      return "Underweight";
    } else if (BMI >= 18.5 && BMI < 25) {
      return "Normal";
    } else if (BMI >= 25 && BMI < 30) {
      return "Overweight";
    } else if (BMI >= 30) {
      return "Obese";
    } else {
      return "This shouldn't happen.";
    }
  }

  String bfpType(double BFP) {
    if (gender.toLowerCase() == ("male")) {
      if (((BFP < 8) && (age >= 18 && age <= 39)) ||
          ((BFP < 11) && (age >= 40 && age <= 59)) ||
          ((BFP < 13) && (age >= 60 && age <= 80))) {
        return "Underfat";
      } else if (((BFP >= 8 && BFP < 20) && (age >= 18 && age <= 39)) ||
          ((BFP >= 11 && BFP < 22) && (age >= 40 && age <= 59)) ||
          ((BFP >= 13 && BFP < 25) && (age >= 60 && age <= 80))) {
        return "Ideal";
      } else if (((BFP >= 20 && BFP <= 25) && (age >= 18 && age <= 39)) ||
          ((BFP >= 22 && BFP <= 28) && (age >= 40 && age <= 59)) ||
          ((BFP >= 25 && BFP <= 30) && (age >= 60 && age <= 80))) {
        return "Overfat";
      } else if (((BFP > 25) && (age >= 18 && age <= 39)) ||
          ((BFP > 28) && (age >= 40 && age <= 59)) ||
          ((BFP > 30) && (age >= 60 && age <= 80))) {
        return "Obese";
      } else {
        return "This shouldn't happen";
      }
    } else if (gender.toLowerCase() == ("female")) {
      if (((BFP < 21) && (age >= 18 && age <= 39)) ||
          ((BFP < 23) && (age >= 40 && age <= 59)) ||
          ((BFP < 24) && (age >= 60 && age <= 80))) {
        return "Underfat";
      } else if (((BFP >= 21 && BFP < 34) && (age >= 18 && age <= 39)) ||
          ((BFP >= 23 && BFP < 35) && (age >= 40 && age <= 59)) ||
          ((BFP >= 24 && BFP < 36) && (age >= 60 && age <= 80))) {
        return "Ideal";
      } else if (((BFP >= 34 && BFP <= 39) && (age >= 18 && age <= 39)) ||
          ((BFP >= 35 && BFP <= 40) && (age >= 40 && age <= 59)) ||
          ((BFP >= 36 && BFP <= 42) && (age >= 60 && age <= 80))) {
        return "Overfat";
      } else if (((BFP > 39) && (age >= 18 && age <= 39)) ||
          ((BFP > 40) && (age >= 40 && age <= 59)) ||
          ((BFP > 42) && (age >= 60 && age <= 80))) {
        return "Obese";
      } else {
        return "This shouldn't happen";
      }
    } else {
      return "This shouldn't happen";
    }
  }

  String bodyComposition(double BMI, double BFP) {
    return "${bmiType(BMI)}-${bfpType(BFP)}";
  }

  String bodyType(double BMI, double BFP) {
    String type = bodyComposition(BMI, BFP);
    if (type == ("Underweight-Underfat") ||
        type == ("Underweight-Ideal") ||
        type == ("Healthy-Underfat")) {
      return "Ectomorph";
    } else if (type == ("Overweight-Overfat") ||
        type == ("Overweight-Ideal") ||
        type == ("Obese-Overfat") ||
        type == ("Obese-Obese")) {
      return "Endomorph";
    } else if (type == ("Normal-Ideal")) {
      return "Mesomorph";
    } else {
      return "";
    }
  }
}
