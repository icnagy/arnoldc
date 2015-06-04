# images_controller.rb
class ImagesController < ApplicationController
  def index
    @image = Image.new(image_params) unless image_params.empty?
    if stale?(@image)
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    transform_params if params[:image]
    params.permit(:reference, :registration)
  end

  def transform_params
    params[:registration] = params[:image][:registration]
    params[:reference] = params[:image][:reference]
    params.delete(:image)
  end
end
