require_relative 'table'

class User < Table
  def self.find_by_id(id)
    user_hash = $db.execute(<<-SQL, :user_id => id).first
      SELECT
        users.*
      FROM
        users
      WHERE
        users.id = :user_id
    SQL

    User.new(user_hash)
  end

  def self.find_by_name(fname, lname)
    user_hash = $db.execute(<<-SQL, :fname => fname, :lname => lname).first
      SELECT
        users.*
      FROM
        users
      WHERE
        users.fname = :fname AND users.lname = :lname
    SQL

    User.new(user_hash)
  end

  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    likes = $db.execute(<<-SQL, :user_id => self.id).first
    SELECT
      COUNT(question_likes.question_id) * 1.0 /
      COUNT(DISTINCT questions.id)
    FROM
    questions
    LEFT JOIN
    question_likes ON questions.id = question_likes.question_id
    WHERE
    questions.user_id = :user_id
    SQL

    likes[0]
  end

end