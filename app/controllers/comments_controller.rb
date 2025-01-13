class CommentsController < ApplicationController
  def index
    @list_of_comments = Comment.order(created_at: :desc)
    render(template: "comments/index")
  end

  def show
    the_id = params.fetch("path_id")
    @the_comment = Comment.where(id: the_id).first
    render(template: "comments/show")
  end

  def create
    the_comment = Comment.new
    # Typically we’d set the author_id = current_user.id,
    # but for now we’ll follow your form’s param:
    the_comment.author_id = params.fetch("query_author_id")
    the_comment.body = params.fetch("query_body")
    the_comment.photo_id = params.fetch("query_photo_id")

    # We let Rails set created_at / updated_at automatically.
    if the_comment.save
      redirect_to("/comments", notice: "Comment created successfully.")
    else
      redirect_to("/comments", alert: the_comment.errors.full_messages.to_sentence)
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_comment = Comment.where(id: the_id).first
    the_comment.author_id = params.fetch("query_author_id")
    the_comment.body = params.fetch("query_body")
    the_comment.photo_id = params.fetch("query_photo_id")

    if the_comment.save
      redirect_to("/comments/#{the_comment.id}", notice: "Comment updated successfully.")
    else
      redirect_to("/comments/#{the_comment.id}", alert: the_comment.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_comment = Comment.where(id: the_id).first
    the_comment.destroy

    redirect_to("/comments", notice: "Comment deleted successfully.")
  end
end
