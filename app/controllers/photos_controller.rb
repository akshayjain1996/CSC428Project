class PhotosController < ApplicationController
  # This is the library page, just return to user all photos so they can be rendered
  # on the page appropriately.
  def index
    @photos = Photo.all.select{ |p| !p.classification.blank? }
    @unclassified = Photo.all.select{ |p| p.classification.blank? }
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  # This is for creating a new classification session. Take the classifications provided,
  # and save them so we can later do index -> string translation.
  # Also store all the new photos, their data in the database and begin the classification process.
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
