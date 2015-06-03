# images_controller.rb
class ImagesController < ApplicationController
  def index
    if params[:image]
      @image = Image.new(image_params)
      if stale?(@image)
        respond_to do |format|
          format.js
        end
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:registration, :reference)
  end
end
