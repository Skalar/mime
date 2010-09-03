class Article
  include Mongoid::Document

  field :headword
  field :text
  field :location, :type => Array
  index [[ :location, Mongo::GEO2D ]]

  validates_presence_of :headword, :text
  validates :location, :location => true

  def lat
    self.location ? self.location[0] : nil
  end

  def lat=(latitude)
    return if latitude.blank?
    self.location ||= []
    self.location[0] = latitude
  end

  def lng
    self.location && self.location[1]
  end

  def lng=(longitude)
    return if longitude.blank?
    self.location ||= []
    self.location[1] = longitude
  end
end
