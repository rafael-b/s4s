class SchoolController < ApplicationController
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
  
  layout "school"
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def index
    @objects = Course.all(:conditions=>{:published=>true,:active=>true})
    @page    = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'index'})
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def show
    @id       = params[:id].to_s
    @object   = Course.first(:conditions=>{:published=>true,:active=>true,:id=>@id})
    @lectures = @object.lectures || []
    @page     = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'course'})
  end
  
  def lecture
    @id     = params[:id].to_s
    @object = Lecture.first(:conditions=>{:published=>true,:active=>true,:id=>@id})
    @course = @object.course
    @page   = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'lecture'})
  end
  
#--------------------------------------------------------------------------------------------------------------------------------

  def enroll
    @id     = params[:id]
    @course = Course.first(:conditions=>{:published=>true,:active=>true,:id=>@id})
    if @course
      @object = Enrollment.new
      
      @object.course_id  = @course.id

      @object.code = @course.code
      @object.name = @course.name
      @object.title = @course.title
      @object.description = @course.description

      @object.security_answer = ''
      @object.security_question_id = rand(RCaptcha::QUESTIONS.size)
      @security_question = RCaptcha::QUESTIONS[@object.security_question_id.to_i]

      if current_user
        @object.creator_id = current_user.id
        @object.user_id    = current_user.id
        @object.user_name  = current_user.name
        @object.user_email = current_user.email
        @object.reporting_email = current_user.email
      end
    end
    @page   = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'enroll'})
  end
  
  def enroll_submit
    @object = Enrollment.new(params[:enrollment])
    @course = Course.first(:conditions=>{:id=>@object.course_id})
    if @object.save
      redirect_to("/school/#{@object.course_id}/enroll_thankyou")
    else
      if @object.security_answer_invalid
        @object.security_answer = ''
        @object.security_question_id = rand(RCaptcha::QUESTIONS.size)
      end
      @security_question = RCaptcha::QUESTIONS[@object.security_question_id.to_i]
      @course = Course.first(:conditions=>{:published=>true,:active=>true,:id=>params[:id]})
      @page   = Page.first(:conditions=>{:app_segment_id=>AppSegment::HOME_STUFF,:published=>true,:active=>true,:name=>'enroll'})
      render :action => :enroll
    end  
  end
  
  def enroll_thankyou
    @enrollment = Enrollment.first(:conditions=>{:id=>params[:id]})
    if @enrollment
      @course = Course.first(:conditions=>{:published=>true,:active=>true,:id=>@enrollment.id})
      @page   = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'enroll_thankyou'})
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def quiz # edit
    # TODO: check for eligibility?
    @id   = params[:id]

    # quiz will be the base of result/answers creation
    @quiz = Quiz.first(:conditions=>{:published=>true,:active=>true,:id=>@id})
    if @quiz
      @lecture = @quiz.lecture # get lecture ifo
      @course  = @quiz.course  # get course info
    end

    # get the additional page content, if any
    @page    = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>"quiz_#{@quiz_id}"})
    @page    = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'quiz'}) unless @page
    
    # create form objects
    @object  = Result.create_from(@quiz,current_user) # will display and harvest quiz results & answers
    #@answers = Answer.arr_of_new_from(@quiz,current_user)  # will display and harvest quiz answers
  end
  
  def quiz_submit # update
    @object = Result.find(params[:id])
    if @object.update_attributes(params[:result])
      redirect_to(:action=>:quiz_thankyou,:id=>@object.id)
    end
  end
  
  def quiz_thankyou
    @object  = Result.first(:conditions=>{:id=>params[:id]})
    if @object
      @user    = @object.user
      @course  = @object.course
      @lecture = @object.lecture
      @page    = Page.first(:conditions=>{:published=>true,:active=>true,:app_segment_id=>AppSegment::SCHOOL,:code=>'quiz_thanks'})
    
      @object.evaluate_answers
      @object.calculate_score
    end # if object
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
