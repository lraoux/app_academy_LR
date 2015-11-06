# drop all existing records
Response.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
Poll.destroy_all
User.destroy_all

user1 = User.create!(user_name: "John")
user2 = User.create!(user_name: "Emily")
user3 = User.create!(user_name: "Squirrel")
user4 = User.create!(user_name: "Owl")

poll1 = user1.polls.create!(title: "Favorite Foods")
poll2 = user2.polls.create!(title: "Worst Place to Live")

question1 = poll1.questions.create!(text: "Do you like peanut butter?")
question2 = poll1.questions.create!(text: "Do you like jello?")
question3 = poll2.questions.create!(text: "Do you live with 18 people in an Air B&B?")
question4 = poll2.questions.create!(text: "Do you live in a mansion?")

answer1 = question1.answer_choices.create!(text: "yes")
answer2 = question1.answer_choices.create!(text: "no")
answer3 = question2.answer_choices.create!(text: "yes")
answer4 = question2.answer_choices.create!(text: "no")
answer5 = question3.answer_choices.create!(text: "yes")
answer6 = question3.answer_choices.create!(text: "no")
answer7 = question4.answer_choices.create!(text: "yes")
answer8 = question4.answer_choices.create!(text: "no")

response1 = Response.create!({user_id: user3.id, answer_choice_id: answer1.id})
response2 = Response.create!({user_id: user4.id, answer_choice_id: answer1.id})
response3 = Response.create!({user_id: user3.id, answer_choice_id: answer4.id})
response4 = Response.create!({user_id: user4.id, answer_choice_id: answer5.id})
