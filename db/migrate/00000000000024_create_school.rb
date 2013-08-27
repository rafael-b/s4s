class CreateSchool < ActiveRecord::Migration
  def change

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    create_table :courses do |t|
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- publishable fields
      t.column :price,          :integer, :default => 2500 # main course enrollment price, in cents
      t.column :cert_price,     :integer, :default => 500  # physical mailed cert price, in cents
      t.column :card_price,     :integer, :default => 500  # wallet card price, in cents
      t.column :abstract,       :text
      t.column :content,        :text
      t.column :scripts,        :text
      t.column :styles,         :text
      
      #--- published fields
      t.column :p_price,        :integer, :default => 0
      t.column :p_abstract,     :text
      t.column :p_content,      :text
      t.column :p_scripts,      :text
      t.column :p_styles,       :text

      #--- last publishing date
      t.column :publish_date,   :datetime
      t.column :year,           :integer, :dafault => 0
      t.column :month,          :integer, :dafault => 0
      t.column :day,            :integer, :dafault => 0
      
      #---- dedicated non-publishable fields
      t.column :instructor,     :string,  :default => nil # instructor name, if any
      t.column :instructor_id,  :string,  :default => nil # instructor ID, if any
      t.column :lectures_n,     :integer, :default => 0   # number of lectures/quizzes (auto calc)

      t.column :enrollment_life,  :integer, :default => 365 # how many days is enrollment active (before needs to re-enroll or pass course)
      t.column :certificate_life, :integer, :default => 365 # how many days is cert active/valid (before need to take course again)

      #--- generic flags
      t.column :position,       :integer, :default => 0
      t.column :calc_pos,       :integer, :default => 0
      t.column :published,      :boolean, :default => false
      t.column :active,         :boolean, :default => true
      
      #--- generic processing fields
      t.column :creator_id,     :integer, :default => nil
      t.column :editor_id,      :integer, :default => nil
      t.timestamps
    end

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    create_table :lectures do |t|

      #--- mandatory bindings
      t.column :course_id,      :integer, :default => nil
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- publishable fields
      t.column :abstract,       :text
      t.column :content,        :text

      #--- published fields
      t.column :p_abstract,     :text
      t.column :p_content,      :text

      #--- last publishing date
      t.column :publish_date,   :datetime
      t.column :year,           :integer, :dafault => 0
      t.column :month,          :integer, :dafault => 0
      t.column :day,            :integer, :dafault => 0
      
      #--- generic flags
      t.column :position,       :integer, :default => 0
      t.column :calc_pos,       :integer, :default => 0
      t.column :published,      :boolean, :default => false
      t.column :active,         :boolean, :default => true

      #--- generic processing fields
      t.column :creator_id,      :integer, :default => nil
      t.column :editor_id,       :integer, :default => nil
      t.timestamps
    end
      

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    create_table :quizzes do |t|

      #--- mandatory bindings
      t.column :course_id,      :integer, :default => nil
      t.column :lecture_id,     :integer, :default => nil
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- publishable fields
      t.column :abstract,       :text
      t.column :content,        :text

      #--- published fields
      t.column :p_abstract,     :text
      t.column :p_content,      :text

      #--- last publishing date
      t.column :publish_date,   :datetime
      t.column :year,           :integer, :dafault => 0
      t.column :month,          :integer, :dafault => 0
      t.column :day,            :integer, :dafault => 0

      #---- dedicated non-publishable fields
      t.column :max_attampts,   :integer, :dafault => 3  # max number of attempts before course failed
      t.column :passing_score,  :integer, :default => 70 # what grade is required to pass this quiz in % 

      #--- generic flags
      t.column :position,       :integer, :default => 0
      t.column :calc_pos,       :integer, :default => 0
      t.column :published,      :boolean, :default => false
      t.column :active,         :boolean, :default => true

      #--- generic processing fields
      t.column :creator_id,      :integer, :default => nil
      t.column :editor_id,       :integer, :default => nil
      t.timestamps
    end

    #--------------------------------------------------------------------------
    #--------------------------------------------------------------------------
    create_table :questions do |t|

      #--- mandatory bindings
      t.column :quiz_id,        :integer, :default => nil
      
      #--- additional bindings
      t.column :lecture_id,     :integer, :default => nil
      t.column :course_id,      :integer, :default => nil
      
      #--- application info
      t.column :app_id,         :integer, :default => 1
      t.column :app_segment_id, :integer, :default => 7 # will be always SCHOOL
      
      #--- generic fields
      t.column :code,           :string,  :default => nil
      t.column :name,           :string,  :default => nil
      t.column :title,          :string,  :default => nil
      t.column :description,    :string,  :default => nil
      
      #--- publishable fields
      t.column :abstract,       :text # not sure how to use that
      t.column :content,        :text # not sure how to use that
      t.column :question_text,  :text # the actual text of the question
      t.column :answer_a,       :string,  :default => nil
      t.column :answer_b,       :string,  :default => nil
      t.column :answer_c,       :string,  :default => nil
      t.column :answer_d,       :string,  :default => nil
      t.column :answer_e,       :string,  :default => nil
      t.column :answer_f,       :string,  :default => nil
      t.column :correct_a,      :boolean, :default => false
      t.column :correct_b,      :boolean, :default => false
      t.column :correct_c,      :boolean, :default => false
      t.column :correct_d,      :boolean, :default => false
      t.column :correct_e,      :boolean, :default => false
      t.column :correct_f,      :boolean, :default => false
      t.column :correct_str,    :string,  :default => nil
      t.column :answer_mask,    :integer, :default => 0     # bitwise representation of correct answers

      #--- published fields
      t.column :p_abstract,     :text
      t.column :p_content,      :text
      t.column :p_question_text,:text
      t.column :p_answer_a,     :string,  :default => nil
      t.column :p_answer_b,     :string,  :default => nil
      t.column :p_answer_c,     :string,  :default => nil
      t.column :p_answer_d,     :string,  :default => nil
      t.column :p_answer_e,     :string,  :default => nil
      t.column :p_answer_f,     :string,  :default => nil
      t.column :p_correct_a,    :boolean, :default => false
      t.column :p_correct_b,    :boolean, :default => false
      t.column :p_correct_c,    :boolean, :default => false
      t.column :p_correct_d,    :boolean, :default => false
      t.column :p_correct_e,    :boolean, :default => false
      t.column :p_correct_f,    :boolean, :default => false
      t.column :p_correct_str,  :string,  :default => nil
      t.column :p_answer_mask,  :integer, :default => 0     # bitwise representation of correct answers

      #--- last publishing date
      t.column :publish_date,   :datetime
      t.column :year,           :integer, :dafault => 0
      t.column :month,          :integer, :dafault => 0
      t.column :day,            :integer, :dafault => 0

      #---- dedicated non-publishable fields
      t.column :display_id,     :integer, :default => 1 # 1=checkbox, 2=radio, 3=dropdown

      #--- generic flags
      t.column :position,       :integer, :default => 0
      t.column :calc_pos,       :integer, :default => 0
      t.column :published,      :boolean, :default => false
      t.column :active,         :boolean, :default => true

      #--- generic processing fields
      t.column :creator_id,     :integer, :default => nil
      t.column :editor_id,      :integer, :default => nil
      t.timestamps
    end
    
  end
end
