'use strict'

function getStudents(){
  $.ajax({
    method: "GET",
    url: "/students"
  })
    .done(function(students) {
      listStudents(students, '#students-list');
    });
}

function getStudent(id){
  $.ajax({
    method: "GET",
    url: "/students/" + id
  })
    .done(function(student) {
      showStudent(student);
    });
}

function getStudentsByQuery(query){
  $.ajax({
    method: "GET",
    url: '/students?q=' + query
  })
    .done(function(students) {
      $('#students-list').empty();
      listStudents(students, '#students-list');
    });
}

function getCohort(id){
  $.ajax({
    method: "GET",
    url: '/cohorts/' + id
  })
    .done(function(cohort) {
      replaceCohortName(cohort.name);
    });
}

function getStudentsForCohort(id){
  $.ajax({
    method: "GET",
    url: '/cohorts/' + id + '/students'
  })
    .done(function(students) {
      listStudents(students, '#cohort-students-list');
    });
}
