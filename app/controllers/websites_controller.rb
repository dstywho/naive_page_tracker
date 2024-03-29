class WebsitesController < ApplicationController
  # GET /websites
  # GET /websites.xml
  def index
    @websites = Website.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @websites }
    end
  end
  
  def unique?(website)
   session[:website] ||= []
   (! session[:website].nil? ) && (! session[:website].include?(website.id)) && website.visits.where('ip = ?', request.remote_ip).empty?
  end

  # GET /websites/1
  # GET /websites/1.xml
  def show
    @website = Website.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @website }
      format.gif { render :nothing => true, :status => 200, :content_type => 'image/gif' }
    end
  end

def send_blank_gif
  send_data(Base64.decode64("R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="), :type => "image/gif", :disposition => "inline")
end

  def visit
    @website = Website.find(params[:id])
    visit = @website.visits.new
    visit.ip = request.remote_ip
    visit.unique = unique?(@website)
    visit.save
     
    session[:website] ||= []
    session[:website] << @website.id

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @website }
      format.gif { send_blank_gif }
    end

  end

  # GET /websites/new
  # GET /websites/new.xml
  def new
    @website = Website.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @website }
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
  end

  # POST /websites
  # POST /websites.xml
  def create
    @website = Website.new(params[:website])

    respond_to do |format|
      if @website.save
        format.html { redirect_to(@website, :notice => 'Website was successfully created.') }
        format.xml  { render :xml => @website, :status => :created, :location => @website }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @website.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.xml
  def update
    @website = Website.find(params[:id])

    respond_to do |format|
      if @website.update_attributes(params[:website])
        format.html { redirect_to(@website, :notice => 'Website was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @website.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.xml
  def destroy
    @website = Website.find(params[:id])
    @website.destroy

    respond_to do |format|
      format.html { redirect_to(websites_url) }
      format.xml  { head :ok }
    end
  end
end
