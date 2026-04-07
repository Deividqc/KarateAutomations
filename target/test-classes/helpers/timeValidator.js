function fn(s) {
    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    try {
        sdf.parse(s).time;
        return true;
    }
    catch (e) {
        karate.log('*** Invalid date string:',  s);
        return false;
    }
}