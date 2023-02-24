import java.util.Scanner;

public class FSMain {
    public static void main(String[] args) {
        // OBJECTS
        Scanner in = new Scanner(System.in);
        BiometricInput temp = new BiometricInput();
        BiometricInput bioInput = new BiometricInput(temp.setHeight(in), temp.setWeight(in), temp.setAge(in),temp.setGender(in));
        Calculators calculate = new Calculators();

        // PRINT STATEMENTS
        System.out.println(bioInput.getAllBiometrics(calculate.calcBMI(bioInput), calculate.calcBFP(bioInput)));

        System.out.println("Closing scanner...");
        in.close();
    }


}