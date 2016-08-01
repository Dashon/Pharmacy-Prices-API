# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
admin = CreateAdminService.new.call
member = CreateMemberService.new.call
superAdmin = CreateSuperAdminService.new.call

puts 'CREATED ADMIN USER: ' << superAdmin.email << ' KEY: ' << superAdmin.api_token
HealthCareFacility.create(name: 'Asian Demo Hospital', user_id: 1)
HcfLocation.create(address:'123 Main St', phone:'313-521-2512', email:'none@gmail.com', city:'Detroit', state:'MI', zip:'60640', health_care_facility_id: 1)
DniPharmacy.create(name:'Walgreens',address:'4556 Less St', phone:'313-737-1347', email:'none@gmail.com', city:'Detroit', state:'MI', zip:'48234', latitude:'0', longitude:'0', match_score:'0', surescripts_id:'0', stateList_id:'0', npi:'1233')
Benefit.create(name:'24 Hour', description:"24 hour", image_url:"/assets/images/svg/24-hour.svg")
Benefit.create(name:'Drive-Thru', description:"Drive-Thru", image_url:"/assets/images/svg/drive-thru.svg")
PharmacyBenefit.create(benefit_id:1, dni_pharmacy_id:1)
PharmacyBenefit.create(benefit_id:2, dni_pharmacy_id:1)

Survey.create(survey_type: "340b", health_care_facility_id: 1, user_id: 1)
Question.create(name: "test1", value:122)
Answer.create(user_answer: "yes", question_id:1, survey_id:1)

      admin.health_care_facility_id = 1
      member.health_care_facility_id = 1
      superAdmin.health_care_facility_id = 1

superAdmin.save
member.save
admin.save
