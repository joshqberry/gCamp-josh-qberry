class FaqController < ApplicationController

# Note: The requirement was to name this controller "common_questions", but I simply could not
# figure out how to do that without having to change other stuff. Just wanted to make a note here
#   to avoid confusion later...

  def index

    @common_question1 = CommonQuestion.new
    @common_question1.question = "What is gCamp?"
    @common_question1.answer = "gCamp is an awesome tool that is going to change your life.
    gCamp is your one stop shop to organize all your tasks.
    You'll also be able to track comments that you and others make.
    gCamp may eventually replace all need for paper and pens in the entire world.
    Well, maybe not, but it's going to be pretty cool."
    @common_question1.slug = "what-is-gcamp"

    @common_question2 = CommonQuestion.new
    @common_question2.question = "How do I join gCamp?"
    @common_question2.answer = "As soon as it's ready for the public, you'll see a signup link
    in the upper right. Once that's there, just click it and fill in the form!"
    @common_question2.slug = "how-do-i-join-gcamp"

    @common_question3 = CommonQuestion.new
    @common_question3.question = "When will gCamp be finished?"
    @common_question3.answer = "gCamp is a work in progress.
    That being said, it should be fully functional in the next few weeks.
    Functional.
    Check in daily for new features and awesome functionality.
    It's going to blow your mind. Organization is just a click away.
    Amazing!"
    @common_question3.slug = "when-will-gcamp-be-finished"

    @common_questions = [@common_question1, @common_question2, @common_question3]




  end
end
