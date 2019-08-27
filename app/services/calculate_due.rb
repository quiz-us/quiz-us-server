# frozen_string_literal: true

# CalculateDue uses the SuperMemo-2 Algorithm (https://www.supermemo.com/en/archives1990-2015/english/ol/sm2)
# to calculate when a card should be reviewed again.
# Additional resources used: http://www.blueraja.com/blog/477/a-better-spaced-repetition-learning-algorithm-sm2
class CalculateDue
  include Callable

  attr_reader :score, :card, :current_e_factor, :current_consecutive_correct

  def initialize(score, card)
    @score = score
    @card = card
    @current_e_factor = card.e_factor
    @current_consecutive_correct = card.num_consecutive_correct
  end

  def call
    updated_e_factor = calculate_e_factor
    next_due = calculate_next_due_date(updated_e_factor)
    consecutive_correct = calculate_consecutive_correct
    num_correct = card.total_correct
    updated_total_correct = score >= 3 ? num_correct + 1 : num_correct
    card.update!(
      e_factor: updated_e_factor,
      next_due: next_due,
      num_consecutive_correct: consecutive_correct,
      total_correct: updated_total_correct,
      total_attempts: card.total_attempts + 1
    )
  end

  private

  def calculate_e_factor
    updated_e_factor = current_e_factor - 0.8 + (0.28 * score) - (0.02 * score * score)
    updated_e_factor < 1.3 ? 1.3 : updated_e_factor
  end

  def calculate_next_due_date(updated_e_factor)
    if current_consecutive_correct.zero? || score < 3
      1.day.from_now
    else
      # a card is considered to have been answered "correctly" if
      # score is greater than 3
      num = 6 * updated_e_factor**current_consecutive_correct
      num = num.round
      num.days.from_now
    end
  end

  def calculate_consecutive_correct
    # reset consecutive_correct if card was answered incorrectly;
    # otherwise increment:
    score < 3 ? 0 : current_consecutive_correct + 1
  end
end
