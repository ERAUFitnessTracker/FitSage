import java.io.*;
import java.util.*;

// In Progress
public class FileIO {
    String[] userCredentials = new String[2];
    HashMap<String,String> allAccounts;
    ArrayList<String> allAccountData;


    public void writeCSVFile(double height, double weight, int age, String gender, Scanner in){
        try {
            FileWriter fw = new FileWriter("UserData.csv", true);
            BufferedWriter bw = new BufferedWriter(fw);
            int create = 0;
           

        } catch (ArrayIndexOutOfBoundsException | IOException e) {
            System.out.println("The File is either open or corrupted.");
        }
    }
    public void enterLogin(Scanner in) {
        System.out.print("Enter username (Case Sensitive): ");
        String username = (in.nextLine());
        System.out.print("Enter password (Case Sensitive): ");
        String password = in.nextLine();
        while (username.contains(" ") || password.contains(" ") || username.contains(",") || password.contains(",") || username.isEmpty() || password.isEmpty()) {
            System.out.println("Error. The username or password must not contain spaces or commas. Please try again.");
            System.out.print("Enter username(Case Sensitive): ");
            username = (in.nextLine());
            System.out.print("Enter password (Case Sensitive): ");
            password = in.nextLine();
        }
        userCredentials[0] = username;
        userCredentials[1] = password;
    }
    public void readCSVFile() {
        try {
            FileReader fr = new FileReader("userData.csv");
            BufferedReader br = new BufferedReader(fr);
            String line;
            while ((line = br.readLine()) != null) {
                String strLine = line.replace("[", "").replace("]", "");
                String[] arrLine = line.split(",");

                // Saves all account data to array list
                allAccounts.put(arrLine[0], arrLine[1]);
                allAccountData.add(strLine);
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    public boolean checkLogin() {
        Collection<String> Usernames = allAccounts.keySet();
        Collection<String> Passwords = allAccounts.values();

        return !Usernames.contains(userCredentials[0]) || !Passwords.contains(userCredentials[0]);

    }
}
