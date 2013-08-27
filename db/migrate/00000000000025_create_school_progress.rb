class CreateSchoolProgress < ActiveRecord::Migration
  def change

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    # created when user submits ernollment form
    # approved when the paument is cleared
    create_table :enrollments do |t|

      #--- mandatory bindings
      t.column :user_id,         :integer, :default => nil 
      t.column :course_id,       :integer, :default => nil

      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields (inherited from course?) 
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- form fields
      t.column :user_name,       :string,  :default => nil
      t.column :user_email,      :string,  :default => nil 
      t.column :reporting_email, :string,  :default => nil # the email to which notifications will ALSO be sent (if different than main)
      # if for new user, this user will need to be auto-created and registration email sent
      t.column :send_reports,    :boolean, :default => true # the email to which notifications will ALSO be sent (if different than main)

      # cert and card flags
      t.column :cert_requested,  :boolean, :default => false # true if physical cert requested
      t.column :card_requested,  :boolean, :default => false # true if wallet card requested
      t.column :cert_issued,     :boolean, :default => false # true if physical cert mailed
      t.column :card_issued,     :boolean, :default => false # true if wallet card mailed

      #--- payment and approval flags
      t.column :price,           :integer, :default => 0     # just remember the price, auto filled
      t.column :paid,            :boolean, :default => false # set when paypal happy
      t.column :approved,        :boolean, :default => false # set when above true or by CS action
      
      #--- passing and expiry info
      t.column :passed,          :boolean, :default => false
      t.column :passed_str,      :string,  :default => nil   # passed quizzes for this course
      t.column :passed_date,     :date # what date the course got passed (i.e. final exam passed)
      t.column :expiry_date,     :date # how long the cert is valid (counts from passed_date)
      t.column :failed,          :boolean, :default => false # course can get failed if max number of quizzes exceeded
      t.column :active,          :boolean, :default => true  # not expired and not failed

      #--- cc info for for submission, won't be stored
      t.column :cc_name,         :string,  :default => nil
      t.column :cc_type,         :string,  :default => nil
      t.column :cc_number,       :string,  :default => nil
      t.column :cc_cvs,          :string,  :default => nil
      t.column :cc_date,         :string,  :default => nil

      #--- generic processing fields
      t.column :creator_id,      :integer, :default => nil
      t.column :editor_id,       :integer, :default => nil
      t.timestamps
    end
    

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    # created when user submits quiz
    # stores quiz results and scores
    create_table :results do |t|

      #--- mandatory bindings
      t.column :user_id,        :integer, :default => nil
      t.column :quiz_id,        :integer, :default => nil

      #--- duplicate bindings (for efficiency and display)
      t.column :course_id,      :integer, :default => nil # duplicate association, hold better
      t.column :lecture_id,     :integer, :default => nil # duplicate association, hold better
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields (inherited from quiz?)
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- quiz results info
      t.column :submitted,      :boolean, :default => false # tru if user actually submits the quiz result
      t.column :date_taken,     :string,  :default => nil
      t.column :questions_n,    :integer, :default => 0     # number of questions, auto-calc
      t.column :correct_n,      :integer, :default => 0     # number of correct answers, calculated at submission
      t.column :score,          :integer, :default => 0     # score = correct_n / questions_n * 100% (rounded up)
      t.column :grade,          :string,  :default => 0     # letter grade: A,B,C,D,E, or F (from table)
      t.column :passed,         :boolean, :default => false # true if score higher or equal than required
      
      #--- generic processing fields
      t.column :creator_id,     :integer, :default => nil
      t.column :editor_id,      :integer, :default => nil
      t.timestamps
    end

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    # created when user submits quiz (as part of the above)
    # holds each of the answer as well as full question text
    create_table :answers do |t|
      
      #--- mandatory bindings
      t.column :result_id,      :integer, :default => nil
      t.column :question_id,    :integer, :default => nil
      
      #--- duplicate bindings (for efficiency and display)
      t.column :user_id,        :integer, :default => nil
      t.column :quiz_id,        :integer, :default => nil
      t.column :lecture_id,     :integer, :default => nil
      t.column :course_id,      :integer, :default => nil
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL

      #--- question info
      t.column :question_text,  :text # the actual text of the question
      t.column :question_a,     :string,  :default => nil
      t.column :question_b,     :string,  :default => nil
      t.column :question_c,     :string,  :default => nil
      t.column :question_d,     :string,  :default => nil
      t.column :question_e,     :string,  :default => nil
      t.column :question_f,     :string,  :default => nil
      
      #--- answer info
      t.column :answer_a,       :boolean, :default => false
      t.column :answer_b,       :boolean, :default => false
      t.column :answer_c,       :boolean, :default => false
      t.column :answer_d,       :boolean, :default => false
      t.column :answer_e,       :boolean, :default => false
      t.column :answer_f,       :boolean, :default => false

      #--- display info
      t.column :display_id,     :integer, :default => 1 # 1=checkbox, 2=radio, 3=dropdown
      t.column :position,       :integer, :default => 0
      t.column :calc_pos,       :integer, :default => 0
      
      #--- user input and evaluation
      t.column :answer_text,    :string,  :default => nil   # what user answered
      t.column :answer_code,    :string,  :default => nil   # answer letter (a,b,c,...)
      t.column :answer_mask,    :integer, :default => 0     # bitwise representation of user answers
      t.column :correct,        :boolean, :default => false # true if answer correct

      #--- generic processing fields
      t.column :creator_id,     :integer, :default => nil
      t.column :editor_id,      :integer, :default => nil
      t.timestamps
    end

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    # this will store all certificates and bind them to the user
    create_table :certificates do |t|
      
      #--- mandatory bindings
      t.column :user_id,        :integer, :default => nil
      t.column :course_id,      :integer, :default => nil

      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL

      #--- generic fields (inherited from course)
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- dedicated flags
      t.column :cert_issued,    :boolean, :default => false # yes if physical cert issued
      t.column :card_issued,    :boolean, :default => false # yes if wallet card issued
      
      #--- generic processing fields
      t.column :creator_id,     :integer, :default => nil
      t.column :editor_id,      :integer, :default => nil
      t.timestamps
    end
    
  end
end
