class ReleasesController < ApplicationController
  def new
    @release = Release.new
    render :release_details, :layout => false
  end

  def create
    @release = Release.new(params[:release])

    if @release.save then
      @releases = Release.all
      
      render :release_saved
    else
      render :release_form_with_errors, :layout => false
    end

  end

  def index
    @releases = Release.all(:order => "release_date DESC")
  end

  def report
    @releases = Release.all(:order => "release_date ASC")
  end


  def edit
    @release = Release.find(params[:id])
    render :release_details, :layout => false
  end

  def update
    @release = Release.find(params[:id])

    if @release.update_attributes(params[:release])
        @releases = Release.all
        render :release_saved
    else
        render :release_form_with_errors, :layout => false
    end

  end

  def destroy
    @release = Release.find(params[:id])
    @release.destroy

    @releases = Release.all

    render :release_saved
  end

  def taskboard

    if "all".eql?(params[:option])
      conditions = []
    else
      conditions = ["release_date >= ?", 1.day.ago]
    end

    @releases = Release.all :order => "release_date asc", :conditions => conditions, :include => [:bugs]
  end

end
