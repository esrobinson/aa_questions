class Tag < Table

  def self.most_popular(n)

    tags = $db.execute(<<-SQL, :n => n)
      SELECT
        tags.*
      FROM
        tags
      JOIN
        question_tags ON tags.id = question_tags.tag_id
      JOIN
        question_likes ON question_likes.question_id = question_tags.question_id
      GROUP BY
        tags.id
      ORDER BY
        COUNT(*) DESC
      LIMIT 0, :n
    SQL

    tags.map { |tag| Tag.new(tag) }

  end

  attr_accessor :id, :body

  def initialize(options)
    @id = options["id"]
    @body = options["body"]
  end

  def most_popular_questions(n)
    questions = $db.execute(<<-SQL, :tag_id => self.id, :n => n)
      SELECT
        questions.*
      FROM
        tags
      JOIN
        question_tags ON tags.id = question_tags.tag_id
      JOIN
        questions ON questions.id = question_tags.question_id
      JOIN
        question_likes ON question_likes.question_id = question_tags.question_id
      WHERE
        tags.id = :tag_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT 0, :n
    SQL

    questions.map { |question| Question.new(question) }
  end

end