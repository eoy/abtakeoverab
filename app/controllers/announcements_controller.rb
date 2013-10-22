class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:edit, :update, :destroy]
  before_action :check_session

  include Wicked::Wizard
  # load_and_authorize_resource

  steps :select_language, :select_country, :accept_terms, :refuse, :index


  # GET /announcements
  # GET /announcements.json
  def index
    if params[:accepted] || session[:accepted] == true
      @announcements = Announcement.all
      session[:accepted] = true
      session[:updated_at] = Time.now
    else
      redirect_to wizard_path(:select_language)
    end
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    @user = current_user || User.new
    case step
    when :select_language
      skip_step if I18n.locale.present?
    end

    case step
    when :select_country
      session[:locale] = params[:locale]
    end

    case step
    when :accept_terms
      session[:country] = params[:user][:country]
    end

    case step
    when :refuse
    end
    render_wizard
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(permitted_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to announcements_path, notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(permitted_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end

  def finish_wizard_path
    announcements_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_params
      params.require(:announcement).permit(:title, :description, :document, :document_cache)
    end

    # Forget about the user accepting the terms after a time has passed
    def check_session
      session.delete("accepted") if session[:updated_at].present? && session[:updated_at].to_time <= 10.minutes.ago
    end
end
