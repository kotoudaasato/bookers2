class UsersController < ApplicationController


  def index
    @user=current_user
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @book_new=Book.new
    @books=@user.books
  end

def edit
  if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
  else
    @user = current_user
    @book_new=Book.new
    @books=@user.books
    render:show
  end
end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to users_path(params[:id])
    else
      render:edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
