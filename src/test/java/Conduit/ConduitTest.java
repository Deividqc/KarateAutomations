package Conduit;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
//import com.intuit.karate.junit5.Karate;
//import lines utils for reporting
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class ConduitTest {

    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions

    /*
     * This block is commented out because it is not needed to run the tests, but it
     * can be used to generate a report after the tests are executed.
     * 
     * @Karate.Test
     * Karate testAll() {
     * return Karate.run().relativeTo(getClass());
     * }
     * 
     * @Karate.Test
     * Karate testTags(){
     * return Karate.run("tags").relativeTo(getClass());
     * }
     */

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:Conduit")
                .outputCucumberJson(true)
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    // Added from the Karate library in github
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Conduit");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
