class BadgesController < ApplicationController
  before_filter :require_admin :only  => [:new, :edit, :create, :update, :destroy]
  
  def index
    @badges = Badge.all

    respond_to do |format|
      format.html
    end
  end


  def show
    @badge = Badge.find(params[:id])

    respond_to do |format|
      format.html
    end
  end


  def new
    @badge = Badge.new

    respond_to do |format|
      format.html
    end
  end


  def edit
    @badge = Badge.find(params[:id])
  end


  def create
    @badge = Badge.new(params[:badge])

    respond_to do |format|
      if @badge.save
        flash[:notice] = 'Badge was successfully created.'
        format.html { redirect_to(@badge) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @badge = Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        flash[:notice] = 'Badge was successfully updated.'
        format.html { redirect_to(@badge) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(badges_url) }
    end
  end
  
  
end
