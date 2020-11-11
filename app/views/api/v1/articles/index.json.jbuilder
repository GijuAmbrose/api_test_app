json.articles @articles do |article|
	json.author article.author
	json.name article.name
	json.created_at article.created_at
	json.comments article.comments do |comment|
		json.comment comment.comment
	end
end
