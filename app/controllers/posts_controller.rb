class PostsController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:id])
  end

  def create
    @group=Group.find(params[:group_id])
    @post=@group.posts.new(post_params)

    if @post.save
      redirect_to group_path(@group), notice: '新增文章成功！'
    else
      reder :new
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: '文章修改成功！'
    else
      render :edit
    end
  end

  def destroy
    @group=Group.find(params[:group_id])
    @post=@group.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group)
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
