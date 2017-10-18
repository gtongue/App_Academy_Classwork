require_relative 'model'
require_relative 'user'
require_relative 'question'


class QuestionLike < Model

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    users = []
    options.each do |user_id|
      users << User.find_by_id(user_id['id'])
    end
    users
  end

  def self.num_likes_for_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(users.id)
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    options.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_likes.question_id
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.user_id = ?
    SQL
    questions = []
    options.each do |question_id|
      questions << Question.find_by_id(question_id['question_id'])
    end
    questions
  end

  def self.most_liked_questions(n)
    options = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_likes.question_id
      FROM
        question_likes
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(question_likes.question_id)
      LIMIT ?
    SQL
    questions = []
    p options
    options.each do |question_id|
      questions << Question.find_by_id(question_id['question_id'])
    end
    questions
  end
end
