package pl.edu.pw.zmwo.aspect;

import java.io.FileWriter;
import java.io.IOException;

public aspect Zadanie1 {

    static String EOL = System.getProperty("line.separator");
    private FileWriter log_file = null;
    private static long id = 0;

    pointcut everyMethod(): execution(public * *(..)) &&
            within(pl.edu.pw.zmwo.repo.*);

    void log(long id, String format, Object... args) {

        String line = String.format("[%s] ", id) + String.format(format, args);

        try {
            if (log_file == null) {
                log_file = new FileWriter("zadanie1_log.log");
            }

            log_file.write(line + EOL);
            log_file.flush();
        } catch (IOException exception) {
            System.err.println(line);
        }
    }

    Object around(): everyMethod() {
        final long my_id = ++id;

        log(my_id, "what = %s", thisJoinPoint.toLongString());
        log(my_id, "where = %s", thisJoinPointStaticPart.getSourceLocation());

        for (Object arg : thisJoinPoint.getArgs()) {
            log(my_id, "arg = %s", arg.getClass());
        }

        long start_time = System.nanoTime();
        Object return_value = proceed();
        long end_time = System.nanoTime();

        log(my_id, "execution time = %s [ns]", end_time - start_time);
        log(my_id, "return type = %s",
                return_value != null ? return_value.getClass() : "null");

        return return_value;
    }
}

