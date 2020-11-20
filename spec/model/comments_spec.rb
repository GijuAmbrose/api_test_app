require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it "is valid with valid attributes" do
    article = Article.create(name: 'The Hidden Story', author: 'Giju')
    comment = Comment.new(comment: "This is a wonderful book", article_id: article.id)
  	expect(comment).to be_valid
  end
  it "is not valid without a comment" do
  	comment = Comment.new(comment: nil)
  	expect(comment).to_not be_valid
  end
  it "is not valid without a article_id" do
    article = Article.create(name: 'The Hidden Story', author: 'Giju')
  	comment = Comment.new(article_id: nil)
  	expect(comment).to_not be_valid
  end

  describe "Associations" do
  it { should belong_to(:article).without_validating_presence }
  end
end
