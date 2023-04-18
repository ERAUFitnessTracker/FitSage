import 'DatabaseHelper.dart';
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

  String calorieCalculator() {
    double BMR = 0;
    //get calories and info from database
    int totalCalories = DatabaseHelper.instance.getCaloriesForDay(
        DateTime.now().day, DateTime.now().month, DateTime.now().year) as int;
    String goal = DatabaseHelper.instance.getUserInfo('goal') as String;
    String gender = DatabaseHelper.instance.getUserInfo('gender') as String;
    int height = DatabaseHelper.instance.getUserInfo('height') as int;
    int weight = DatabaseHelper.instance.getUserInfo('weight') as int;
    int age = DatabaseHelper.instance.getUserInfo('age') as int;

    // calculates per input, add daily timer to reset totalCalories
    switch (goal) {
      case "Lose Weight":
        if (gender == "Male") {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) +
              5);
          if (BMR * .9 > totalCalories) {
            return "Great job! You met your goal, and your calorie deficit was ${BMR - totalCalories} calories!";
          } else {
            return """Sadly, you consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
          This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
          }
        } else {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) -
              161);
          if (BMR * .9 > totalCalories) {
            return "Great job! You met your goal, and your calorie deficit was  ${BMR - totalCalories} calories!";
          } else {
            return """Sadly, you consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
          This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
          }
        }

      case "Gain Weight":
        if (gender == "Male") {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight for men
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) +
              5);
          if (BMR * 1.1 < totalCalories) {
            return "Great job! You met your goal, and your calories above maintaining was ${totalCalories - BMR} calories!";
          } else {
            return """Sadly, you consumed ${BMR - totalCalories} less calories than you should have to meet your goal.
          This means you were ${(totalCalories / BMR) * 100}% off of your goal""";
          }
        } else {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) -
              161);
          if (BMR * 1.1 < totalCalories) {
            return "Great job! You met your goal, and your calories above maintaining was ${totalCalories - BMR} calories!";
          } else {
            return """Sadly, you consumed ${BMR - totalCalories}less calories than you should have to meet your goal.
          This means you were ${(totalCalories / BMR) * 100}% off of your goal""";
          }
        }

      case "Maintain Weight":
        if (gender == "Male") {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) +
              5);
          if (BMR / totalCalories <= .03) {
            // percentage is 3% off goal that is considered acceptable
            return "Great job! You met your goal, and consumed $totalCalories calories today";
          } else {
            if (0 < (BMR - totalCalories)) {
              return """Sadly, you consumed ${BMR - totalCalories} less calories than you should have to meet your goal.
            This means you were ${(totalCalories / BMR) * 100}% off of your goal\r\n""";
            } else {
              return """Sadly, you consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
            This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
            }
          }
        } else {
          // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
          BMR = ((10 * weight * .45359237) +
              (6.25 * height * 2.54) -
              (5 * age) -
              161);
          if (BMR / totalCalories <= .03) {
            // percentage is 3% off goal that is considered acceptable
            return "Great job! You met your goal, and consumed $totalCalories calories today";
          } else {
            if (0 < (BMR - totalCalories)) {
              return """Sadly, you consumed ${BMR - totalCalories} less calories than you should have to meet your goal.
            This means you were ${(totalCalories / BMR) * 100}% off of your goal""";
            } else {
              return """Sadly, you consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
            This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
            }
          }
        }
      default:
        return """this isn't supposed to print. It's possible the database is empty.
        goal: $goal""";
    }
  }
}
