class PostsController < ApplicationController

  before_action :find_group

  def new
    @post = @group.posts.new
  end

  def edit
    @post = @group.posts.find(params[:id])
  end

  def create
    @post=@group.posts.new(post_params)

    if @post.save
      redirect_to group_path(@group), notice: '新增文章成功！'
    else
      reder :new
    end
  end

  def update
    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: '文章修改成功！'
    else
      render :edit
    end
  end

  def destroy
    @post=@group.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group)
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

end
