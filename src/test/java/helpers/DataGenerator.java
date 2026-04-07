package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {
    
    public static String generateRandomEmail() {
        // Implement logic to generate a random email address
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(1000) + "@test.com";
        return email;
    }

    public static String generateRandomUsername() {
        // Implement logic to generate a random username
        Faker faker = new Faker();
        String userName = faker.name().username();
        return userName;
    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        String taglist = faker.gameOfThrones().house();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        json.put("tagList", new String[]{taglist});
        return json;    
    }

}
