class Asset < ApplicationRecord
  has_ancestry orphan_strategy: :adopt
end
