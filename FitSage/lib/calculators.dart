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

  double calcBMR(double weight, double height, int age, String gender) {
    double BMR;
    if (gender == 'Male') {
      BMR =
          ((10 * weight * .45359237) + (6.25 * height * 2.54) - (5 * age) + 5);
    } else {
      BMR = ((10 * weight * .45359237) +
          (6.25 * height * 2.54) -
          (5 * age) -
          161);
    }
    return BMR;
  }

  double calcGoalRange(double BMR, String goal) {
    switch (goal.toLowerCase()) {
      case 'lose weight':
        return BMR * 0.9;
      case 'maintain weight':
        return BMR;
      case 'gain weight':
        return BMR * 1.1;
      default:
        return 0;
    }
  }

  Future<String> calorieCalculator() async {
    double BMR;
    //get calories and info from database
    int totalCalories = await DatabaseHelper.instance.getCaloriesForDay(
        DateTime.now().day, DateTime.now().month, DateTime.now().year);
    String goal = await DatabaseHelper.instance.getUserInfo('goal');
    String gender = await DatabaseHelper.instance.getUserInfo('gender');

    double height =
        double.parse(await DatabaseHelper.instance.getUserInfo('height'));
    double weight =
        double.parse(await DatabaseHelper.instance.getUserInfo('weight'));
    int age = int.parse(await DatabaseHelper.instance.getUserInfo('age'));
    BMR = calcBMR(weight, height, age, gender);

    // calculates per input, add daily timer to reset totalCalories
    switch (goal) {
      case "Lose Weight":
        if (BMR * .9 > totalCalories) {
          return "You met your goal, and your calorie deficit was ${BMR - totalCalories} calories!";
        } else {
          return """You consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
          This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
        }

      case "Gain Weight":
        if (BMR * 1.1 < totalCalories) {
          return "You met your goal, and your calories above maintaining was ${totalCalories - BMR} calories!";
        } else {
          return """You consumed ${BMR - totalCalories} less calories than you should have to meet your goal.
          This means you were ${(totalCalories / BMR) * 100}% off of your goal""";
        }

      case "Maintain Weight":
        if (BMR / totalCalories <= .03) {
          // percentage is 3% off goal that is considered acceptable
          return "You met your goal, and consumed $totalCalories calories today";
        } else {
          if (0 < (BMR - totalCalories)) {
            return """You consumed ${BMR - totalCalories} less calories than you should have to meet your goal.
            This means you were ${(totalCalories / BMR) * 100}% off of your goal\r\n""";
          } else {
            return """You consumed ${totalCalories - BMR} more calories than you should have to meet your goal.
            This means you were ${(BMR / totalCalories) * 100}% off of your goal""";
          }
        }

      default:
        return """this isn't supposed to print. It's possible the database is empty.
        goal: $goal""";
    }
  }

  double calcCaloriesBurned(double weight, int time, double met) {
    double calBurned =
        (((((((met) * (weight / 2.205) * 3.5) / 200) * time) * 100)) / 100)
            .roundToDouble();
    // print("cal burned: $calBurned");
    return calBurned;
  }

  // double weightLost(double calBurned) {

  // }
}
