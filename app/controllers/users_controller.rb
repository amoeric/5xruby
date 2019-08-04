class UsersController < VerificationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :find_user, except: [:index, :new, :create]
  
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      login(@user)
      redirect_to user_missions_path(@user), notice: I18n.t("notice.new_user_success")
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update(params_user)
      login(@user)
      redirect_to user_missions_path(@user), notice: I18n.t("notice.edit_user_success")
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: I18n.t("notice.delete_user_success")
    else
      render :index
    end
  end

  private
  def params_user
    params.require(:user).permit(:email, :password, :role, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end