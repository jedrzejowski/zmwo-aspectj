package pl.edu.pw.zmwo.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public aspect Zadanie1 {
    private static long id = 0;
    pointcut everyMethod(): execution(public * *(..)) && within(pl.edu.pw.zmwo.repo.*);

    void log(long id, String format, Object... args) {

        System.out.println(
                String.format("\t\t\t\t\t\t\t\t[%s] ", id) + String.format(format, args)
        );
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
        log(my_id, "return type = %s", return_value != null ? return_value.getClass() : "null");

        return return_value;
    }
}

