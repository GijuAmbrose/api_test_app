require 'rails_helper'

RSpec.describe Article, :type => :model do
  it "is valid with valid attributes" do
  	article = Article.new(name: 'The Hidden Story', author: 'Giju')
  	expect(article).to be_valid
  end
  it "is not valid without a name" do
  	article = Article.new(name: nil)
  	expect(article).to_not be_valid
  end
  it "is not valid without a author" do
  	article = Article.new(author: nil)
  	expect(article).to_not be_valid
  end
end
