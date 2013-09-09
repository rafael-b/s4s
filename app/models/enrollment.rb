class Enrollment < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- associations
  belongs_to :user
  belongs_to :course

  #--- validations
  validates_presence_of   :course_id
  validates_presence_of   :user_email

  validates_presence_of   :cc_name
  validates_presence_of   :cc_type
  validates_presence_of   :cc_number
  validates_presence_of   :cc_cvs
  validates_presence_of   :cc_date
  validate :assure_human

  def assure_human
    if self.security_question_id &&  !RCaptcha::ANSWERS[self.security_question_id.to_i].include?(self.security_answer.to_s.downcase)
      errors.add(:security_answer, "must be correct - prove that you are human!")
      self.security_answer_invalid = true
    else
      self.security_answer_invalid = false
    end
  end
    
  #--- callbacks
  before_save :before_save_tasks_local
  
  #--- additional attributes
  attr_accessor :security_question_id
  attr_accessor :security_answer
  attr_accessor :security_answer_invalid
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def status_str
    s = "<span class='status active'>active</span>"
    if self.active
      if self.failed
        s = "<span class='status failed'>failed</span>"
      elsif self.passed
        s = "<span class='status failed'>passed</span>"
      end
    else
      s = "<span class='status disabled'>inactive</span>"
    end # if active
    return s.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def before_save_tasks_local
    verify_user_existance
    return true
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def verify_user_existance
    return if self.user
    usr = User.first(:conditions=>{:email=>self.user_email.downcase})
    if !usr # no usr found, so create one
      usr         = User.new
      usr.email   = self.user_email.downcase
      usr.name    = self.user_name
      usr.role_id = User::STUDENT
      password    = 'fluffy'
      usr.password              = password
      usr.password_confirmation = password
      usr.save
    end # if !usr
    self.user_id   = usr.id
    self.user_name = usr.name
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
