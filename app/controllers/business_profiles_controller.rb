class BusinessProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @business_profiles = BusinessProfile.all
  end

  def show
    @business_profile = BusinessProfile.find(params[:id])
  end

  def new
    @business_profile = BusinessProfile.new
  end

  def create
    @business_profile = BusinessProfile.new(business_profile_params)
    if @business_profile.save
      redirect_to @business_profile, notice: 'Business Profile created successfully.'
    else
      render :new
    end
  end

  def edit
    @business_profile = BusinessProfile.find(params[:id])
  end

  def update
    @business_profile = BusinessProfile.find(params[:id])
    if @business_profile.update(business_profile_params)
      redirect_to @business_profile, notice: 'Business Profile updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @business_profile = BusinessProfile.find(params[:id])
    @business_profile.destroy
    redirect_to business_profiles_url, notice: 'Business Profile deleted successfully.'
  end

  private

  def business_profile_params
    params.require(:business_profile).permit(:name, :address, :contact_info)
  end
end
