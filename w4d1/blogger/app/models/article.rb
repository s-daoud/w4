class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(", ").map(&:downcase).uniq
    possibles = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = possibles
  end
end
