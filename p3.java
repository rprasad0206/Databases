import java.sql.*;
import java.util.Scanner;

public class p3 {
    public static void main(String[] args) {
        String USERID = args[0];
        String PASSWORD = args[1];
        String CONNECTIONSTRING = args[2];
        int MENUITEM = Integer.parseInt(args[3]);

        Connection connection = null;

        String paramMsg;
        paramMsg = "Syntax:  java p3 <username> <password> <connection string> <menu item>\\n\\n"
                + "Include the following number of the menu item as your fourth parameter:\\n"
                + "1 â€“ Report Location Information\\n"
                + "2 â€“ Report Edge Information\\n"
                + "3 â€“ Report CS Staff Information\\n"
                + "4 â€“ Insert New Phone Extension\\n";

        if (args.length != 4) {
            System.out.println("Syntax: java p3 <username> <password> <connection string> <menu item>\\n");
            System.out.println(paramMsg);
        }

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Where is your PostgreSQL JDBC Driver?");
        }

        System.out.println("PostgreSQL JDBC Driver Registered!");

        try {
            connection = DriverManager.getConnection(CONNECTIONSTRING, USERID, PASSWORD);

            switch (MENUITEM) {
                case (1): locations(connection); break;
                case (2): edges(connection); break;
                case (3): csstaff(connection); break;
                case (4): insertPhone(connection); break;
                default:
                    System.out.println("Invalid menu item choice. Choose a value from 1 to 4");
                    break;
            }

        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public static void locations (Connection connection) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Location ID: ");
        String locationID = scanner.nextLine();

        String query = "SELECT * FROM locations WHERE locationID = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, locationID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                System.out.println("Location Information");
                System.out.println("Location ID: " + resultSet.getString("locationID"));
                System.out.println("Location Name: " + resultSet.getString("locationName"));
                System.out.println("Location Type: " + resultSet.getString("LocationType"));
                System.out.println("X-Coordinate: " + resultSet.getString("xcoord"));
                System.out.println("Y-Coordinate: " + resultSet.getString("ycoord"));
                System.out.println("Floor: " + resultSet.getString("mapfloor"));

                // TODO: Display other relevant columns
            } else {
                System.out.println("Location not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void edges(Connection connection) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Edge ID: ");
        String edgeID = scanner.nextLine();

        // Joining the edges table with locations twice: once for starting location and once for ending location
        String query = "SELECT E.edgeID AS Edge ID" +
                "L1.locationName AS startName, L1.mapFloor AS startFloor, " +
                "L2.locationName AS endName, L2.mapFloor AS endFloor " +
                "FROM Edges E " +
                "JOIN locations L1 ON E.startingLocationID = L1.locationID " +
                "JOIN locations L2 ON E.endLocationID = L2.locationID " +
                "WHERE E.edgeID = <EDGE_ID> ";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, edgeID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                System.out.println("Edges Information");
                System.out.println("Edge ID: " + resultSet.getString("edgeID"));
                System.out.println("Starting Location Name: " + resultSet.getString("startName"));
                System.out.println("Starting Location Floor: " + resultSet.getString("startFloor"));
                System.out.println("Ending Location Name: " + resultSet.getString("endName"));
                System.out.println("Ending Location Floor: " + resultSet.getString("endFloor"));
            } else {

                System.out.println("Edge not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void csstaff(Connection connection) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter CS Staff Account Name: ");
        String accountname = scanner.nextLine();

        String query = "SELECT cSStaff.accountname, csstaff.firstName, csstaff.lastName, csstaff.officeID, Titles.titleName, PhoneExtensions.phoneExt " +
                "FROM cSStaff CS " +
                "LEFT JOIN cSStaffTitles CST ON CS.accountName = CST.accountName " +
                "LEFT JOIN Titles T ON CST.titleID = T.titleID " +
                "LEFT JOIN PhoneExtensions PE ON CS.accountName = PE.accountName " +
                "WHERE CS.accountName = ?";

                ;
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, accountname);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                System.out.println("CS Staff Information");
                System.out.println("Account Name: " + resultSet.getString("accountname"));
                System.out.println("First Name: " + resultSet.getString("firstName"));
                System.out.println("Last Name: " + resultSet.getString("lastName"));
                System.out.println("Office ID: " + resultSet.getString("officeID"));
                System.out.println("Title: " + resultSet.getString("titleID"));
                System.out.println("Phone Ext: " + resultSet.getString("phoneExtension"));
            } else {
                System.out.println("CS Staff not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void insertPhone(Connection connection) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter CS Staff Account Name: ");
        String accountname = scanner.nextLine();
        System.out.print("Enter the new Phone Extension: ");
        int phoneExtension = Integer.parseInt(scanner.nextLine());


        String query = "INSERT INTO phoneextensions(accountname, phoneext) VALUES (?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, accountname);
            statement.setInt(2, phoneExtension);
            int result = statement.executeUpdate();
            if (result > 0) {
                System.out.println("New phone extension added successfully.");
            } else {
                System.out.println("Failed to add new phone extension.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}