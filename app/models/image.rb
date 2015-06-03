# image.rb
class Image
  include ActiveModel::Model

  PICTURE_SIZE = %w(350 800)
  CAMERA_REFERENCE = %w(f i r 4 5 6 7 8 9 10 11 12)

  attr_accessor :registration, :reference

  validates :registration, presence: true, length: { minimum: 7 }
  validates :reference, presence: true, length: { minimum: 9 }

  def initialize(params = {})
    params.each do |attr, value|
      public_send("#{attr}=", value.upcase.strip.gsub(' ', ''))
    end if params
  end

  # create the obfuscated stock reference
  def obfuscated_stock_reference
    reference.chars.take(registration.length).zip(registration.reverse.chars).flatten.join << reference.chars[8]
  end

  # returns candidate images for the given registration and reference
  def candidate_images
    response = []
    # generate obfuscated stock reference
    osr = obfuscated_stock_reference
    # cache server address is stored in the environment
    image_cache = ENV['arnoldc_cache'] || 'http://vcache.arnoldclark.com/imageserver'
    PICTURE_SIZE.each do |size|
      CAMERA_REFERENCE.each do |camera|
        response << [image_cache, osr, size, camera].join('/')
      end
    end
    response
  end
end
