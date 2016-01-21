# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base

  validates_length_of :topic, :minimum => 2, :maximum => 1024, :allow_blank => false

  has_many :taggings,
  foreign_key: :tag_id,
  primary_key: :id,
  class_name: 'Tagging'

  has_many :shortened_urls,
  through: :taggings,
  source: :shortened_url
end
