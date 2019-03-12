class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new, :create]
  
  include LessonsHelper

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless @user == current_user
      redirect_to user_path(current_user)
    end
    
    @instruments = @user.instruments
    @subjects = @user.subjects
    @languages = @user.languages
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:warning] = 'メールアドレス認証を行なってください'
        format.html { redirect_to login_url }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[:danger] = 'ユーザー登録に失敗しました'
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = '編集が完了しました'
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        flash.now[:danger] = '編集に失敗しました'
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, instrument_ids: [], subject_ids: [], language_ids: [])
    end
end
