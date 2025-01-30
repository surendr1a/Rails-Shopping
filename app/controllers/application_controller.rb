class ApplicationController < ActionController::Base
  # Allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Check if the user is authenticated
  # before_action :authenticate_user!

  # Error handling for common exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    redirect_to root_path, alert: "The record you're looking for doesn't exist."
  end
end
