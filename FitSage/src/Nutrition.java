import java.util.ArrayList;
import java.util.Scanner;
import java.util.List;
import java.io.*;
import java.util.function.DoubleToIntFunction;

public class Nutrition {

    // this int aggregates an overall calorie count, NEEDS TO BE PER DAY. THIS VALUE MUST BE RESET AT THE END / BEGINNING OF EACH DAY
    int totalCalories = 0;

    // this string is the choice of the user
    String choice;

    // this boolean holds a t/f for testing later in the code
    boolean tester;

    // this string holds the goal of the user
    String goal;


    //this value is the estimated amount of calories a person can maintain daily to maintain weight
    float BMR;

    public void changeGoal(){

        System.out.println("Would you like to \r\n" +
                           "1. Lose weight \r\n" +
                           "2. Gain weight \r\n" +
                           "3. Maintain weight \r\n" +
                           "(Input an integer 1-3)\r\n");
        Scanner in = new Scanner(System.in);
        choice = in.nextLine();
        if (choice.equals("1") || choice.equals("2") || choice.equals("3")){
            tester = true;
        }
        while (tester = false){
            System.out.println("ERROR. Input must be an integer 1-3. Pick a new integer.");
            choice = in.nextLine();
        }

        if (choice.equals("1")){
            System.out.println("You picked Lose Weight");
            goal = "Lose Weight";
        } else if ((choice.equals("2"))) {
            System.out.println("You picked Gain Weight");
            goal =  "Gain Weight";
        }else{
            System.out.println("You picked Maintain Weight.");
            goal = "Maintain Weight";
        }
    }

    public void incrementAddCaloriesDaily(int x){

        totalCalories = totalCalories + x;

    }

    public void calorieCalculator(){

        // calculates per input, add daily timer to reset totalCalories
        BiometricInput BI = new BiometricInput();
        if (goal.equals("Lose Weight")){
            if (BI.getGender().equalsIgnoreCase("male")){
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) + 5);
                if (BMR*.9>totalCalories){
                    System.out.println("Great job! You met your goal, and your calorie deficit was " + (BMR-totalCalories) + " calories!\r\n" );
                }else{
                    System.out.println("Sadly, you consumed " + (totalCalories-BMR) + " more calories than you should have to meet your goal.\r\n" );
                    System.out.println("This means you were " + (BMR / totalCalories) + "% off of your goal");
                }
            }else{
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) - 161);
                if (BMR*.9>totalCalories){
                    System.out.println("Great job! You met your goal, and your calorie deficit was " + (BMR-totalCalories) + " calories!\r\n" );
                }else{
                    System.out.println("Sadly, you consumed " + (totalCalories-BMR) + " more calories than you should have to meet your goal.\r\n" );
                    System.out.println("This means you were " + (BMR / totalCalories) + "% off of your goal");
                }
            }
        }

        if (goal.equals("Gain Weight")){
            if (BI.getGender().equalsIgnoreCase("male")){
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight for men
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) + 5);
                if (BMR*1.1<totalCalories){
                    System.out.println("Great job! You met your goal, and your calories above maintaining was " + (totalCalories-BMR) + " calories!\r\n" );
                }else{
                    System.out.println("Sadly, you consumed " + (BMR-totalCalories) + " less calories than you should have to meet your goal.\r\n" );
                    System.out.println("This means you were " + (totalCalories / BMR) + "% off of your goal");
                }
            }else{
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) - 161);
                if (BMR*1.1<totalCalories){
                    System.out.println("Great job! You met your goal, and your calories above maintaining was " + (totalCalories-BMR) + " calories!\r\n" );
                }else{
                    System.out.println("Sadly, you consumed " + (BMR-totalCalories) + " less calories than you should have to meet your goal.\r\n" );
                    System.out.println("This means you were " + (totalCalories / BMR) + "% off of your goal\r\n");
                }
            }
        }

        if (goal.equals("Maintain Weight")){
            if (BI.getGender().equalsIgnoreCase("male")){
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) + 5);
                if (BMR/totalCalories <= .03){
                    // percentage is 3% off goal that is considered acceptable
                    System.out.println("Great job! You met your goal, and consumed " + totalCalories + " calories today\r\n" );
                }else {
                    if (0 < (BMR - totalCalories)) {
                        System.out.println("Sadly, you consumed " + (BMR - totalCalories) + " less calories than you should have to meet your goal.\r\n");
                        System.out.println("This means you were " + (totalCalories / BMR) + "% off of your goal\r\n");
                    } else  {
                        System.out.println("Sadly, you consumed " + (totalCalories - BMR) + " more calories than you should have to meet your goal.\r\n");
                        System.out.println("This means you were " + (BMR / totalCalories) + "% off of your goal\r\n");
                    }
                }
            }else{
                // this measures in kilograms & cm to get ideal calorie intake for maintained weight for women
                BMR = (float) ((10*BI.getWeight()*.45359237) + (6.25*BI.getHeight()*2.54) - (5*BI.getAge()) - 161);
                if (BMR/totalCalories <= .03){
                    // percentage is 3% off goal that is considered acceptable
                    System.out.println("Great job! You met your goal, and consumed " + totalCalories + " calories today\r\n" );
                }else{
                    if (0 < (BMR - totalCalories)) {
                        System.out.println("Sadly, you consumed " + (BMR - totalCalories) + " less calories than you should have to meet your goal.\r\n");
                        System.out.println("This means you were " + (totalCalories / BMR) + "% off of your goal");
                    } else  {
                        System.out.println("Sadly, you consumed " + (totalCalories - BMR) + " more calories than you should have to meet your goal.\r\n");
                        System.out.println("This means you were " + (BMR / totalCalories) + "% off of your goal");
                    }
                }
            }
        }
    }
}
