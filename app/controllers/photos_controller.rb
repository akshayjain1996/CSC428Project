class PhotosController < ApplicationController
  def index
    @photos = Photo.all.select{ |p| !p.classification.blank? }
    @unclassified = Photo.all.select{ |p| p.classification.blank? }
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def create
    classifications = params['photo']['name'].split(/\s*,\s*/)
    ApplicationController.set_classifications(classifications)

    all_images = params['photo']['image'].select{ |e| e != '' }
    all_images.each do |image|
      t = {
          :name => image.original_filename,
          :image => image,
          :classification => ''
      }
      @photo = Photo.new(t)
      @photo.save
    end

    redirect_to '/classify'
  end
end
