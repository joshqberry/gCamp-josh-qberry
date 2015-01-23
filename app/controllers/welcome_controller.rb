class WelcomeController < ApplicationController

def index

  # @quotes =["gCamp has changed my life!  It's the best tool I've ever used.",
  #   "Before gCamp I was a disorderly slob.  Now I'm more organized than I've ever been.",
  #   "Don't hesitate -- sign up right now! You'll never be the same."]
  #
  #   @students =["Cayla Hayes", "Leta Jaskolski", "Lavern Upton"]


    @quotes = [["gCamp has changed my life!  It's the best tool I've ever used.", "Cayla Hayes"],
    ["Before gCamp I was a disorderly slob.  Now I'm more organized than I've ever been.", "Leta Jaskolski"],
    ["Don't hesitate -- sign up right now! You'll never be the same.", "Lavern Upton"]]


end
end
