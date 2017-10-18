require_relative 'model'
require_relative 'user'
require_relative 'question'

class Reply < Model

  attr_accessor :question_id, :reply_id, :user_id, :body
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @reply_id = options['reply_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @reply_id, @user_id, @body, @id)
        UPDATE
          replies
        SET
          question_id = ?, reply_id = ?, user_id = ?, body = ?
        WHERE
          users.id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @reply_id, @user_id, @body)
        INSERT INTO
          replies(question_id, reply_id, user_id, body)
        VALUES
          (? , ? , ? , ?)
      SQL
    end
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(options.first)
  end

  def self.find_by_user_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    Reply.new(options.first)
  end

  def self.find_by_question_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    Reply.new(options.first)
  end

  def author
    User.find_by_id(@id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@reply_id)
  end

  def child_reply
    options = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL
    Reply.new(options.first)
  end
end
