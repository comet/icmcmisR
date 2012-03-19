# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120319104459) do

  create_table "appointments", :force => true do |t|
    t.integer  "physician_id"
    t.integer  "patient_id"
    t.string   "subject_matter"
    t.date     "appointment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_plans", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.float    "maximum_cover"
    t.float    "minimum_cover"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnoses", :force => true do |t|
    t.string   "detail"
    t.integer  "specific_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encounter_id"
  end

  create_table "doctors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encounters", :force => true do |t|
    t.text     "complains"
    t.integer  "patient_id"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encounter_type"
  end

  create_table "patients", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.float    "amount"
    t.text     "payment_for"
    t.integer  "received_by"
    t.float    "expeccted_amount"
    t.string   "payment_method"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encounter_id"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "given_name"
    t.string   "surname"
    t.string   "gender"
    t.string   "address"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.datetime "birth_date"
    t.string   "birth_date_estimate"
    t.integer  "alive"
    t.integer  "created_by"
    t.integer  "personifiable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "personifiable_type"
    t.string   "type"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "secret_question"
    t.string   "secret_answer"
    t.string   "email"
    t.string   "password"
  end

  create_table "performedtests", :force => true do |t|
    t.integer  "test_id"
    t.integer  "encounter_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "item_id"
    t.float    "price"
    t.integer  "sold_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_observations", :force => true do |t|
    t.string   "ob_name"
    t.text     "description"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.text     "other_remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specifics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "specific_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encounter_id"
    t.float    "price"
    t.text     "other_info"
    t.float    "duration"
  end

  create_table "treatments", :force => true do |t|
    t.string   "detail"
    t.integer  "specific_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encounter_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "person_id"
    t.string   "username"
    t.string   "password"
    t.string   "salt"
    t.string   "secret_question"
    t.string   "secret_answer"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
