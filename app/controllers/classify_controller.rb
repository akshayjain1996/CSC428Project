class ClassifyController < ApplicationController

  # This is the route for the classify page. Here we return to the user a list of photos that need
  # classifying and the classifications available based on what they set.
  def index
    @photos = Photo.all.select{ |p| p.classification.blank? }
    @c1 = ApplicationController.classifications[0]
    @c2 = ApplicationController.classifications[1]
    @c3 = ApplicationController.classifications[2]
    @go_back = '1' if @photos.size == 1
    # If no photos need classifying, redirect to summary page.
    if @photos.size == 0
      redirect_to '/summary'
    end
  end

  # If user wants to re-classify a specific image, we will load that image
  # and send them back to the classification page. They can do this by clicking
  # image thumbnail in the summary page.
  def re_classify
    p = Photo.find_by_image_id(params['image_id'])
    p.classification = ''
    p.save
    @go_back = '1'
    redirect_to '/classify'
  end

  # Here the user sends us a image_id and what it should be classified as,
  # We translate the classification from index to string using what we have saved
  # in the application controller, and then update that photo with that classification,
  # and save it.
  def classify_post
    if params['up'].present?
      params['classification'] = '0'
    elsif params['right'].present?
      params['classification'] = '1'
    else
      params['classification'] = '2'
    end
    p = Photo.find_by_image_id(params['image_id'])
    p.classification = ApplicationController.classifications[params['classification'].to_i]
    p.save

    # Once we save the photo, continue classifying by redirecting the user to the classify page.
    redirect_to '/classify'
  end

  # This page gets all the photos available in the db, and the classifications, and sends it to the
  # summary form to show it in a nice way.
  def summary
    @photos = Photo.all
    @classifications = []
    id = 0
    ApplicationController.classifications.each do |c|
      o = OpenStruct.new(:name => c, :size => Photo.where(:classification => c).size, :id => id)
      id = id + 1
      @classifications << o
    end
  end
end
