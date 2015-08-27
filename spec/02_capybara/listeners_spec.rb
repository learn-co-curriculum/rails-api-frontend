require_relative '../spec_helper'

describe "Listeners" do
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

  describe "addListenerOnStudentLink()" do
    it "displays student upon clicking on name link" do
      visit '/'
      click_link('Amanda')

      expect(page).to have_content('Amanda')
      expect(page).to have_content('amanda@fis.com')
      expect(page).not_to have_content('Josh')
    end
  end

  describe "addListenerOnCohortLink()" do
    it "displays cohort upon clicking on cohort link" do
      visit '/'
      click_link('Amanda')
      click_link('Ruby-000')

      expect(page).to have_content('Ruby-000')
      expect(page).to have_content('Amanda')
      expect(page).to have_content('Josh')
      expect(page).not_to have_content('Steven')
      expect(page).not_to have_content('Danny')
    end
  end

  describe "addListenerOnBackLink()" do
    it "displays students upon clicking on back link" do
      visit '/'
      click_link('Amanda')
      click_link('Home')

      expect(page).to have_content('Amanda')
      expect(page).to have_content('Josh')
      expect(page).to have_content('Steven')
      expect(page).to have_content('Danny')

      visit '/'
      click_link('Amanda')
      click_link('Ruby-000')
      click_link('Home')

      expect(page).to have_content('Amanda')
      expect(page).to have_content('Josh')
      expect(page).to have_content('Steven')
      expect(page).to have_content('Danny')
    end
  end

  describe "addSearchListener()" do
    it "updates displayed students upon search" do
      visit '/'
      fill_in("name-field", with: "a")

      expect(page).to have_content('Amanda')
      expect(page).not_to have_content('Josh')
    end
  end
end