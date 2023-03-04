import java.util.HashMap;

public class DatabaseInformation {

    private HashMap<String, String[]> database;

    public DatabaseInformation() {
        this.database = new HashMap<>();
    }

    public void addTable(String table, String[] attributes) {
        database.put(table, attributes);
    }

    public String[] getAttributes(String table) {
        return database.get(table);
    }

    public String[] getTables() {
        return database.keySet().toArray(new String[database.size()]);
    }

}
