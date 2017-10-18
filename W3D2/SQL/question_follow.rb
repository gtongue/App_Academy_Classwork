
require_relative 'model'
require_relative 'user'
require_relative 'question'
require 'byebug'

class QuestionFollow
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.followers_for_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id
      FROM
        users
      JOIN
        question_follows
      ON
        question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL
    users = []
    options.each do |user_id|
      users << User.find_by_id(user_id['id'])
    end
    users
  end

  def self.followed_questions_for_user_id(user_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_follows.question_id
      FROM
        question_follows
      JOIN
        users
      ON
        question_follows.user_id = users.id
      WHERE
        question_follows.user_id = ?
    SQL
    questions = []
    options.each do |question_id|
      questions << Question.find_by_id(question_id['question_id'])
    end
    questions
  end

  def self.most_followed_questions(n)
    options = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_follows.question_id, COUNT(question_follows.question_id)
      FROM
        question_follows
      GROUP BY
        question_follows.question_id
      ORDER BY
        COUNT(question_follows.question_id)
      LIMIT ?
    SQL
    questions = []
    options.each do |question_id|
      questions << Question.find_by_id(question_id['question_id'])
    end
    questions
  end
end
