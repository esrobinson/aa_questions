require 'sqlite3'
require_relative 'classes'

$db = SQLite3::Database.new("questions.db")
$db.results_as_hash = true
$db.type_translation = true

class QuestionsDatabase
end

u = User.find_by_id(2)
p u.followed_questions.first.followers