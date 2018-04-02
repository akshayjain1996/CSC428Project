require 'zip/zip'

class DownloadController < ApplicationController
  def c0
    download '0'
  end

  def c1
    download '1'
  end

  def c2
    download '2'
  end

  def download(c)
    file_name = "#{c}_at_#{Time.current.utc.to_i}.zip"

    Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) do |zip|
      Photo.where(:classification => ApplicationController.classifications[c.to_i]).each do |img|
        begin
          zip.add img.name, "#{Rails.root}/tmp/uploads/store/#{img.image_id}"
        rescue => e
        end
      end
      zip.close
      send_file file_name, :type => 'application/zip', :disposition => 'attachment', :filename => file_name
    end
  end
end
