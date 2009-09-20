class LorriesController < ApplicationController
  before_filter :create_suffix, :only => :create

  # GET /lorries
  # GET /lorries.xml
  def index
    @lorries = Lorry.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lorries }
    end
  end

  # GET /lorries/1
  # GET /lorries/1.xml
  def show
    @lorry = Lorry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lorry }
    end
  end

  # GET /lorries/new
  # GET /lorries/new.xml
  def new
    @lorry = Lorry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lorry }
    end
  end

  # GET /lorries/1/edit
  def edit
    @lorry = Lorry.find(params[:id])
  end

  # POST /lorries
  # POST /lorries.xml
  def create
    params[:lorry][:name] << @suffix
    @lorry = Lorry.new(params[:lorry])

    respond_to do |format|
      if @lorry.save
        flash[:notice] = 'Lorry was successfully created.'
        format.html { redirect_to(@lorry) }
        format.xml  { render :xml => @lorry, :status => :created, :location => @lorry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lorry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lorries/1
  # PUT /lorries/1.xml
  def update
    @lorry = Lorry.find(params[:id])

    respond_to do |format|
      if @lorry.update_attributes(params[:lorry])
        flash[:notice] = 'Lorry was successfully updated.'
        format.html { redirect_to(@lorry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lorry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lorries/1
  # DELETE /lorries/1.xml
  def destroy
    @lorry = Lorry.find(params[:id])

    if @lorry.colour == "blue"
      raise "Are you crazy? You can't destroy a blue lorry!!"
    end

    @lorry.destroy

    respond_to do |format|
      format.html { redirect_to(lorries_url) }
      format.xml  { head :ok }
    end
  end

private

  def create_suffix
    @suffix = " - this is from before filter"
  end
end
