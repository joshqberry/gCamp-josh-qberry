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
end
