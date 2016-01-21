class AddTimestampsTwo < ActiveRecord::Migration
  def change
    add_timestamps(:users)
    add_timestamps(:visits)
    add_timestamps(:shortened_urls)
  end
end
