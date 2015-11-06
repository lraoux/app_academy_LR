# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  text    :text             not null
#  poll_id :integer          not null
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # choices = self
    #   .answer_choices
    #   .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
    #   .group("answer_choices.id")
    #   .select("answer_choices.* , COUNT(responses.id) as count")

    # results_hash = Hash.new

    # choices.each do |choice|
    #   results_hash[choice.text] = choice.count
    # end

    # results_hash
    # results = Hash.new(0)
    # a_choices = self.answer_choices.includes(:responses)
    # a_choices.each do |choice|
    #   results[choice] += choice.responses.length
    # end
    # results

    a_choices_with_counts = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS responses_count")
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .group("answer_choices.id")

    a_choices_with_counts.map do |el|
      [el.text, el.responses_count]
    end
  end

end
