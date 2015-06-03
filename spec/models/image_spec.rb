require 'rails_helper'

describe Image do
  describe '.initialize' do
    it 'should validate registration number' do
      image = Image.new
      expect(image.valid?).to eq false
      expect(image.errors.full_messages).to include "Registration can't be blank"
      expect(image.errors.full_messages).to include 'Registration is too short (minimum is 7 characters)'
    end

    it 'should validate stock reference number' do
      image = Image.new
      expect(image.valid?).to eq false
      expect(image.errors.full_messages).to include "Reference can't be blank"
      expect(image.errors.full_messages).to include 'Reference is too short (minimum is 9 characters)'
    end

    it 'takes stock reference and registration number' do
      image = Image.new(reference: ' aBcD1234g ', registration: 'ab 12cde ')
      expect(image.valid?).to eq true
    end

    it 'should sanitize registration number' do
      image = Image.new(registration: ' ab12 34g ')
      expect(image.registration).to eq 'AB1234G'
    end

    it 'should sanitize stock reference number' do
      image = Image.new(reference: ' aBcD1234g ', registration: 'ab 12cde ')
      expect(image.reference).to eq 'ABCD1234G'
    end
  end

  describe '.obfuscated_stock_reference' do
    it 'calculates obfuscated stock reference' do
      image = Image.new(reference: ' abcd 1234g ', registration: ' ab 12cde ')
      expect(image.obfuscated_stock_reference).to eq 'AEBDCCD2112B3AG'
    end
    it 'handles false input as well' do
      image = Image.new(reference: ' abcd 1234g ', registration: ' ab 12cde ')
      expect(image.obfuscated_stock_reference).to eq 'AEBDCCD2112B3AG'
    end
  end

  describe '.candidate_images' do
    it 'should return correct number of images' do
      image = Image.new(reference: ' abcd 1234g ', registration: ' ab 12cde ')
      expect(image.candidate_images.length).to eq 24
    end
    it 'should return correct urls' do
      image = Image.new(reference: ' abcd 1234g ', registration: ' ab 12cde ')
      expect(image.candidate_images).to eq ['http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/f',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/i',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/r',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/4',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/5',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/6',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/7',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/8',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/9',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/10',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/11',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/350/12',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/f',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/i',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/r',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/4',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/5',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/6',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/7',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/8',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/9',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/10',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/11',
        'http://vcache.arnoldclark.com/imageserver/AEBDCCD2112B3AG/800/12']
    end
  end
end
