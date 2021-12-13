class Article < ApplicationRecord
  validates_presence_of :title, :content
  has_one_attached :image

  def serialized
    {
      id: id,
      title: title,
      image: if Rails.env.test?
               ActiveStorage::Blob.service.path_for(image.key)
             else
               image.service_url(expires_in: 1.hour, disposition: 'inline')
             end
    }
  end
end
