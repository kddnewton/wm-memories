class PhotosController < ApplicationController

  # GET /photos/:id
  def show
    photo = Photo.find(params[:id])
    send_file photo.attachment.path, type: photo.attachment.content_type, disposition: 'inline'
  end
end
