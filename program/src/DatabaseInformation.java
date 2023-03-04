import java.util.Arrays;
import java.util.HashMap;

public class DatabaseInformation {

    private HashMap<String, String[]> database;

    public DatabaseInformation() {
        this.database = new HashMap<>();
    }

    public DatabaseInformation(String jsonFilename) {
        this.database = new JSONHandler().getHashMapFromJson(jsonFilename);
    }

    public void addTable(String table, String[] attributes) {
        database.put(table, attributes);
    }

    public String[] getAttributes(String table) {
        return database.get(table);
    }

    public String[] getTables() {
        String[] tables = database.keySet().toArray(new String[database.size()]);
        Arrays.sort(tables);
        return tables;
    }



}
