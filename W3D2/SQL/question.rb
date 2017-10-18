require_relative 'model'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'

class Question < Model

  attr_accessor :id, :title, :body, :user_id
  def initialize(options)
    super("questions")
    p options
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  # def save
    # if @id
    #   QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @id)
    #     UPDATE
    #       questions
    #     SET
    #       title = ?, body = ?, user_id = ?
    #     WHERE
    #       users.id = ?
    #   SQL
    # else
    #   QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
    #     INSERT INTO
    #       questions(title, body, user_id)
    #     VALUES
    #       (? , ? , ?)
    #   SQL
    # end
  # end
  #
  # def self.find_by_id(id)
  #   options = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT
  #       *
  #     FROM
  #       questions
  #     WHERE
  #       id = ?
  #   SQL
  #   Question.new(options.first)
  # end

  def self.find_by_title(title)
    options = QuestionsDatabase.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        title = ?
    SQL
    Question.new(options.first)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def author
    User.find_by_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    Question.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end
