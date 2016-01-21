# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true

  belongs_to :submitter,
  foreign_key: :submitter_id,
  primary_key: :id,
  class_name: 'User'

  has_many :visits,
  foreign_key: :url_id,
  primary_key: :id,
  class_name: 'Visit'

  has_many :visitors,
  through: :visits,
  source: :user

  has_many :distinct_visitors,
  Proc.new { distinct },
  through: :visits,
  source: :user

  has_many :tag_topics,
  through: :taggings,
  source: :tag_topic

  def self.random_code
    url = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(:short_url => url)
      url = SecureRandom::urlsafe_base64
    end
    url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    distinct_visitors.count
  end

  def num_recent_uniques
    visits.uniq{|x| x.submitter_id}.select{|visit| Time.now - visit.created_at <= 600}.count

  end


end
