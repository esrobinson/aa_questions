class User
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
    Questions.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollowers.followed_questions_for_user_id(self.id)
  end

end