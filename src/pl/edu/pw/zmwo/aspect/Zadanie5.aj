package pl.edu.pw.zmwo.aspect;

public aspect Zadanie5 {
    declare soft :Exception: execution(* pl.edu.pw.zmwo.repo.Main.throwException());
}

