class QuestionLike
  def self.find_by_id(id)
    q_like_hash = $db.execute(<<-SQL, :q_like_id => id).first
      SELECT
        question_likes.*
      FROM
        question_likes
      WHERE
        question_likes.id = :q_like_id
    SQL

    QuestionLike.new(q_like_hash)
  end

  def self.likers_for_question_id(question_id)
    users = $db.execute(<<-SQL, :question_id => question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = :question_id
    SQL

    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = $db.execute(<<-SQL, :question_id => question_id).first
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_likes.question_id = :question_id
    SQL
    likes[0]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = $db.execute(<<-SQL, :user_id => user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = :user_id
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = $db.execute(<<-SQL, :n => n)
      SELECT
      questions.*
      FROM
      question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT 0, :n
    SQL

    questions.map{ |question| Question.new(question) }
  end


  attr_accessor :id, :question_id, :user_id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end