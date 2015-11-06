require 'byebug'
require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    QuestionsDatabase.instance.execute(*args)
  end

end

class Users
  def self.find_by_id(id)
    results = QuestionsDatabase.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?;
    SQL

  #  debugger
    return nil unless results
  #  Users.new(results["id"], results["fname"], results["lname"])
    Users.new(results)
  end

  attr_accessor :id, :fname, :lname

  #def initialize(id, fname, lname)
    # @id = id
    # @fname = fname
    # @lname = lname
  def initialize(options)
    @id, @fname, @lname = options.values_at("id", "fname", "lname")
    # @id = options[:id]
    # @fname = options["fname"]
    # @lname = options["lname"]
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?,?);
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?;
      SQL
    end
  end


  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL

  #  debugger
    return nil unless results
    arr = []
    results.each do |user|
      arr << Users.new(user)
    end
    arr
  end

  def authored_questions
    Questions.find_by_author_id(self.id)
  end

  def authored_replies
    Replies.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionsFollows.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(self.id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id).first
    SELECT
      CAST(COUNT(DISTINCT(questions.id)) AS FLOAT) AS questions, COUNT(question_likes.question_id) AS likes
    FROM
      questions
    LEFT OUTER JOIN
      question_likes ON questions.id = question_likes.question_id
    WHERE
      question_likes.user_id != ?;
    SQL

    results["likes"] / results["questions"]
  end

end

class Questions
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?;
    SQL

  #  debugger
    return nil unless results
    Questions.new(results)
  end

  attr_accessor :id, :title, :body, :user_id
  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def self.find_by_author_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.user_id = ?;
    SQL

  #  debugger
    return nil unless results
    arr = []
    results.each do |question|
      arr << Questions.new(question)
    end
    arr
  end

  def author
    Users.find_by_id(@user_id)
  end

  def replies
    Replies.find_by_question_id(@id)
  end

  def followers
    QuestionsFollows.followers_for_question_id(self.id)
  end

  def self.most_followed(n)
    QuestionsFollows.most_followed_questions(n)
  end

  def likers
    QuestionLikes.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(self.id)
  end

  def self.most_likes(n)
    QuestionLikes.most_liked_questions(n)
  end



end

class QuestionsFollows
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        questions_follows
      WHERE
        questions_follows.id = ?;
    SQL

  #  debugger
    return nil unless results
    QuestionsFollows.new(results)
  end

  attr_accessor :id, :user_id, :question_id
  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        questions_follows
      JOIN
        questions ON questions_follows.question_id = questions.id
      JOIN
        users ON questions_follows.user_id = users.id
      WHERE
        questions.id = ?;
    SQL

  #  debugger
    # arr = []
    results.map do |result|
      Users.new(result)
    end
    # arr
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.*, COUNT(*)
      FROM
        questions_follows
      JOIN
        questions ON questions_follows.question_id = questions.id
      GROUP BY
        question_id;
      ORDER BY
        COUNT(*) ASC
    SQL

    results.map! do |result|
      Questions.new(result)
    end

    results.take(n)
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions_follows
      JOIN
        questions ON questions_follows.question_id = questions.id
      WHERE
        questions_follows.user_id = ?;
    SQL

  #  debugger
    # arr = []
    results.map do |result|
      Questions.new(result)
    end
    # arr
  end


end

class Replies
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?;
    SQL

  #  debugger
    return nil unless results
    Replies.new(results)
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body
  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.user_id = ?;
    SQL

  #  debugger
    return nil unless results
    arr = []
    results.each do |reply|
      arr << Replies.new(reply)
    end
    arr
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.question_id = ?;
    SQL

  #  debugger
    return nil unless results
    arr = []
    results.each do |question|
      arr << Replies.new(question)
    end
    arr
  end

  def author
    Users.find_by_id(@user_id)
  end

  def question
    Questions.find_by_id(@question_id)
  end

  def parent_reply
    Replies.find_by_id(@parent_id)
  end

  def child_replies
    current_replies = Replies.find_by_question_id(@question_id)
    arr = []
    current_replies.each do |reply|
      arr << reply if reply.parent_id == self.id
    end
    arr
  end

end


class QuestionLikes
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?;
    SQL

  #  debugger
    return nil unless results
    QuestionLikes.new(results)
  end

  attr_accessor :id, :user_id, :question_id
  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?;
    SQL

    results.map do |result|
      Users.new(result)
    end
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id).first
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
      GROUP BY
        question_id;
    SQL

    results.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    results.map do |result|
      Questions.new(result)
    end
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.*, COUNT(*)
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        question_id;
      ORDER BY
        COUNT(*) ASC
    SQL

    results.map! do |result|
      Questions.new(result)
    end

    results.take(n)
  end
end
