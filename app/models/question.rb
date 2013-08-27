class Question < ActiveRecord::Base
  versioned :dependent => :tracking
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff
  include Publishable

#--------------------------------------------------------------------------------------------------------------------------------


  ANSWER_PREFIX = %w(a b c d e f)

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- associations
  belongs_to :quiz
  
  belongs_to :course
  belongs_to :lecture

  #--- validations
  validates_presence_of   :code
  validates_presence_of   :quiz_id
  validates_presence_of   :display_id # 1=checkbox, 2=radio, 3=dropdown
  
  #--- scopes
  scope :ns_active,     :conditions => { :active => true }
  scope :ns_published,  :conditions => { :published => true }
  
  #--- callbacks
  before_save :before_save_tasks
  before_save :before_save_tasks_local
  
#--------------------------------------------------------------------------------------------------------------------------------

  def before_save_tasks_local
    self.answer_mask = 0
    i = 0
    ANSWER_PREFIX.each do |prefix|
      correct = self.send("correct_#{prefix}")
      self.answer_mask += ( 1 << i ) if correct
      i += 1
    end # do prefix
  end

#--------------------------------------------------------------------------------------------------------------------------------
end
