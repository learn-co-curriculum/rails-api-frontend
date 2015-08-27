'use strict'

function showContainer(name){
  $('#student-container').hide();
  $('#cohort-container').hide();
  $('#index-container').hide();
  $(name).show();
}

function appendStudentLink(student, divName){
  $(divName).append("<div><a href = '#' class = 'student-link' data-id = '" + student.id + "'>" + student.name + "</a></div>")
}

function listStudents(studentsArray, divName){
  studentsArray.forEach(function(student){
    appendStudentLink(student, divName);
  });
}

function showStudent(student){
  $('h1#student-name').html(student.name);
  $('p#student-email').html("Email: " + student.email);
  $('p#student-cohort').html("Cohort: <a href = '#' id = 'cohort-link' data-id = '" + student.cohort.id + "'>" + student.cohort.name + '</a>');
}

function resetIndex(){
  $("#name-field").val("");
}

function replaceCohortName(name){
  $("#cohort-name").text(name);
}
