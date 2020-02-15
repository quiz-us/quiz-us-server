# frozen_string_literal: true

# CalculateDue uses the SuperMemo-2 Algorithm (https://www.supermemo.com/en/archives1990-2015/english/ol/sm2)
# to calculate when a student should review a question again.
# Additional resources used: http://www.blueraja.com/blog/477/a-better-spaced-repetition-learning-algorithm-sm2
class CalculateDue
  include Callable

  attr_reader :score, :answered_correctly, :student_question_performance,
              :num_consecutive_correct

  # When larger, the delays for a students_question's next_due will increase
  # whenever answered correctly:
  THETA = 0.75

  def initialize(score, student_id, question_id)
    @score = score
    @answered_correctly = score >= Response::MIN_CORRECT_SCORE
    @student_question_performance = StudentsQuestion.find_or_create_by!(
      student_id: student_id,
      question_id: question_id
    )
    @num_consecutive_correct =
      @student_question_performance.num_consecutive_correct
  end

  def call
    updated_e_factor = calculate_e_factor
    next_due = calculate_next_due_date(updated_e_factor)
    num_correct = student_question_performance.total_correct
    updates = {
      e_factor: updated_e_factor,
      next_due: next_due,
      num_consecutive_correct: calculate_consecutive_correct,
      total_correct: answered_correctly ? num_correct + 1 : num_correct,
      total_attempts: student_question_performance.total_attempts + 1
    }
    student_question_performance.update!(updates)
    updates
  end

  private

  def calculate_e_factor
    current_e_factor = student_question_performance.e_factor
    updated_e_factor =
      current_e_factor - 0.8 + (0.28 * score) - (0.02 * score * score)
    updated_e_factor < 1.3 ? 1.3 : updated_e_factor.round(2)
  end

  def calculate_next_due_date(updated_e_factor)
    if answered_correctly
      # IMPORTANT: at this point, num_consecutive_correct has not yet been
      # incremented to account for the student answering correctly on this
      # attempt:
      return 1.day.from_now if num_consecutive_correct.zero?

      num = 6 * updated_e_factor**((num_consecutive_correct - 1) * THETA)
      num = num.ceil
      num.days.from_now
    else
      Time.current
    end
  end

  def calculate_consecutive_correct
    # reset consecutive_correct if student_question_performance was answered
    # incorrectly. Otherwise, increment:
    answered_correctly ? num_consecutive_correct + 1 : 0
  end
end
