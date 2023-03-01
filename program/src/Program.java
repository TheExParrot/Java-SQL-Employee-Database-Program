import java.sql.*;
import java.util.Scanner;

public class Program {

    public static void main (String args[]) {

        /* create scanner for user inputs */
        Scanner scanner = new Scanner(System.in);

        try{
            try {
                /* enter user, password and url */
                Class.forName("com.mysql.jdbc.Driver");
                System.out.print("Enter username: ");
                String user = scanner.nextLine();
                System.out.print("Enter password: ");
                String password = scanner.nextLine();
                System.out.print("Enter database URL: ");
                String url = scanner.nextLine();
                Connection con = DriverManager.getConnection(url, user, password);

                /* connection was successful from here on */

                /* create SQL statement */
                Statement stmt=con.createStatement();

                ResultSet rs=stmt.executeQuery("SELECT * FROM employees");
                while(rs.next())
                    System.out.println(rs);
                con.close();


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
