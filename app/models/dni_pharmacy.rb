class DniPharmacy < ActiveRecord::Base
  belongs_to :user
  after_create :set_short_code

  def set_short_code
    hashids = Hashids.new 'DocAndI5', 5 ,'ABCDEFGHIJKLMNPQRSTUVWXYZ1234567890'
    self.short_code = hashids.encode(self.id)
    self.save
  end

end
