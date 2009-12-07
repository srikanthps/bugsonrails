class CommentsController < ApplicationController
  def index
    @comments = Comment.all()

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end


  def new
    @bug = Bug.find(params[:bug_id])
    @comment = @bug.comments.build
    @comment.status = "Open"

    case @bug.status
      when  "Working on it"
        @comment.comment_type = Comment::DEVELOPER_NOTE
      when "Yet to start"
        @comment.comment_type = Comment::ADDITIONAL_REQUIREMENT
      when "Code review, please!"
        @comment.comment_type = Comment::REVIEW
      when "Done", "Considered already fixed", "Verified - Not a issue", "Closed as not an issue"
        @comment.comment_type = Comment::QA_FAILURE
      else
        @comment.comment_type = Comment::ADDITIONAL_REQUIREMENT
    end

    render :layout=>false

  end

  def create
    @bug = Bug.find(params[:bug_id])
    @comment = @bug.comments.build(params[:comment])

    success = @comment.save
    if (!request.xhr?) then
      if success
        redirect_to edit_bug_url(@bug)
      else
        render :action => "new"
      end
    else
      render :comment_status
    end

  end

  def edit
    @bug = Bug.find(params[:bug_id])
    @comment = Comment.find(params[:id])
    render :layout => false
  end

  def update_comment_type
    comment = Comment.find(params[:id])
    if (comment)
      comment.comment_type = params[:comment_type]
      comment.save
    end
    redirect_to :action => "index"
  end

  def update_comment_type_ajax
    comment = Comment.find(params[:id])
    if (comment)
      comment.comment_type = params[:comment_type]
      comment.save
    end
    render :partial => "comments_manage_links", :locals => { :comment => comment, :comment_index => params[:comment_index] }, :layout=>false

  end

  def update
    @bug = Bug.find(params[:bug_id])
    @comment = Comment.find(params[:id])

    success = @comment.update_attributes(params[:comment])
    if (!request.xhr?) then
      if success
          flash[:notice] = "Comment was successfully updated."
          redirect_to edit_bug_url(@bug)
      else
          render :action => "edit"
      end
    else
      render :comment_status, :layout => false;
    end

  end

  def destroy
    @bug = Bug.find(params[:bug_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(edit_bug_url(@bug)) }
      format.xml  { head :ok }
    end
  end

end
