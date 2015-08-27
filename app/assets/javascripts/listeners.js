'use strict'

function addSearchListener(){
  $('#name-field').on('keyup', function(){
    var query = $(this).val();

    getStudentsByQuery(query);
  })
}

function addListenerOnStudentLink(){
  $('#students-list').on('click', '.student-link', function(e){
    e.stopPropagation();
    e.preventDefault();

    getStudent($(this).data("id"));
    showContainer('#student-container');
  });
}

function addListenerOnCohortLink(){
  $('#student-cohort').on('click', 'a', function(e){
    e.stopPropagation();
    e.preventDefault();

    getCohort($(this).data("id"));
    getStudentsForCohort($(this).data("id"));
    showContainer('#cohort-container');
  });
}

function addListenerOnBackLink(){
  $(".back-link").on('click', function(e){
    e.stopPropagation();
    e.preventDefault();

    showContainer('#index-container');
  });
}
