require 'sqlite3'
require_relative 'classes'

$db = SQLite3::Database.new("questions.db")
$db.results_as_hash = true
$db.type_translation = true

class QuestionsDatabase
end

Reply.new("question_id" => 1, "body" => "d", "user_id" => 1).save
