module SchoolHelper
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def is_enrolled_in(course_id)
    b = false
    if current_user
      if Enrollment.first(:conditions=>{:user_id=>current_user.id,:course_id=>course_id,:active=>true})
        b = true
      end
    end # if current_user
    return b
  end
  
  def is_eligible_for(quiz)
    b = false
    if current_user && quiz
      b = true
    end
    return b
  end
  
  def passed_quiz(quiz)
    b = false
    if current_user && quiz
    end
    return b
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end