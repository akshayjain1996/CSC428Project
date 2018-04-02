class ClassifyController < ApplicationController
  def index
    @photos = Photo.all.select{ |p| p.classification.blank? }
    @c1 = ApplicationController.classifications[0]
    @c2 = ApplicationController.classifications[1]
    @c3 = ApplicationController.classifications[2]
    @go_back = '1' if @photos.size == 1
    if @photos.size == 0
      redirect_to '/summary'
    end
  end

  def re_classify
    p = Photo.find_by_image_id(params['image_id'])
    p.classification = ''
    p.save
    @go_back = '1'
    redirect_to '/classify'
  end

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
    redirect_to '/classify'
  end

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
