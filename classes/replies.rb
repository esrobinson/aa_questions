require_relative 'table'

class Reply < Table
  def self.find_by_id(id)
    reply_hash = $db.execute(<<-SQL, :reply_id => id).first
      SELECT
        replies.*
      FROM
        replies
      WHERE
        replies.id = :reply_id
    SQL

    Reply.new(reply_hash)
  end

  def self.find_by_question_id(question_id)
    replies = $db.execute(<<-SQL, :question_id => question_id)
      SELECT
        replies.*
      FROM
        replies
      WHERE
        replies.question_id = :question_id
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    replies = $db.execute(<<-SQL, :user_id => user_id)
      SELECT
        replies.*
      FROM
        replies
      WHERE
        replies.user_id = :user_id
    SQL

    replies.map{ |reply| Reply.new(reply) }
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    replies = $db.execute(<<-SQL, :id => self.id)
      SELECT
        replies.*
      FROM
        replies
      WHERE
        replies.parent_id = :id
    SQL

    replies.map{ |reply| Reply.new(reply) }
  end
end