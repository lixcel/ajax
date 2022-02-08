class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :authenticate_user!, only: [:following, :followers]


  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください。"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"])
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new

    if params[:sort_update]
      @books = @user.books.latest
      @today_book = @books.created_today
      @yesterday_book = @books.created_yesterday
      @this_week_book = @books.created_this_week
      @last_week_book = @books.created_last_week
    elsif params[:sort_star]
      @books = @user.books.star
      @today_book = @books.created_today
      @yesterday_book = @books.created_yesterday
      @this_week_book = @books.created_this_week
      @last_week_book = @books.created_last_week

    else
      @books = @user.books
      @today_book = @books.created_today
      @yesterday_book = @books.created_yesterday
      @this_week_book = @books.created_this_week
      @last_week_book = @books.created_last_week

    end

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(3)
  end

  def followers
    @user = User.find(params[:id])
    @users = @users.followers.page(params[:page]).per(3)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
