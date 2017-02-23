class AdminController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin

  def index
    @users = User.all
    @startups = StartupProfile.all
    @interns = InternProfile.all
    @admins = User.where(role: 'admin')

    @matches = Match.all
    @categories = Category.all
    @locations = Location.all

    @job_listings = Listing.job_listings
    @active_interns = Listing.intern_listings.active
    @active_job_listings = Listing.job_listings.active

    @featured_startups = FeaturedStartup.all
    @display_featured_startups = Setting.display_featured_startups
  end

  def download
    respond_to do |format|
      klass = "#{params[:type].capitalize}Profile".constantize

      format.csv {
        filename = "#{params[:type].titleize}-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
        send_data(download_collection.to_a.to_csv(only: klass.csv_only), type: 'text/csv; charset=utf-8; header=present', filename: filename)
      }
    end
  end

  private

  def download_collection
    case params[:type]
    when 'intern'
      InternProfile.joins(:listing).joins(:user).joins(:category).joins("LEFT OUTER JOIN locations ON locations.id = listings.location_id").select('*')
    when 'startup'
      StartupProfile.all.joins(:user).select('*')
    end
  end
end
