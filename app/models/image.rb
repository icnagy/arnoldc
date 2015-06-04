# image.rb
class Image
  include Comparable
  include ActiveModel::Model

  PICTURE_SIZE = %w(350 800)
  CAMERA_REFERENCE = %w(f i r 4 5 6 7 8 9 10 11 12)

  attr_accessor :registration, :reference

  validates :registration, presence: true, length: { minimum: 7 }, allow_blank: false
  validates :reference, presence: true, length: { minimum: 9 }, allow_blank: false

  def initialize(params = {})
    params.each do |attr, value|
      public_send("#{attr}=", value.upcase.strip.gsub(' ', ''))
    end if params
  end

  # create the obfuscated stock reference
  def obfuscated_stock_reference
    @obfuscated_stock_reference ||= obfuscate_stock_reference
  end

  def obfuscate_stock_reference
    reference.chars.take(registration.length).zip(registration.reverse.chars).flatten.join << reference.chars[8]
  end

  def cache_key
    @cache_key ||= 'images/' + [registration, reference].join('_')
  end

  def updated_at
    @updated_at ||= Time.new(2015)
  end

  def image_cache
    @image_cache ||= ENV['arnoldc_cache'] || 'http://vcache.arnoldclark.com/imageserver'
  end

  # returns candidate images for the given registration and reference
  def candidate_images
    response = []
    PICTURE_SIZE.each do |size|
      CAMERA_REFERENCE.each do |camera|
        response << [image_cache, obfuscated_stock_reference, size, camera].join('/')
      end
    end
    response
  end

  # returns candidate images cached for the given registration and reference
  def candidate_images_cached
    Rails.cache.fetch("#{obfuscated_stock_reference}", expires_in: 20.minutes) do
      candidate_images
    end
  end

  def <=>(anOther)
    registration <=> anOther.registration
  end
end
