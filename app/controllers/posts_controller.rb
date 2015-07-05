class PostsController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.new
  end

  def edit

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

  end

  def destroy

  end

  def post_params
    params.require(:post).permit(:content)
  end

end
