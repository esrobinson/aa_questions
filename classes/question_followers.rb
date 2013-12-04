class QuestionFollowers
  def self.find_by_id(id)
    q_follower_hash = $db.execute(<<-SQL, :q_follower_id => id).first
      SELECT
        question_followers.*
      FROM
        question_followers
      WHERE
        question_followers.id = :q_follower_id
    SQL

    QuestionFollowers.new(q_follower_hash)
  end

  def self.followers_for_question_id(question_id)
    users = $db.execute(<<-SQL, :question_id => question_id)
      SELECT
        users.*
      FROM
        question_followers
      JOIN
        users ON question_followers.user_id = users.id
      WHERE
        question_followers.question_id = :question_id
    SQL

    users.map{ |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = $db.execute(<<-SQL, :user_id => user_id)
      SELECT
        questions.*
      FROM
        question_followers
      JOIN
        questions ON question_followers.question_id = questions.id
      WHERE
        question_followers.user_id = :user_id
    SQL

    questions.map{ |question| Question.new(question) }
  end


  attr_accessor :id, :user_id, :question_id
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end