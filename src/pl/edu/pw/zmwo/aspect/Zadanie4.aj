package pl.edu.pw.zmwo.aspect;

import pl.edu.pw.zmwo.repo.Repository;

import java.lang.ref.WeakReference;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public aspect Zadanie4 {

    List<WeakReference<Repository>> auths = new LinkedList<>();

    class UserAuth {
        public final String username;
        public final String password;

        public UserAuth(String username, String password) {
            this.username = username;
            this.password = password;
        }
    }

    List<UserAuth> passwds = Arrays.asList(new UserAuth[]{
            new UserAuth("adam", "qwerty"),
            new UserAuth("ewelina", "asdfg"),
            new UserAuth("stefan", "zxcvb"),
    });

    void verifyUser(Object repo) {
        verifyUser((Repository) repo);
    }

    void verifyUser(Repository repo) {

        for (WeakReference<Repository> weak_repo : auths) {
            if (weak_repo.get() == repo) {
                return;
            }
        }

        Scanner scanner = new Scanner(System.in);
        System.out.print("Użytkownik: ");
        String username = scanner.next();
        System.out.print("Hasło: ");
        String password = scanner.next();

        for (UserAuth passwd : passwds) {
            if (passwd.password.equals(password) &&
                    passwd.username.equals(username)) {

                auths.add(new WeakReference<>(repo));
                return;
            }
        }

        System.err.println("Błędny użytkownik i hasło");
        throw new RuntimeException();
    }

    before(): (execution(* pl.edu.pw.zmwo.repo.Repository.updateProject(..)) ||
            execution(* pl.edu.pw.zmwo.repo.Repository.deleteProject(..))||
            execution(* pl.edu.pw.zmwo.repo.Repository.addProject(..)) ) {
        verifyUser(thisJoinPoint.getThis());
    }
}

