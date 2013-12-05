require 'sqlite3'
require_relative 'classes'

$db = SQLite3::Database.new("questions.db")
$db.results_as_hash = true
$db.type_translation = true

class QuestionsDatabase
end

p Tag.most_popular(1).first.most_popular_questions(1)
