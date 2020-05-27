package pl.edu.pw.zmwo.aspect;

import pl.edu.pw.zmwo.repo.Document;
import pl.edu.pw.zmwo.repo.Project;
import pl.edu.pw.zmwo.repo.Repository;
import pl.edu.pw.zmwo.repo.Task;

import java.lang.ref.WeakReference;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public aspect Zadanie3 {

//    private List<Document> Project._cache_getDocuments = null;
//    private List<Task> Project._cache_getTasks = null;
//
//    List<Document> around(): call(public List<Document> Project.getDocuments()) {
//        Project project = (Project) thisJoinPoint.getTarget();
//
//        if (project._cache_getDocuments == null) {
//            project._cache_getDocuments = proceed();
//        }
//
//        return project._cache_getDocuments;
//    }
//
//    before(): call(public void Project.addDocument(Document)) ||
//            call(public void Project.updateDocument(Document)) ||
//            call(public void Project.deleteDocument(Document)) {
//        Project project = (Project) thisJoinPoint.getTarget();
//        project._cache_getDocuments = null;
//    }
//
//    List<Task> around(): call(public List<Task> Project.getTasks()) {
//        Project project = (Project) thisJoinPoint.getTarget();
//
//        if (project._cache_getTasks == null) {
//            project._cache_getTasks = proceed();
//        }
//
//        return project._cache_getTasks;
//    }
//
//    before(): call(public void Project.addTask(*)) ||
//            call(public void Project.updateTask(*)) ||
//            call(public void Project.deleteTask(*)) {
//        Project project = (Project) thisJoinPoint.getTarget();
//        project._cache_getTasks = null;
//    }
}

