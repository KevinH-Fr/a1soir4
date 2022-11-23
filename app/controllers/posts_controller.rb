class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Posts", template: "posts/index", formats: [:html]
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.pdf do
     #  render pdf: "Post", template: "posts/show", formats: [:html]
     pdf = Grover.new(url_for()).to_pdf
     customFilename = "Parieurs_"".pdf"

       send_data(pdf, disposition: 'inline', filename: customFilename, 
                      type: 'application/pdf', format: 'A4')
      end
      format.png do
        #  png = Grover.new(url_for(only_path: false)).to_png
        png = Grover.new(url_for()).to_png
  
        customFilename = "Parieurs_"".png"
  
          send_data(png, disposition: 'inline', filename: customFilename, 
                         type: 'application/png', format: 'A4')
        end 
    end
  end

  def new
    @post = Post.new 
  end

  def edit
    @quantites = [1, 2]
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save

        PostMailer.with(user: current_user, post: @post).post_created.deliver_later

        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
     def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :title, :content, :quantite)
    end
end
