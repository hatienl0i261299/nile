class Book < ApplicationRecord
    # https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/
    has_and_belongs_to_many :authors
end
