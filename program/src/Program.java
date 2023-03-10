import java.io.FileWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

import com.opencsv.CSVWriter;

public class Program {

    public static void main (String[] args) {


        /* create scanner for user inputs */
        Scanner scanner = new Scanner(System.in);

        try{
            try {

                /* create sql statements set to execute */
                DatabaseInformation db =
                        new DatabaseInformation("employeeDBjson.json");
                SQLStatementCreator creator = new SQLStatementCreator(db);

                /* ask if the user wants to connect */
                System.out.print("Do you wish to connect to an SQL database? (y/n) ");
                String input = scanner.nextLine().toLowerCase();

                /* if the user wishes to execute the statements */
                if (input.equals("y")) {
                    /* enter user, password and url */
                    Class.forName("com.mysql.jdbc.Driver");
                    System.out.print("Enter username: ");
                    String user = scanner.nextLine();
                    System.out.print("Enter password: ");
                    String password = scanner.nextLine();
                    System.out.print("Enter database URL: ");
                    String url = scanner.nextLine();
                    Connection connection = DriverManager.getConnection(url, user, password);


                    /* create SQL query object and obtain statements */
                    ArrayList<StringBuilder> sqlStatements = creator.getStatements();
                    Statement statement = connection.createStatement();

                    /* obtain result set list from each query */
                    ArrayList<ResultSet> results = new ArrayList<>();
                    for (StringBuilder s: sqlStatements) {
                        results.add(statement.executeQuery(s.toString()));
                    }

                    /* for each SQL statement, save to a named csv */
                    for (int i = 0; i < results.size(); i++) {
                        CSVWriter csvWriter = new CSVWriter(new FileWriter(String.format("query%d.csv", i+1)));
                        csvWriter.writeAll(results.get(i), true);
                        csvWriter.close();
                    }

                    /* close the connection */
                    statement.close();
                    connection.close();
                }

                /* exceptions */
            } catch (ClassNotFoundException e) {
                /* if the driver was not found */
                e.printStackTrace();
            } catch (SQLException e) {
                /* if the connection to the SQL server failed */
                e.printStackTrace();
            }
        } catch(Exception e) {
            /* if anything else fails */
            System.out.println(e);
        }
    }

}
