class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy, :new, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :new, :destroy]



  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

def edit
end

def update
  @prototype.update(prototype_params)
  if @prototype.update(prototype_params)
    redirect_to @prototype
  else
    render :edit
  end
end

def destroy
  @prototype.destroy
  redirect_to root_path
end
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
def set_prototype
  @prototype = Prototype.find(params[:id])
end
  def move_to_index
     if @prototype.user.id != current_user.id
      redirect_to root_path
     end
  end
 end

