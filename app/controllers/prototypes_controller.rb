class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user = User.new
    @prototypes = Prototype.all.order(id: "DESC")
  end

  def new
    @prototype = Prototype.new
  end

  def create
    # paramsの中身確認用
    # render plain: params[:prototype].inspect
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to prototypes_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to prototypes_path(prototype.id)
    else render edit_prototype_path
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
