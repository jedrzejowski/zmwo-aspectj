package pl.edu.pw.zmwo.aspect;

import com.google.gson.Gson;
import pl.edu.pw.zmwo.repo.Repository;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public aspect Zadanie2 {

    static String error_msg = "Zadanie2: Błąd wczytywania repozytorium";
    Gson gson = new Gson();

    void saveRepo(Object repo) {
        saveRepo((Repository) repo);
    }

    Repository loadRepo() {
        try {
            Repository repo = gson.fromJson(
                    new FileReader("repository.json"),
                    Repository.class
            );

            if (repo == null) {
                System.err.println(error_msg);
                return new Repository();
            }

            return repo;
        } catch (IOException e) {
            System.err.println(error_msg);
            return new Repository();
        }
    }

    void saveRepo(Repository repo) {
        try {
            FileWriter writer = new FileWriter("repository.json");
            gson.toJson(repo, writer);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            System.err.println("Błąd zapisywania");
        }
    }

    Repository around(): call(pl.edu.pw.zmwo.repo.Repository+.new())
            && within(pl.edu.pw.zmwo.repo.*) {
        return loadRepo();
    }

    after(): execution(* pl.edu.pw.zmwo.repo.Repository.addProject(..)) ||
            execution(* pl.edu.pw.zmwo.repo.Repository.deleteProject(..)) ||
            execution(* pl.edu.pw.zmwo.repo.Repository.updateProject(..)) {
        saveRepo(thisJoinPoint.getThis());
    }
}

