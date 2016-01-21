# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  submitter_id :integer          not null
#  url_id       :integer          not null
#

class Visit < ActiveRecord::Base

  def self.record_visit!(user, shortened_url)
    Visit.create!(submitter_id: user.id, url_id: shortened_url.id)
  end

  belongs_to :user,
  foreign_key: :submitter_id,
  primary_key: :id,
  class_name: 'User'

  belongs_to :shortened_url,
  foreign_key: :url_id,
  primary_key: :id,
  class_name: 'ShortenedUrl'
end
