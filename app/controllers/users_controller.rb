class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if current_user.admin?
      @user = User.new(user_admin_params)
   else
     @user = User.new(user_params)
  end

    # Note from me JQ regarding the following code: the "do" is a RUBY block,
    # and the "|format|" could be anything. It's just a variable to use inside that block.

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "User was successfully created."}
        # format.html { redirect_to @user, :flash => { :success => "User was successfully created." } }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json


  def update
    respond_to do |format|
      if current_user.admin?
        if @user.update(user_admin_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end

     else

      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  end
end

  # DELETE /users/1
  # DELETE /users/1.json


    def destroy
      @user = User.find(params[:id])
      @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    end

    def user_admin_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
      :admin)
    end
end
