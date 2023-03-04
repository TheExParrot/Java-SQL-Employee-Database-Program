import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;


public class JSONHandler {

    public HashMap<String, String[]> getHashMapFromJson(String fn) {
        String json = fileToString(fn);
        Gson gson = new Gson();
        HashMap<String, String[]> hashMap = gson.fromJson(json,
                new TypeToken<HashMap<String, String[]>>() {}.getType());
        return hashMap;
    }

    private String fileToString(String fn) {
        String output = "";
        try {
            BufferedReader reader = new BufferedReader(new FileReader(fn));
            String line;
            while ((line = reader.readLine()) != null) {
                output += line;
            }
            reader.close();
            return output;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
