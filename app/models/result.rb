class Result < ActiveRecord::Base
#================================================================================================================================
#================================================================================================================================

  #--- associations
  belongs_to :user
  belongs_to :quiz
  
  belongs_to :course
  belongs_to :lecture
  
  has_many   :answers
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => proc {|attributes| attributes["_delete"] == "1"}
  
#--------------------------------------------------------------------------------------------------------------------------------

  # creates (saves) and returns a new Result object, including the associated Answer objets
  # the fields are pre-populated from supplied qiz and usr objects
  # the Answers populated from appropriate Question objects
  def self.create_from(qiz,usr)
    q = qiz
    r = Result.new
    if usr
      r.user_id = usr.id
    end # if usr
    if q
      r.quiz_id     = q.id
      r.lecture_id  = q.lecture_id
      r.course_id   = q.course_id
      r.code        = q.code
      r.name        = q.name
      r.title       = q.title
      r.description = q.description
      r.date_taken  = Date.today
    end # if q
    r.save(:validate=>false)
    
    #--- create answers
    if qiz
      qiz.questions.each do |q|
        if q.published && q.active
        
          ans = Answer.new

          ans.result_id     = r.id
          ans.user_id       = usr.id if usr
          ans.question_id   = q.id
          ans.quiz_id       = q.quiz_id
          ans.lecture_id    = q.lecture_id || q.quiz.lecture_id
          ans.course_id     = q.course_id  || q.quiz.course_id

          ans.question_text = q.p_question_text
          ans.question_text = q.p_content if ans.question_text.blank?

          Question::ANSWER_PREFIX.each do |prefix|
            ans.send("question_#{prefix}=",q.send("p_answer_#{prefix}"))
          end # do prefixes

          ans.display_id = q.display_id
          ans.position   = q.position
          ans.calc_pos   = q.calc_pos
        
          ans.save(:validate=>false)

        end # if published and active
      end # do questions
    end # if qiz
    
    return r
  end

#--------------------------------------------------------------------------------------------------------------------------------

  # evaluates all associated answers
  # - each Answer's mask should already be correctly determined (at Answer save)
  # - compare with appropriate Question's mask
  # - fill in the 'correct' value and re-save each Answer
  def evaluate_answers
    self.answers.each do |a|
      q = a.question
      a.correct = (a.answer_mask == q.answer_mask)
      a.save(:validate=>false)
    end
  end

  def calculate_score
    self.questions_n = (self.answers || []).size
    self.correct_n   = 0
    self.answers.each do |a|
      self.correct_n += 1 if a.correct
    end
    self.score  = ( self.correct_n.to_f / self.questions_n.to_f ) * 100.0
    self.passed = self.score >= self.quiz.passing_score
    self.save(:validate=>false)
  end

#================================================================================================================================
#================================================================================================================================
end
