module SessionsHelper

  def log_in(user)
        session[:user_id] = user.id
    end

def current_user
      if session[:user_id]
        @current_user = @current_user || User.find_by(id: session[:user_id])
      end
  end

  def logged_in?
        !current_user.nil?
    end

    def not_logged_in?
        current_user.nil?
    end

  def log_out
      session.delete(:user_id)
      @current_user = nil
      redirect_to login_path, notice: "You have deleted your record."
  end

  def not_admin?
    !current_user.admin?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

# Note that there are probably some cases remaining where a visitor might try to go to a page 
# that exists, but rather than get bumped to the login page, they get an error. This might
# interfere with a redirect upon logging in. But not sweating it for now.

end
