class CommentsController < ApplicationController
	before_action :require_user
	before_action :set_post_and_comment, only: [:vote]

	def create
		# binding.pry

    @post = Post.find_by(title_slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
			flash[:notice] = 'Your comment was added'
			redirect_to post_path(@post)
		else
      # binding.pry
			render 'posts/show'
		end
	end

	def vote
		@vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
		# binding.pry
		respond_to do |format|
			format.html do
				if @vote.valid?
					flash[:notice] = "Your vote was counted."
				else
					flash[:error] = "You can only vote on a comment once."
				end
				redirect_to :back
			end
			format.js do
				# binding.pry
			end
		end
	end

	def set_post_and_comment
		# binding.pry
		@post = Post.find_by(title_slug: params[:post_id])
		# @comment = @post.comments.find_by(params[:id])
		@comment = Comment.find(params[:id])
	end
end
