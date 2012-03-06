class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates_presence_of :text, :role_type, :category, :user


  scope :truth, where(['role_type = ?', 'truth'])
  scope :dare, where(['role_type = ?', 'dare'])

  def role_type=(role_type)
    if role_type == "truth" or role_type == "dare"
      write_attribute(:role_type, role_type)
    else
      errors.add(:role_type, "Should be truth or dare")
    end
  end
end
