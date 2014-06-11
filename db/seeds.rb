# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[{code: 'oral_surgery', name: 'Oral Surgery', procedures: [
    {name: 'Treatment plan for referral', code: 'treatment_plan'},
    {name: 'Extraction', code: 'extraction'},
    {name: 'Impacted Teeth', code: 'impacted_teeth'},
    {name: 'Dental Implant', code: 'dental_implant'},
    {name: 'Pathologic Condition', code: 'pathologic_condition'},
    {name: 'Expose and Bond', code: 'expose_and_bond'},
    {name: 'Apicoectomy', code: 'apicoectomy'},
    {name: 'Pre-Prosthetic Surgery', code: 'pre_prosthetic_surgery'},
    {name: 'Oral-Facial Surgery', code: 'oral_facial_surgery'},
    {name: 'Orthognathic Surgery', code: 'orthognathic_surgery'},
    {name: 'Other', code: 'other'}
]},
 {code: 'orthodontics', name: 'Orthodontics', procedures: [
     {name: 'Early or Interceptive Treatment', code: 'early_interceptive_treatment'},
     {name: 'Minor Tooth Movement', code: 'minor_tooth_movement'},
     {name: 'Craniofacial Orthopedics', code: 'craniofacial_orthopedics'},
     {name: 'TMD Treatment', code: 'tmd_treatment'},
     {name: 'Pre-prosthetic Treatment', code: 'pre_prosthetic_treatment'},
     {name: 'Other', code: 'other'}
 ]},
 {code: 'endodontics', name: 'Endodontics', procedures: [
     {name: 'Pulp Exposed', code: 'pulp_exposed'},
     {name: 'Tooth open for drainage', code: 'tooth_open_for_drainage'},
     {name: 'Patient has discomfort please evaluate', code: 'evaluate_discomfort'},
     {name: 'Radiographic findings present', code: 'radiographic_findings'},
     {name: 'Trauma', code: 'trauma'},
     {name: 'Previous endodontic treatment failing', code: 'previous_treatment_failing'},
     {name: 'Bridge/Crown Cemented - Temporary', code: 'bridge_crown_cemented_temporary'},
     {name: 'Bridge/Crown Cemented - Permanent', code: 'bridge_crown_cemented_permanent'},
     {name: 'Pretreatment - Banding', code: 'pretreatment_banding'},
     {name: 'Pretreatment - Post Removal', code: 'pretreatment_post_removal'},
     {name: 'Finishing - No Post', code: 'finishing_no_post'},
     {name: 'Finishing - Post Space Only', code: 'finishing_post_space_only'},
     {name: 'Finishing - Para post', code: 'finishing_para_post'},
     {name: 'Finishing - Cast Post', code: 'finishing_cast_post'},
     {name: 'Finishing - C-post', code: 'finishing_c_post'},
     {name: 'Finishing - Core composite buildup', code: 'finishing_core_composite_buildup'},
     {name: 'Finishing - Post and core buildup', code: 'finishing_post_and_core_buildup'},
     {name: 'Finishing - Cotton and IRM', code: 'finishing_cotton_and_irm'},
     {name: 'Finishing - Cotton with zinc phosphate', code: 'finishing_cotton_with_zinc_phosphate'}
 ]},
 {code: 'pedodontics', name: 'Pedodontics', procedures: [
     {name: 'Initial Visit to dentist', code: 'initial_visit'},
     {name: 'Regular Visit', code: 'regular_visit'},
     {name: 'Dental Caries', code: 'dental_caries'},
     {name: 'Pathology', code: 'pathology'},
     {name: 'Extraction', code: 'extraction'},
     {name: 'Space Maintainer', code: 'space_maintainer'},
     {name: 'Oral Habit Appliance', code: 'oral_habit_appliance'},
     {name: 'Emergency/Trauma', code: 'emergency_trauma'},
     {name: 'Other', code: 'other'},
 ]},
 {code: 'prosthodontics', name: 'Prosthodontics', procedures: [
     {name: 'Full Mouth Rehabilitation', code: ''},
     {name: 'Limited Care', code: 'limited_care'},
     {name: 'Consultation', code: 'consultation'},
     {name: 'Fixed Prosthesis', code: 'fixed_prosthesis'},
     {name: 'Removable Prosthesis', code: 'removable_prosthesis'},
     {name: 'Implant Therapy', code: 'implant_therapy'},
     {name: 'Other', code: 'other'}
 ]},
 {code: 'general_dentistry', name: 'General Dentistry', procedures: [
     {name: 'New Patient Consultation', code: 'new_patient_consultation'},
     {name: 'Emergency Care', code: 'emergency_care'},
     {name: 'Follow-up Care', code: 'follow_up_care'},
     {name: 'Other', code: 'other'}
 ]},
 {code: 'oral_pathology', name: 'Oral Pathology', procedures: [
     {name: 'Consultation', code: 'consultation'},
     {name: 'Biopsy', code: 'biopsy'},
     {name: 'Other', code: 'other'}
 ]},
 {code: 'tmd_sleep_apnea', name: 'TMD/Sleep Apnea', procedures: [
     {name: 'Consultation', code: 'consultation'},
     {name: 'TMD Treatment', code: 'tmd_treatment'},
     {name: 'Sleep Apnea Appliance', code: 'sleep_apnea_appliance'},
     {name: 'Other', code: 'other'}
 ]}
].each do |practice_type|
  p_type    = PracticeType.find_or_create_by({name: practice_type[:name], code: practice_type[:code]})
  practice_type[:procedures].each do |procedure|
    Procedure.find_or_create_by({name: procedure[:name], code: procedure[:code], practice_type: p_type})
  end
end
