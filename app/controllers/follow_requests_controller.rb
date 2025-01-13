class FollowRequestsController < ApplicationController
  def index
    @list_of_follow_requests = FollowRequest.order(created_at: :desc)
    render(template: "follow_requests/index")
  end

  def show
    the_id = params.fetch("path_id")
    @the_follow_request = FollowRequest.where(id: the_id).first
    render(template: "follow_requests/show")
  end

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.status = params.fetch("query_status", "pending")

    if the_follow_request.save
      redirect_to("/follow_requests", notice: "Follow request created successfully.")
    else
      redirect_to("/follow_requests", alert: the_follow_request.errors.full_messages.to_sentence)
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where(id: the_id).first
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.status = params.fetch("query_status", "pending")

    if the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", notice: "Follow request updated successfully.")
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", alert: the_follow_request.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where(id: the_id).first
    the_follow_request.destroy

    redirect_to("/follow_requests", notice: "Follow request deleted successfully.")
  end
end
