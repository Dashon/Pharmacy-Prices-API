class PharmacyEditRequest < ActiveRecord::Base
  belongs_to :dni_pharmacy
  belongs_to :user
end
