public class Calculators {
    private double BMI;
    private double BFP;


    // BMI CALCULATOR
    public double calcBMI(BiometricInput bio) {
        this.BMI = (double) Math.round(703 * (bio.getWeight() / (Math.pow(bio.getHeight(), 2))) * 10) / 10;
        return BMI;
    }

    // BODY-FAT PERCENTAGE
    public double calcBFP(BiometricInput bio) {
        if (bio.getGender().equals("male")) {
            this.BFP = (double) Math.round(((1.20 * BMI) + (0.23 * bio.getAge()) - 16.2) * 10) / 10;
        } else if (bio.getGender().equals("female")) {
            this.BFP = (double) Math.round(((1.20 * BMI) + (0.23 * bio.getAge()) - 5.4) * 10) / 10;
        } else {
            System.out.println("This shouldn't happen.");
        }
        return BFP;
    }
}
