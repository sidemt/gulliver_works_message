# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_13_044811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "アカウント", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワードのハッシュ値"
    t.integer "email_verification_status", default: 0, null: false, comment: "メールアドレスの確認状態"
    t.uuid "email_verification_token", comment: "メール確認用のトークン"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "企業", force: :cascade do |t|
    t.string "name", null: false, comment: "法人名"
    t.string "name_kana", null: false, comment: "法人名(ふりがな)"
    t.string "head_office_location", null: false, comment: "本店所在地"
    t.string "year_of_establishment", null: false, comment: "設立年"
    t.string "hp_url", comment: "HPのURL"
    t.string "phone", comment: "電話番号"
    t.integer "capital", null: false, comment: "資本金"
    t.boolean "is_listed", default: false, null: false, comment: "上場 / 非上場"
    t.string "representative", null: false, comment: "代表指名"
    t.string "representative_kana", null: false, comment: "代表氏名(ふりがな)"
    t.string "net_sales", comment: "前年度の売上高"
    t.string "numbers_of_employees", null: false, comment: "従業員数"
    t.integer "average_age", comment: "平均年齢"
    t.text "business_summary", null: false, comment: "事業概要"
    t.string "corporate_pr", comment: "企業PR"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "employees", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "従業員", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワードのハッシュ値"
    t.integer "email_verification_status", default: 0, null: false, comment: "メールアドレスの確認状態"
    t.uuid "email_verification_token", comment: "メール確認用のトークン"
    t.uuid "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
  end

  create_table "employment_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "雇用形態", force: :cascade do |t|
    t.string "name", null: false, comment: "雇用形態名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_employment_statuses_on_name", unique: true
  end

  create_table "industries", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "業種", force: :cascade do |t|
    t.string "name", null: false, comment: "業種名"
    t.uuid "industry_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["industry_category_id"], name: "index_industries_on_industry_category_id"
    t.index ["name", "industry_category_id"], name: "index_industries_on_name_and_industry_category_id", unique: true
  end

  create_table "industry_categories", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "業種カテゴリー", force: :cascade do |t|
    t.string "name", null: false, comment: "業種カテゴリー名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_industry_categories_on_name", unique: true
  end

  create_table "jtis", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "JWTのホワイトリスト", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "メッセージ", force: :cascade do |t|
    t.string "content", comment: "内容"
    t.uuid "room_id"
    t.uuid "account_id"
    t.uuid "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["employee_id"], name: "index_messages_on_employee_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "occupation_main_categories", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "職種「大項目」", force: :cascade do |t|
    t.string "name", null: false, comment: "職種「大項目」名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_occupation_main_categories_on_name", unique: true
  end

  create_table "occupation_sub_categories", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "職種「中項目」", force: :cascade do |t|
    t.string "name", null: false, comment: "職種「中項目」名"
    t.uuid "occupation_main_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_occupation_sub_categories_on_name", unique: true
    t.index ["occupation_main_category_id"], name: "index_occupation_sub_categories_on_occupation_main_category_id"
  end

  create_table "occupations", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "職種「小項目」", force: :cascade do |t|
    t.string "name", null: false, comment: "職種「小項目」名"
    t.uuid "occupation_sub_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_occupations_on_name", unique: true
    t.index ["occupation_sub_category_id"], name: "index_occupations_on_occupation_sub_category_id"
  end

  create_table "prefectures", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "都道府県", force: :cascade do |t|
    t.string "name", null: false, comment: " 都道府県名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_prefectures_on_name", unique: true
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "トークルーム", force: :cascade do |t|
    t.uuid "account_id"
    t.uuid "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "company_id"], name: "index_rooms_on_account_id_and_company_id", unique: true
    t.index ["account_id"], name: "index_rooms_on_account_id"
    t.index ["company_id"], name: "index_rooms_on_company_id"
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "industries", "industry_categories"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "employees"
  add_foreign_key "messages", "rooms"
  add_foreign_key "occupation_sub_categories", "occupation_main_categories"
  add_foreign_key "occupations", "occupation_sub_categories"
  add_foreign_key "rooms", "accounts"
  add_foreign_key "rooms", "companies"
end
