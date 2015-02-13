class City < ActiveRecord::Base
  paginates_per 5
  delegate :x, :y, to: :location

  scope :within, -> distance, to_point do
    to_point = self.point(*to_point) if to_point.is_a?(Array)
    self.where('st_distance(location, ?) <= ?', to_point, distance)
  end

  scope :starts_with, -> prefix do
    self.where('name LIKE ?', "#{prefix}%")
  end

  @@rgeo = RGeo::Cartesian.factory
  def self.point(*args)
    @@rgeo.point(*args)
  end
end
