package Conduit;

//import com.intuit.karate.Results;
//import com.intuit.karate.Runner;
//import static org.junit.jupiter.api.Assertions.*;
//import org.junit.jupiter.api.Test;
import com.intuit.karate.junit5.Karate;

class ConduitTest {

    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

    /*@Karate.Test
    Karate testTags(){
        return Karate.run("tags").relativeTo(getClass());
    }*/
}
