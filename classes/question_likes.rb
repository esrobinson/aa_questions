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

  attr_accessor :id, :question_id, :user_id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end