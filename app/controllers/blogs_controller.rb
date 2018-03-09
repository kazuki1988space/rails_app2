class BlogsController < ApplicationController
  before_action :set_params, only:[:show, :edit, :update, :destroy]
  before_action :logged_in?, only:[:new, :edit, :show]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    @blog.image.retrieve_from_cache! params[:cache][:image]

    if @blog.save
      BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render "new"
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render "edit"
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end

  def set_params
    @blog = Blog.find(params[:id])
  end

  def logged_in?
    if current_user.nil?
      flash[:danger] = "ログインして下さい"
      redirect_to new_session_path
    end
  end

end
