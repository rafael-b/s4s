class Answer < ActiveRecord::Base
#================================================================================================================================
#================================================================================================================================

  #--- associations
  belongs_to :result
  belongs_to :question
  
  belongs_to :quiz

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  # creates array of new objects 
  # and populates it from values found in quiz.questions
  def self.arr_of_new_from(qiz,usr=nil)
    arr = []
    if qiz
      qiz.questions.each do |q|
        if q.published && q.active
        
          ans = Answer.new

          ans.user_id    = usr.id if usr
          ans.quiz_id    = q.quiz_id
          ans.lecture_id = q.lecture_id || q.quiz.lecture_id
          ans.course_id  = q.course_id  || q.quiz.course_id

          ans.question_text = q.p_question_text
          ans.question_text = q.p_content if ans.question_text.blank?

          Question::ANSWER_PREFIX.each do |prefix|
            ans.send("answer_#{prefix}=",q.send("p_answer_#{prefix}"))
          end # do prefixes

          ans.display_id = q.display_id
          ans.position   = q.position
          ans.calc_pos   = q.calc_pos
        
          arr << ans

        end # if published and active
      end # do questions
    end # if qiz
    return arr.sort{|x,y| x.position <=> y.position}
  end
  
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

#================================================================================================================================
#================================================================================================================================
end
