class Question
  def self.find_by_id(id)
    question_hash = $db.execute(<<-SQL, :question_id => id).first
      SELECT
        questions.*
      FROM
        questions
      WHERE
        questions.id = :question_id
    SQL

    Question.new(question_hash)
  end

  def self.find_by_author_id(author_id)
    question_hash = $db.execute(<<-SQL, :author_id => author_id)
      SELECT
        questions.*
      FROM
        questions
      WHERE
        questions.user_id = :author_id
    SQL

    question_hash.map { |question| Question.new(question) }
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(self.user_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollowers.followers_for_question_id(self.id)
  end

end