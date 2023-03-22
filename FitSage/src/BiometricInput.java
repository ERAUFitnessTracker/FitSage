//  OBSOLETE
import java.util.*;

public class BiometricInput {
    // Attributes
    private double height;
    private double weight;
    private int age;
    private String gender;


    // CONSTRUCTORS
    public BiometricInput(){
        // this is to create BiometricInput objects and use the functions without needing parameters
    }
     public BiometricInput(double height, double weight, int age, String gender){
         this.height = height;
         this.weight = weight;
         this.age = age;
         this.gender = gender;
     }

     // SETTERS
    public double setWeight(Scanner in) {
         System.out.print("\nEnter your weight (between 80lbs - 350lbs): ");

         while (!in.hasNextDouble()) in.next();
         double weightInput = in.nextDouble();

         // For error-checking
         while (weightInput < 80 || weightInput > 350) {
             System.out.print("Error. You must only enter a weight value between 80lbs and 350lbs.\nEnter your weight (between 80lbs - 350lbs): ");
             while (!in.hasNextDouble()) in.next();
             weightInput = in.nextDouble();
         }

         in.reset();
         return weightInput;
     }
    public double setHeight(Scanner in) {
        System.out.print("\nEnter your height (between 48in - 84in): ");
        while (!in.hasNextDouble()) in.next();
        double heightInput = in.nextDouble();

        // For error-checking
        while (heightInput < 48 || heightInput > 84) {
            System.out.print("Error. You must only enter a height value between 48in and 84in.\nEnter your height (between 48in - 84in): ");
            while (!in.hasNextDouble()) in.next();
            heightInput = in.nextDouble();
        }

        in.reset();
        return heightInput;
    }
    public int setAge(Scanner in) {
        System.out.print("\nEnter your age (between 18 years old - 80 years old): ");
        while (!in.hasNextInt()) in.next();
        int ageInput = in.nextInt();

        // For error-checking
        while (ageInput < 18 || ageInput > 80) {
            System.out.print("Error. You must only enter an age value between 18 years old and 80 years old.\nEnter your age (between 18 years old - 80 years old): ");
            while (!in.hasNextInt()) in.next();
            ageInput = in.nextInt();
        }
        in.reset();
        return ageInput;
    }
    public String setGender(Scanner in) {
        System.out.print("\nEnter your gender (male or female): ");
        String genderInput = in.next().toLowerCase(Locale.ROOT);

        // For error-checking
        while (!genderInput.equals("male") && !genderInput.equals("female")) {
            System.out.print("Error. You must only enter 'male' or 'female'. Enter your gender (male or female): ");
            genderInput = in.next().toLowerCase(Locale.ROOT);
        }
        in.reset();
        return genderInput;
    }

    // GETTERS
    public double getWeight() {
        return weight;
    }
    public double getHeight() {
        return height;
    }
    public int getAge() {
        return age;
    }
    public String getGender() {
        return gender;
    }

    //BMI and BFP Compositions
    public String bmiType(double BMI) {
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

    public String bfpType(double BFP) {
        if (gender.equals("male")) {
            if (((BFP < 8) && (age >= 18 && age <= 39)) || ((BFP < 11) && (age >= 40 && age <= 59)) || ((BFP < 13) && (age >= 60 && age <= 80))) {
                return "Underfat";
            } else if (((BFP >= 8 && BFP < 20) && (age >= 18 && age <= 39)) || ((BFP >= 11 && BFP < 22) && (age >= 40 && age <= 59)) || ((BFP >= 13 && BFP < 25) && (age >= 60 && age <= 80))) {
                return "Ideal";
            } else if (((BFP >= 20 && BFP <= 25) && (age >= 18 && age <= 39)) || ((BFP >= 22 && BFP <= 28) && (age >= 40 && age <= 59)) || ((BFP >= 25 && BFP <= 30) && (age >= 60 && age <= 80))) {
                return "Overfat";
            } else if (((BFP > 25) && (age >= 18 && age <= 39)) || ((BFP > 28) && (age >= 40 && age <= 59)) || ((BFP > 30) && (age >= 60 && age <= 80))) {
                return "Obese";
            } else {
                return "This shouldn't happen";
            }
        } else if (gender.equals("female")) {
            if (((BFP < 21) && (age >= 18 && age <= 39)) || ((BFP < 23) && (age >= 40 && age <= 59)) || ((BFP < 24) && (age >= 60 && age <= 80))) {
                return "Underfat";
            } else if (((BFP >= 21 && BFP < 34) && (age >= 18 && age <= 39)) || ((BFP >= 23 && BFP < 35) && (age >= 40 && age <= 59)) || ((BFP >= 24 && BFP < 36) && (age >= 60 && age <= 80))) {
                return "Ideal";
            } else if (((BFP >= 34 && BFP <= 39) && (age >= 18 && age <= 39)) || ((BFP >= 35 && BFP <= 40) && (age >= 40 && age <= 59)) || ((BFP >= 36 && BFP <= 42) && (age >= 60 && age <= 80))) {
                return "Overfat";
            } else if (((BFP > 39) && (age >= 18 && age <= 39)) || ((BFP > 40) && (age >= 40 && age <= 59)) || ((BFP > 42) && (age >= 60 && age <= 80))) {
                return "Obese";
            } else {
                return "This shouldn't happen";
            }
        } else {
            return "This shouldn't happen";
        }
    }

    public String bodyComposition(double BMI, double BFP) {
        return bmiType(BMI) + "-" + bfpType(BFP);
    }

    public String bodyType(double BMI, double BFP) {
        String type = bodyComposition(BMI, BFP);
        if (type.equals("Underweight-Underfat") || type.equals("Underweight-Ideal") || type.equals("Healthy-Underfat")) {
            return "Ectomorph";
        } else if (type.equals("Overweight-Overfat") || type.equals("Overweight-Ideal") || type.equals("Obese-Overfat") || type.equals("Obese-Obese")) {
            return "Endomorph";
        } else if (type.equals("Normal-Ideal")) {
            return "Mesomorph";
        } else {
            System.out.println("This body composition has no bodytype.");
            return null;
        }

    }

    public String getAllBiometrics(double BMI, double BFP){
        System.out.println("Generating biometrics...\n");

        return "Weight: " + weight + "lbs\nHeight: " + height
                + "inches\nAge: " + age + "years\nGender: " + gender
                + "\nBMI: " + BMI + "%\nBody-Fat Percentage: " + BFP
                + "\nBody-Composition: " + bodyComposition(BMI, BFP)
                + "\nBody-Type: " + bodyType(BMI, BFP);
    }

}
