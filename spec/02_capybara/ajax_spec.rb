require_relative '../spec_helper'

describe "AJAX" do
  before(:all) do
    Cohort.destroy_all
    Student.destroy_all

    cohort_1 = Cohort.create(name: "Ruby-000", kind: "Web")
    cohort_2 = Cohort.create(name: "Ruby-001", kind: "Web")
    cohort_1.students << Student.create(name: "Amanda", email: "amanda@fis.com")
    cohort_1.students << Student.create(name: "Josh", email: "josh@fis.com")
    cohort_2.students << Student.create(name: "Steven", email: "steven@fis.com")
    cohort_2.students << Student.create(name: "Danny", email: "danny@fis.com")
    cohort_1.save
    cohort_2.save
  end

  after(:all) do
    Cohort.destroy_all
    Student.destroy_all
  end

  describe "getStudents()" do
    it "makes a request to GET '/students' and calls on listStudents() in the callback" do
      visit '/'
      page.execute_script("$('#students-list').empty()")
      page.execute_script("getStudents()")

      expect(page).to have_content('Amanda')
      expect(page).to have_content('Josh')
      expect(page).to have_content('Steven')
      expect(page).to have_content('Danny')
    end
  end

  describe "getStudent(id)" do
    it "makes a request to GET '/students/' + id and calls on showStudent() in the callback" do
      visit '/'
      id = Student.first.id
      page.execute_script("showContainer('#student-container')")
      page.execute_script("getStudent('#{id}')")

      expect(page).to have_content('Amanda')
      expect(page).to have_content('amanda@fis.com')
      expect(page).not_to have_content('Josh')
    end
  end

  describe "getStudentsByQuery(query)" do
    before(:each) do
      visit '/'
      page.execute_script("showContainer('#index-container')")
      page.execute_script("getStudentsByQuery('a')")
    end

    it "makes a request to GET '/students?q=' + query and calls on listStudents() in the callback" do
      expect(page).to have_content('Amanda')
    end

    it "empties the students list before calling on listStudents()" do
      expect(page).not_to have_content('Josh')
    end
  end

  describe "getStudentsForCohort(id)" do
    it "makes a request to GET '/cohorts/' + id and calls on replaceCohortName() in the callback" do
      visit '/'
      id = Cohort.first.id
      page.execute_script("showContainer('#cohort-container')")
      page.execute_script("getCohort('#{id}')")      

      expect(page).to have_content('Ruby-000')
    end
  end

  describe "getStudentsForCohort(id)" do
    it "makes a request to GET '/cohorts/' + id + '/students' and calls on listStudents() in the callback" do
      visit '/'
      id = Cohort.first.id
      page.execute_script("showContainer('#cohort-container')") 
      page.execute_script("getStudentsForCohort('#{id}')")

      expect(page).to have_content('Amanda')
      expect(page).to have_content('Josh')
      expect(page).not_to have_content('Steven')
      expect(page).not_to have_content('Danny')
    end
  end
end