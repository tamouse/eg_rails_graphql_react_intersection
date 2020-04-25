class PostsController < ApplicationController
  before_action :set_author
  before_action :set_post, only: [:show, :edit, :update, :publish, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = authorize @author.present? ? @author.posts.all : Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    authorize @post
  end

  # GET /posts/new
  def new
    @post = authorize @author.present? ? @author.posts.build : Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = authorize @author.present? ?
              @author.posts.build(post_params) :
              Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/publish
  def publish
    authorize @post, :update?
    @post.publish!
    respond_to do |format|
      format.html { redirect_to @post, notice: "Post was successfully published." }
      format.json { render :show, status: :ok, location: @post }
    end
  end



  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = params[:user_id].present? ? User.find(params[:user_id]) : nil
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
