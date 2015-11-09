class Profile < ActiveRecord::Base
  belongs_to :user
  
  validate :first_last_not_null, :gender_check, :first_name_check
  def first_last_not_null
    if first_name.nil? && last_name.nil?
      errors.add(:firstname,"fist name and last name  can't be null ")
     end
  end
  def gender_check
    if !(gender == "male" or gender =="female")
      errors.add(:gender, "gender value wrong")
    end
  end
  def first_name_check
    if gender == "male" and first_name == "Sue"
      errors.add(:gender, "male gender nor sue")
    end
  end
  
end
