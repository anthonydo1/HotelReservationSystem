import java.io.IOException;
import java.sql.*;
import java.util.Scanner;

public class HotelSystem {

    // JDBC driver name and database URL

    static final String DB_URL = "jdbc:mysql://localhost/hotel";
    static final String USER = "root";
    static final String PASS = "";
    
    private Connection connection;
    private Statement statement;
    private ResultSet result;
    private Scanner sc;
    
    public HotelSystem() {
        sc = new Scanner(System.in);
        
        System.out.println("Connecting to database...");
        try {
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public ResultSet executeQuery(String query) {
        try {
            statement = connection.createStatement();
            result = statement.executeQuery(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    public void printResultSet() throws SQLException {
        ResultSetMetaData rsmd = result.getMetaData();
        int columnsNumber = rsmd.getColumnCount();
        
        for (int i = 1; i <= columnsNumber; i++) {
            System.out.print(rsmd.getColumnName(i) + " ");
        }
        
        System.out.println("");
        
        while (result.next()) {
            for (int i = 1; i <= columnsNumber; i++) {
                if (i > 1) System.out.print("  ");
                String columnValue = result.getString(i);
                System.out.print(columnValue);
            }
            System.out.println("");
        }
    }
    
    public void showOptions() throws SQLException {
        boolean exit = false;
        
        while (exit == false) {
            System.out.println("Enter an option: ");
            int option = sc.nextInt();
            
            String query = "";
            
            switch(option) {
                case 1:
                    query = "select * from room where reserved = True;";
                    break;
                case 2:
                    System.out.println("Select floor number: ");
                    int floor = sc.nextInt();
                    query = "SELECT * FROM Room WHERE reserved = false and floorNumber =" + floor;
                    break;
                default:
                    exit = true;
                    break;
            }
            
            executeQuery(query);
            printResultSet();
            System.out.println("");
        }
    }
    
    public static void main(String[] args) throws SQLException, IOException {
        HotelSystem hotel = new HotelSystem();
        hotel.showOptions();
    }
}
