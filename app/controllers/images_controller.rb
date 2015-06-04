# images_controller.rb
class ImagesController < ApplicationController
  def index
    unless image_params.empty?
      @image = Image.new(image_params)
      if stale?(@image)
        respond_to do |format|
          format.js
          format.html
        end
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    if params[:image]
      params[:registration] = params[:image][:registration]
      params[:reference] = params[:image][:reference]
      params.delete(:image)
    end
      params.permit(:reference, :registration)
  end
end
