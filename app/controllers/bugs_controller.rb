require 'csv'

class BugsController < ApplicationController
  # GET /bugs
  # GET /bugs.xml

  def filter

    session[:developer_to_filter] = params[:developer_to_filter] || []
    session[:status_to_filter] = params[:status_to_filter] || []
    session[:release_to_filter] = params[:release_to_filter] || []

    redirect_to(bugs_url)
 end

  def index
    conditions = {}

    session[:developer_to_filter] = session[:developer_to_filter] || [session[:user].id.to_s]
    session[:status_to_filter] = session[:status_to_filter] || Status.all(:conditions => ['category <> ?', 'done']).collect { |status| status.id.to_s }

    conditions[:developer_id] = session[:developer_to_filter] if session[:developer_to_filter] and !session[:developer_to_filter].empty?
    conditions[:status_id] = session[:status_to_filter] if session[:status_to_filter] and !session[:status_to_filter].empty?
    conditions[:release_id] = session[:release_to_filter] if session[:release_to_filter] and !session[:release_to_filter].empty?

    @bugs = Bug.all(:order => "priority", :conditions => conditions, :include => [:comments, :developer])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bugs }
    end
  end


  # GET /bugs/1
  # GET /bugs/1.xml
  def show
    @bug = Bug.find(params[:id])
    logger.info "*** " + @bug.inspect
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bug }
    end
  end

  # GET /bugs/new
  # GET /bugs/new.xml
  def new
    @bug = Bug.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bug }
    end
  end

  # GET /bugs/1/edit
  def edit
    @bug = Bug.find(params[:id])
  end

  # POST /bugs
  # POST /bugs.xml
  def create
    @bug = Bug.new(params[:bug])
   
    respond_to do |format|
      if @bug.save
        flash[:notice] = 'Bug was successfully created.'
        format.html { redirect_to(bugs_path) }
        format.xml  { render :xml => @bug, :status => :created, :location => @bug }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bugs/1
  # PUT /bugs/1.xml
  def update
    @bug = Bug.find(params[:id])
    @success = @bug.update_attributes(params[:bug])

    if (request.xhr?) then
      render :release_asssigned, :layout => false
    else
      respond_to do |format|
        if @success
          flash[:notice] = 'Bug was successfully updated.'
          format.html { render :action => "edit" }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def edit_release
    @bug = Bug.find(params[:id])
    @releases = Release.all(:order => "release_date DESC")
    render :layout => false
  end

  def update_status_or_release
    @bug = Bug.find(params[:id])

    previousRelease = @bug.release
    previousStatus = @bug.bug_status

    @bug.bug_status = Status.find(params[:status_id])
    @bug.release = Release.find(params[:release])
    @success = @bug.save

    if @success
      currentRelease = @bug.release
      currentStatus = @bug.bug_status

      render :update  do |page|
        #page.reload
        page.remove "task_#{@bug.id}"
        page.replace "release_div_#{previousRelease.id}", :partial => "/releases/release_board", :locals => {:release => previousRelease}
        page.replace "release_div_#{currentRelease.id}", :partial => "/releases/release_board", :locals => {:release => currentRelease}
        page.visual_effect :highlight,  "task_#{@bug.id}"
      end
    else
      render :update do |page|
        page.replace_html "results_text#{@bug.release.id}", @bug.errors.full_messages[0]
        page.show "results_#{@bug.release.id}"
      end
    end

  end


  # DELETE /bugs/1
  # DELETE /bugs/1.xml
  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to(bugs_url) }
      format.xml  { head :ok }
    end
  end


  def import

    respond_to do |format|
      format.html # new.html.erb
    end

  end


  def perform_import

    yet_to_start = Status.find_by_code("yet_to_start")

    parsed_file=CSV::Reader.parse(params[:dump][:file])
    new_bugs = 0
    existing_bugs = 0
    new_bug_list = ""
    existing_bugs_that_should_not_be_in_done_status = ""

    logger.info parsed_file.inspect

    parsed_file.each  do |row|
      logger.info row.inspect
      logger.info "********* Importing Bug " + row[1] + " **** "
      bug_results = Bug.all(:conditions => "defect_id = '#{row[1]}'" )
      if (bug_results.size > 0) then
        logger.info "--- Bug " + row[1] + " already exists"
        existing_bugs= existing_bugs+1
        
        existing_bug = bug_results[0]

        if row[5].casecmp("XS") == 0 or row[5].casecmp("QC") == 0
         logger.info row[5] + " ---------------- Not a customer issue -------------- "
        else
          logger.info row[5] + " is a customer issue"
          existing_bug.customer_issue = true
          existing_bug.customer = row[5]
          existing_bug.save_without_validation! 
        end

        if existing_bug.bug_status.category == 'done'
          existing_bugs_that_should_not_be_in_done_status = existing_bugs_that_should_not_be_in_done_status + existing_bug.defect_id.to_s + " (#{row[2]}), "
          logger.info "#{existing_bug.defect_id} (#{row[2]}) should not be in DONE state"
        end

      else
        bug=Bug.new
        bug.defect_type = row[0]
        bug.defect_id = row[1]
        bug.bug_status = yet_to_start
        bug.priority = row[3]
        bug.summary = row[4]
        bug.customer = row[5]

        logger.info "+++ Adding bug " + row[1]

        if bug.save
          new_bugs = new_bugs+1
          GC.start if new_bugs%50 == 0
        end
        new_bug_list = new_bug_list + row[1] + ","

      end
    end

    flash.now[:notice]="CSV Import,  #{new_bugs} new records (#{new_bug_list})added to data base, #{existing_bugs} bugs already exists in data base, #{existing_bugs_that_should_not_be_in_done_status} should not be in DONE status"

    render :action => "import"

  end
end
