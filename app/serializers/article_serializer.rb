class ArticleSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :genre,
             :created_at,
             :updated_at
end
