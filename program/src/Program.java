import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

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
                ArrayList<StringBuilder> statements = creator.getStatements();

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

                    /* create SQL query object */
                    Statement statement = connection.createStatement();

                    /* obtain result set */
                    ArrayList<ResultSet> results = new ArrayList<>();
                    for (StringBuilder s: statements) {
                        results.add(statement.executeQuery(s.toString()));
                    }

                    /* print result set
                    while (resultSet.next())
                        System.out.println(resultSet);*/

                    /* close the connection */
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
