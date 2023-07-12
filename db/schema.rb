# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_10_224526) do
  create_table "books", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.integer "year"
    t.integer "npages"
  end

  create_table "books_tags", id: false, force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "tag_id", null: false
    t.index ["book_id", "tag_id"], name: "index_books_tags_on_book_id_and_tag_id"
    t.index ["tag_id", "book_id"], name: "index_books_tags_on_tag_id_and_book_id"
  end

  create_table "books_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.index ["book_id", "user_id"], name: "index_books_users_on_book_id_and_user_id"
    t.index ["user_id", "book_id"], name: "index_books_users_on_user_id_and_book_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jwt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "director"
    t.integer "year"
  end

  create_table "movies_tags", id: false, force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "tag_id", null: false
    t.index ["movie_id", "tag_id"], name: "index_movies_tags_on_movie_id_and_tag_id"
    t.index ["tag_id", "movie_id"], name: "index_movies_tags_on_tag_id_and_movie_id"
  end

  create_table "movies_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "movie_id", null: false
    t.index ["movie_id", "user_id"], name: "index_movies_users_on_movie_id_and_user_id"
    t.index ["user_id", "movie_id"], name: "index_movies_users_on_user_id_and_movie_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.text "movie"
    t.text "book"
    t.text "show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "director"
    t.integer "year"
  end

  create_table "shows_tags", id: false, force: :cascade do |t|
    t.integer "show_id", null: false
    t.integer "tag_id", null: false
    t.index ["show_id", "tag_id"], name: "index_shows_tags_on_show_id_and_tag_id"
    t.index ["tag_id", "show_id"], name: "index_shows_tags_on_tag_id_and_show_id"
  end

  create_table "shows_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "show_id", null: false
    t.index ["show_id", "user_id"], name: "index_shows_users_on_show_id_and_user_id"
    t.index ["user_id", "show_id"], name: "index_shows_users_on_user_id_and_show_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "preferences", "users"
end
