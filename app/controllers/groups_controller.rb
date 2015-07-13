class GroupsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    @groups=Group.all
  end

  def show
    @group=Group.find(params[:id])
    @posts=@group.posts
  end

  def new
    @group=Group.new
  end

  def edit
    @group=current_user.groups.find(params[:id])
  end

  def create
    @group=current_user.groups.new(group_params)
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path, notice: 'Added successfully!'
    else
      render :new
    end
  end

  def update
    @group=current_user.groups.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "Modify successfully!"
    else
      render :edit
    end
  end

  def destroy
    @group=current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "Deleted successfully!"
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end


  def join
    @group=Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice]="Successfully joined!"
    else
      flash[:notice]="You have already join"
    end
    redirect_to groups_path(@group)
  end

  def quit
    @group=Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice]="Successful exits.";
    else
      flash[:alert]="Did not join!";
    end
    redirect_to groups_path(@group)
  end
end
