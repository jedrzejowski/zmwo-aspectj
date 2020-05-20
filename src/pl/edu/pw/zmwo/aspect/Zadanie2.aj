package pl.edu.pw.zmwo.aspect;

import pl.edu.pw.zmwo.repo.Project;
import pl.edu.pw.zmwo.repo.Repository;

public aspect Zadanie2 {

    void saveRepo(Object repo) {
        saveRepo((Repository) repo);
    }

    void saveRepo(Repository repo) {

        System.out.println("\t\t\t\t\tzapisanie repo ");
    }

    after(): execution(* pl.edu.pw.zmwo.repo.Repository.addProject(..)) {
        saveRepo(thisJoinPoint.getThis());
    }

    after(): execution(* pl.edu.pw.zmwo.repo.Repository.deleteProject(..)) {
        saveRepo(thisJoinPoint.getThis());
    }

    after(): execution(* pl.edu.pw.zmwo.repo.Repository.updateProject(..)) {
        saveRepo(thisJoinPoint.getThis());
    }
}

