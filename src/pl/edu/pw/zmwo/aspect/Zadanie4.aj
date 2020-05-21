package pl.edu.pw.zmwo.aspect;

import pl.edu.pw.zmwo.repo.Repository;

import java.lang.ref.WeakReference;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public aspect Zadanie4 {

    List<WeakReference<Repository>> auths = new LinkedList<>();

    class UserAuth {
        public String username;
        public String password;
    }

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

        if (username.equals(password)) {
            auths.add(new WeakReference<>(repo));
            return;
        }

        throw new RuntimeException();
    }

    before(): execution(* pl.edu.pw.zmwo.repo.Repository.addProject(..)) && within(pl.edu.pw.zmwo.repo.*) {
        verifyUser(thisJoinPoint.getThis());
    }

    before(): execution(* pl.edu.pw.zmwo.repo.Repository.deleteProject(..)) && within(pl.edu.pw.zmwo.repo.*) {
        verifyUser(thisJoinPoint.getThis());
    }

    before(): execution(* pl.edu.pw.zmwo.repo.Repository.updateProject(..)) && within(pl.edu.pw.zmwo.repo.*) {
        verifyUser(thisJoinPoint.getThis());
    }
}

